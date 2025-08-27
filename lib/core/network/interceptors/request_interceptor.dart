import 'package:dio/dio.dart';
import '../../logger/app_logger.dart';

class RequestInterceptor extends Interceptor {
  final Future<String?> Function()? getToken;

  RequestInterceptor({this.getToken});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getToken?.call();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    options.headers["App-Version"] = "1.0.0";

    AppLogger.d("--> ${options.method} ${options.baseUrl}${options.path}");
    AppLogger.d("Headers: ${options.headers}");
    AppLogger.d("Data: ${options.data}");

    handler.next(options);
  }
}
