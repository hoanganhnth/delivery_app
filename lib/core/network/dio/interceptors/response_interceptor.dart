import 'package:dio/dio.dart';
import '../../../logger/app_logger.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
      AppLogger.i("<-- ${response.statusCode} ${response.requestOptions.uri}");
      AppLogger.d("Response: ${response.data}");
    handler.next(response);
  }
}
