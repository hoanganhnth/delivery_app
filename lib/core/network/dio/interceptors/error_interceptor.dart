import 'package:delivery_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import '../../../logger/app_logger.dart';

class ErrorInterceptor extends Interceptor {
  final Future<String?> Function()? onRefreshToken;
  final BaseOptions? baseOptions;

  ErrorInterceptor({this.onRefreshToken, this.baseOptions});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.e("❌ Error: ${err.message}", err, err.stackTrace);

    if (err.response?.statusCode == 401 && onRefreshToken != null) {
      try {
        // 1. Gọi refresh token API
        final newAccessToken = await onRefreshToken!.call();

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          // 2. Gán lại header token mới
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          // 3. Retry request cũ với new instance của Dio sử dụng baseOptions gốc
          final dio = Dio(baseOptions);
          final cloneReq = await dio.fetch(err.requestOptions);
          return handler.resolve(cloneReq);
        } else {
          // refresh thất bại -> trả về 401 error
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
      // Không phải lỗi 401 hoặc không có refresh callback
      handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: ServerException("Server error: ${err.message}"),
        response: err.response,
        type: err.type,
      ));
    }
  }
}
