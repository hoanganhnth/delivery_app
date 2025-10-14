import 'package:delivery_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import '../../../logger/app_logger.dart';

class ErrorInterceptor extends Interceptor {
  final Future<String?> Function()? onRefreshToken;
  final BaseOptions? baseOptions;

  // Token refresh state management
  bool _isRefreshing = false;
  final List<Completer<String?>> _refreshQueue = [];

  ErrorInterceptor({this.onRefreshToken, this.baseOptions});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.e("❌ Error: ${err.message}", err, err.stackTrace);

    // Handle 401 Unauthorized with token refresh
    if (err.response?.statusCode == 401 && onRefreshToken != null) {
      try {
        // Get new access token (with queue management)
        final newAccessToken = await _handleTokenRefresh();

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          // Update request header with new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          // Retry original request with new token
          final dio = Dio(baseOptions);
          final cloneReq = await dio.fetch(err.requestOptions);
          return handler.resolve(cloneReq);
        } else {
          // Refresh failed - return 401
          AppLogger.e("Refresh token failed - no new access token");
          handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: UnauthorizedException("Unauthorized - refresh token failed"),
            response: err.response,
            type: DioExceptionType.badResponse,
          ));
        }
      } catch (e, st) {
        AppLogger.e("Exception during token refresh: $e", e, st);
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: UnauthorizedException("Unauthorized - refresh exception: $e"),
          response: err.response,
          type: DioExceptionType.badResponse,
          stackTrace: st,
        ));
      }
    } else {
      // Not 401 or no refresh callback
      handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: ServerException("Server error: ${err.message}"),
        response: err.response,
        type: err.type,
      ));
    }
  }

  /// Handle token refresh with queue management
  /// - Only one refresh happens at a time
  /// - Other requests wait for the refresh to complete
  Future<String?> _handleTokenRefresh() async {
    // If already refreshing, wait in queue
    if (_isRefreshing) {
      AppLogger.d("🔄 Token refresh in progress, queuing request...");
      final completer = Completer<String?>();
      _refreshQueue.add(completer);
      return completer.future;
    }

    // Start refresh process
    _isRefreshing = true;
    AppLogger.d("🔐 Starting token refresh...");

    try {
      // Call refresh token API
      final newAccessToken = await onRefreshToken!.call();

      // Resolve all queued requests with new token
      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        AppLogger.i("✅ Token refreshed successfully, resuming ${_refreshQueue.length} queued requests");
        for (final completer in _refreshQueue) {
          completer.complete(newAccessToken);
        }
      } else {
        AppLogger.w("⚠️ Token refresh returned null/empty, rejecting ${_refreshQueue.length} queued requests");
        for (final completer in _refreshQueue) {
          completer.complete(null);
        }
      }

      return newAccessToken;
    } catch (e, st) {
      AppLogger.e("❌ Token refresh failed", e, st);
      
      // Reject all queued requests
      for (final completer in _refreshQueue) {
        completer.completeError(e, st);
      }
      
      rethrow;
    } finally {
      // Reset state
      _refreshQueue.clear();
      _isRefreshing = false;
      AppLogger.d("🔓 Token refresh process completed");
    }
  }
}
