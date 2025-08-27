import 'package:delivery_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import '../../logger/app_logger.dart';

class ErrorInterceptor extends Interceptor {
  final Future<String?> Function()? onRefreshToken;

  ErrorInterceptor({this.onRefreshToken});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.e("❌ Error: ${err.message}", err, err.stackTrace);

   if (err.response?.statusCode == 401) {
      handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: UnauthorizedException("Unauthorized"),
      ));
    } else {
      handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: ServerException("Server error: ${err.message}"),
      ));
    }
  }
}
