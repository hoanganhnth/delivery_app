import 'package:dio/dio.dart';
import '../../../utils/logger/app_logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d("--> ${options.method} ${options.baseUrl}${options.path}");
    AppLogger.d("Headers: ${options.headers}");
    AppLogger.d("Data: ${options.data}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.i("<-- ${response.statusCode} ${response.requestOptions.uri}");
    AppLogger.d("Response: ${response.data}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e("<-- Error ${err.response?.statusCode} ${err.requestOptions.uri}", err);
    AppLogger.d("Error details: ${err.response?.data}");
    handler.next(err);
  }
}
