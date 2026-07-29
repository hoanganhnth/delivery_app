import 'dart:async';

import 'package:dio/dio.dart';

import '../../../constants/api_constants.dart';
import '../../../error/exceptions.dart';
import '../../../utils/logger/app_logger.dart';
import '../token_storage.dart';

typedef UnauthorizedCallback = FutureOr<void> Function();

class _PendingRequest {
  final RequestOptions requestOptions;
  final Completer<Response<dynamic>> completer;

  _PendingRequest({required this.requestOptions, required this.completer});
}

class AuthInterceptor extends Interceptor {
  static const skipAuthRefreshKey = 'skipAuthRefresh';
  static const _authRetryKey = 'authRetry';

  static const _publicAuthPaths = <String>{
    ApiConstants.login,
    ApiConstants.register,
    ApiConstants.socialLogin,
    ApiConstants.refreshToken,
  };

  final Dio dio;
  final Dio? refreshDio;
  final TokenStorage? tokenStorage;
  final UnauthorizedCallback? onUnauthorized;

  bool _isRefreshing = false;
  bool _unauthorizedNotified = false;
  final _pendingRequests = <_PendingRequest>[];

  AuthInterceptor({
    required this.dio,
    this.refreshDio,
    this.tokenStorage,
    this.onUnauthorized,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (tokenStorage != null) {
      final token = await tokenStorage!.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        _unauthorizedNotified = false;
      }
    }
    options.headers['App-Version'] = '1.0.0';
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldAttemptRefresh(err)) {
      handler.next(err);
      return;
    }

    if (err.requestOptions.extra[_authRetryKey] == true) {
      await _handleUnauthorized(
        err,
        handler,
        'Request remained unauthorized after token refresh',
      );
      return;
    }

    if (_isRefreshing) {
      final completer = Completer<Response<dynamic>>();
      _pendingRequests.add(
        _PendingRequest(
          requestOptions: err.requestOptions,
          completer: completer,
        ),
      );

      try {
        handler.resolve(await completer.future);
      } on DioException catch (error) {
        handler.reject(error);
      } catch (error) {
        handler.reject(
          DioException(requestOptions: err.requestOptions, error: error),
        );
      }
      return;
    }

    _isRefreshing = true;
    AppLogger.d('Starting token refresh');

    try {
      final refreshToken = await tokenStorage!.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        await _handleUnauthorized(err, handler, 'No refresh token available');
        return;
      }

      final refreshResponse = await (refreshDio ?? Dio(dio.options))
          .post<dynamic>(
            ApiConstants.refreshToken,
            data: {'refreshToken': refreshToken},
          );
      final responseData = refreshResponse.data;
      final tokenData = responseData is Map<String, dynamic>
          ? responseData['data']
          : null;
      final newAccessToken = tokenData is Map<String, dynamic>
          ? tokenData['accessToken']
          : null;
      final newRefreshToken = tokenData is Map<String, dynamic>
          ? tokenData['refreshToken']
          : null;

      if (newAccessToken is! String ||
          newAccessToken.isEmpty ||
          newRefreshToken is! String ||
          newRefreshToken.isEmpty) {
        await _handleUnauthorized(
          err,
          handler,
          'Refresh token response invalid',
        );
        return;
      }

      await tokenStorage!.saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );
      _unauthorizedNotified = false;

      handler.resolve(await _retry(err.requestOptions, newAccessToken));

      final pendingRequests = List<_PendingRequest>.of(_pendingRequests);
      _pendingRequests.clear();
      for (final pending in pendingRequests) {
        try {
          pending.completer.complete(
            await _retry(pending.requestOptions, newAccessToken),
          );
        } on Object catch (error, stackTrace) {
          pending.completer.completeError(error, stackTrace);
        }
      }
    } on DioException catch (error, stackTrace) {
      if (error.error is UnauthorizedException) {
        handler.reject(error);
        return;
      }
      await _handleUnauthorized(
        err,
        handler,
        'Token refresh failed (${error.type.name})',
        stackTrace,
      );
    } catch (error, stackTrace) {
      await _handleUnauthorized(
        err,
        handler,
        'Token refresh failed',
        stackTrace,
      );
    } finally {
      _isRefreshing = false;
    }
  }

  bool _shouldAttemptRefresh(DioException err) {
    if (err.response?.statusCode != 401 || tokenStorage == null) {
      return false;
    }
    if (_unauthorizedNotified) {
      return false;
    }
    if (err.requestOptions.extra[skipAuthRefreshKey] == true) {
      return false;
    }
    if (_publicAuthPaths.contains(err.requestOptions.path)) {
      return false;
    }

    final authorization = err.requestOptions.headers['Authorization'];
    return authorization is String && authorization.startsWith('Bearer ');
  }

  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions,
    String accessToken,
  ) {
    requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    requestOptions.extra[_authRetryKey] = true;
    return dio.fetch<dynamic>(requestOptions);
  }

  Future<void> _handleUnauthorized(
    DioException err,
    ErrorInterceptorHandler handler,
    String reason, [
    StackTrace? stackTrace,
  ]) async {
    AppLogger.w(
      '$reason; rejecting ${_pendingRequests.length} queued request(s)',
    );

    final unauthorizedError = DioException(
      requestOptions: err.requestOptions,
      error: UnauthorizedException('Unauthorized'),
      response: err.response,
      type: DioExceptionType.badResponse,
      stackTrace: stackTrace,
    );

    await tokenStorage!.clearTokens();
    if (!_unauthorizedNotified) {
      _unauthorizedNotified = true;
      await onUnauthorized?.call();
    }

    final pendingRequests = List<_PendingRequest>.of(_pendingRequests);
    _pendingRequests.clear();
    for (final pending in pendingRequests) {
      pending.completer.completeError(
        DioException(
          requestOptions: pending.requestOptions,
          error: const UnauthorizedException('Unauthorized'),
          response: err.response,
          type: DioExceptionType.badResponse,
          stackTrace: stackTrace,
        ),
        stackTrace,
      );
    }

    handler.reject(unauthorizedError);
  }
}
