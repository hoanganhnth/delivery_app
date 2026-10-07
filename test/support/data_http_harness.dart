import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

/// A real Dio/Retrofit pipeline with recorded wire requests and no network.
class DataHttpHarness {
  DataHttpHarness() {
    adapter = DioAdapter(dio: dio);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          requests.add(request);
          if (timeout) {
            handler.reject(
              DioException(
                requestOptions: request,
                type: DioExceptionType.receiveTimeout,
              ),
            );
          } else {
            handler.next(request);
          }
        },
      ),
    );
  }

  final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
  late final DioAdapter adapter;
  final requests = <RequestOptions>[];
  bool timeout = false;

  void reply(String method, String path, Object? data, {int code = 200}) {
    switch (method) {
      case 'GET':
        adapter.onGet(path, (server) => server.reply(code, data));
      case 'POST':
        adapter.onPost(
          path,
          (server) => server.reply(code, data),
          data: Matchers.any,
        );
      case 'PUT':
        adapter.onPut(
          path,
          (server) => server.reply(code, data),
          data: Matchers.any,
        );
      default:
        throw ArgumentError(method);
    }
  }
}

Map<String, dynamic> dataEnvelope(Object? data, {int status = 1}) => {
  'status': status,
  'message': status == 1 ? 'Success' : 'Rejected',
  'data': data,
};
