  import 'package:delivery_app/core/error/exceptions.dart';
  import 'package:dio/dio.dart';
  import 'dart:async';
  import '../../../utils/logger/app_logger.dart';

class ErrorInterceptor extends QueuedInterceptor {
  final Future<String?> Function()? onRefreshToken;
  final BaseOptions? baseOptions;

  // Token refresh state management
  bool _isRefreshing = false;
  final _requestQueue = <Completer<String?>>[];

  ErrorInterceptor({this.onRefreshToken, this.baseOptions});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.e("❌ Error: ${err.message}", err, err.stackTrace);

    // Handle 401 Unauthorized with token refresh
    if (err.response?.statusCode == 401 && onRefreshToken != null) {
      if (_isRefreshing) {
        // TRƯỜNG HỢP 2: Nếu đã có thằng đang đi refresh rồi
        // Tạo một "lời hứa" (Completer) và bắt request này đợi ở đây
        final completer = Completer<String?>();
        _requestQueue.add(completer);

        final newToken = await completer.future;
        if (newToken != null && newToken.isNotEmpty) {
          try {
            // Khi đã có token mới, cập nhật header và gửi lại request
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';
            final dio = Dio(baseOptions);
            final cloneReq = await dio.fetch(options);
            return handler.resolve(cloneReq);
          } catch (retryError) {
            return handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: retryError,
              response: err.response,
              type: DioExceptionType.unknown,
            ));
          }
        } else {
          return handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: UnauthorizedException("Unauthorized - refresh token failed"),
            response: err.response,
            type: DioExceptionType.badResponse,
          ));
        }
      }

      // TRƯỜNG HỢP 1: Thằng đầu tiên phát hiện token hết hạn
      _isRefreshing = true;
      AppLogger.d("🔐 Starting token refresh...");

      try {
        final newToken = await onRefreshToken!.call();
        
        _isRefreshing = false;

        if (newToken != null && newToken.isNotEmpty) {
          AppLogger.i("✅ Token refreshed successfully, resuming ${_requestQueue.length} queued requests");
          // Giải phóng hàng chờ: Báo cho tất cả thằng đang đợi là đã có token mới
          for (final completer in _requestQueue) {
            completer.complete(newToken);
          }
          _requestQueue.clear();

          // Chạy lại chính cái request bị lỗi ban đầu
          try {
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final dio = Dio(baseOptions);
            final cloneReq = await dio.fetch(err.requestOptions);
            return handler.resolve(cloneReq);
          } catch (retryError) {
            return handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: retryError,
              response: err.response,
              type: DioExceptionType.unknown,
            ));
          }
        } else {
          AppLogger.w("⚠️ Token refresh returned null/empty, rejecting ${_requestQueue.length} queued requests");
          for (final completer in _requestQueue) {
            completer.complete(null);
          }
          _requestQueue.clear();
          
          return handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: UnauthorizedException("Unauthorized - refresh token failed"),
            response: err.response,
            type: DioExceptionType.badResponse,
          ));
        }
      } catch (e, st) {
        _isRefreshing = false;
        AppLogger.e("❌ Token refresh failed", e, st);
        
        for (final completer in _requestQueue) {
          completer.complete(null);
        }
        _requestQueue.clear();
        
        return handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: UnauthorizedException("Unauthorized - refresh exception: $e"),
          response: err.response,
          type: DioExceptionType.badResponse,
          stackTrace: st,
        ));
      }
    }

    // Not 401 or no refresh callback
    return handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: ServerException("Server error: ${err.message}"),
      response: err.response,
      type: err.type,
    ));
  }
}
