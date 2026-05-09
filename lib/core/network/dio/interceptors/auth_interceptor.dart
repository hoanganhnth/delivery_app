import 'dart:async';
import 'package:dio/dio.dart';
import '../../../constants/api_constants.dart';
import '../../../error/exceptions.dart';
import '../../../utils/logger/app_logger.dart';
import '../token_storage.dart';

class _PendingRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;
  final ErrorInterceptorHandler handler;

  _PendingRequest({
    required this.requestOptions,
    required this.completer,
    required this.handler,
  });
}

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage? tokenStorage;
  final void Function()? onUnauthorized;

  bool _isRefreshing = false;
  final _pendingRequests = <_PendingRequest>[];

  AuthInterceptor({
    required this.dio,
    this.tokenStorage,
    this.onUnauthorized,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (tokenStorage != null) {
      final token = await tokenStorage!.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }
    options.headers["App-Version"] = "1.0.0";
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only handle 401 Unauthorized
    if (err.response?.statusCode == 401 && tokenStorage != null) {
      
      // If a refresh is already in progress, queue this request
      if (_isRefreshing) {
        final completer = Completer<Response>();
        _pendingRequests.add(_PendingRequest(
          requestOptions: err.requestOptions,
          completer: completer,
          handler: handler,
        ));
        
        // Wait for the token to be refreshed
        try {
          final response = await completer.future;
          return handler.resolve(response);
        } catch (e) {
          if (e is DioException) {
            return handler.reject(e);
          } else {
            return handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: e,
            ));
          }
        }
      }

      // Start token refresh
      _isRefreshing = true;
      AppLogger.d("🔐 Starting token refresh...");

      try {
        final refreshToken = await tokenStorage!.getRefreshToken();
        
        if (refreshToken == null || refreshToken.isEmpty) {
          _handleUnauthorized(err, handler, "No refresh token available");
          return;
        }

        // Use a new Dio instance to avoid interceptor loops
        final refreshDio = Dio(dio.options);
        final refreshResponse = await refreshDio.post(
          ApiConstants.refreshToken,
          data: {'refreshToken': refreshToken},
        );

        if (refreshResponse.statusCode == 200 && refreshResponse.data != null) {
          final data = refreshResponse.data['data'];
          if (data != null) {
            final newAccessToken = data['accessToken'];
            final newRefreshToken = data['refreshToken'];

            if (newAccessToken != null && newRefreshToken != null) {
              await tokenStorage!.saveTokens(
                accessToken: newAccessToken,
                refreshToken: newRefreshToken,
              );

              AppLogger.i("✅ Token refreshed successfully, resuming ${_pendingRequests.length} queued requests");
              
              // Retry the original request that triggered the 401
              err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
              final response = await dio.fetch(err.requestOptions);
              handler.resolve(response);

              // Retry all pending requests
              for (final pending in _pendingRequests) {
                pending.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
                try {
                  final res = await dio.fetch(pending.requestOptions);
                  pending.completer.complete(res);
                } catch (e) {
                  pending.completer.completeError(e);
                }
              }
              return;
            }
          }
        }
        
        _handleUnauthorized(err, handler, "Refresh token response invalid");
      } catch (e, st) {
        _handleUnauthorized(err, handler, "Token refresh failed: $e", st);
      } finally {
        _pendingRequests.clear();
        _isRefreshing = false;
      }
    } else {
      // For any other error (or no refresh logic), just pass it down
      if (err.response?.statusCode == 401) {
        onUnauthorized?.call();
      }
      handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: ServerException("Server error: ${err.message}"),
        response: err.response,
        type: err.type,
      ));
    }
  }

  void _handleUnauthorized(DioException err, ErrorInterceptorHandler handler, String reason, [StackTrace? st]) {
    AppLogger.w("⚠️ $reason, rejecting ${_pendingRequests.length} queued requests");
    
    final unauthorizedError = DioException(
      requestOptions: err.requestOptions,
      error: UnauthorizedException("Unauthorized - $reason"),
      response: err.response,
      type: DioExceptionType.badResponse,
      stackTrace: st,
    );

    // Reject all queued requests
    for (final pending in _pendingRequests) {
      pending.completer.completeError(unauthorizedError);
    }
    
    // Clear storage and trigger callback
    tokenStorage?.clearTokens();
    onUnauthorized?.call();
    
    // Reject original request
    handler.reject(unauthorizedError);
  }
}
