import 'package:dio/dio.dart';

import '../../../debug/debug_log_store.dart';
import '../../../utils/logger/app_logger.dart';

class LoggingInterceptor extends Interceptor {
  static const _startedAtKey = 'debugRequestStartedAt';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAtKey] = DateTime.now();
    DebugLogStore.instance.recordApi(
      phase: DebugApiPhase.request,
      method: options.method,
      url: _safeUri(options),
    );
    AppLogger.d('--> ${options.method} ${_safeUri(options)}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final request = response.requestOptions;
    DebugLogStore.instance.recordApi(
      phase: DebugApiPhase.response,
      method: request.method,
      url: _safeUri(request),
      statusCode: response.statusCode,
      durationMs: _durationMs(request),
    );
    AppLogger.i(
      '<-- ${response.statusCode} ${request.method} ${_safeUri(request)}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final request = err.requestOptions;
    DebugLogStore.instance.recordApi(
      phase: DebugApiPhase.error,
      method: request.method,
      url: _safeUri(request),
      statusCode: err.response?.statusCode,
      durationMs: _durationMs(request),
      error: err.message ?? err.type.name,
    );
    AppLogger.e(
      '<-- ${err.response?.statusCode ?? 'NETWORK'} '
      '${request.method} ${_safeUri(request)} (${err.type.name})',
    );
    handler.next(err);
  }

  String _safeUri(RequestOptions options) {
    return options.uri.replace(query: '', fragment: '').toString();
  }

  int? _durationMs(RequestOptions options) {
    final startedAt = options.extra[_startedAtKey];
    if (startedAt is! DateTime) return null;
    return DateTime.now().difference(startedAt).inMilliseconds;
  }
}
