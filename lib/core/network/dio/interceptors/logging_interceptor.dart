import 'package:dio/dio.dart';

import '../../../utils/logger/app_logger.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.d('--> ${options.method} ${_safeUri(options)}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final request = response.requestOptions;
    AppLogger.i(
      '<-- ${response.statusCode} ${request.method} ${_safeUri(request)}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final request = err.requestOptions;
    AppLogger.e(
      '<-- ${err.response?.statusCode ?? 'NETWORK'} '
      '${request.method} ${_safeUri(request)} (${err.type.name})',
    );
    handler.next(err);
  }

  String _safeUri(RequestOptions options) {
    return options.uri.replace(query: '', fragment: '').toString();
  }
}
