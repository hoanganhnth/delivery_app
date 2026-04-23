import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'authenticated_network_providers.dart';
import 'network_providers.dart';
import '../i_http_client.dart';
import '../dio_http_client_impl.dart';

part 'http_client_provider.g.dart';

/// Unauthenticated HTTP client
@Riverpod(keepAlive: true)
IHttpClient httpClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return DioHttpClientImpl(dio);
}

/// Authenticated HTTP client
@Riverpod(keepAlive: true)
IHttpClient authenticatedHttpClient(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return DioHttpClientImpl(dio);
}
