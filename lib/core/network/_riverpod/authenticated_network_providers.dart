import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../config/api_endpoint_controller.dart';
import '../dio/dio_client.dart';
import '../dio/token_storage.dart';

part 'authenticated_network_providers.g.dart';

/// Provider for authenticated Dio instance
/// This should be overridden by features that need authentication
@Riverpod(keepAlive: true)
Dio authenticatedDio(Ref ref) {
  // Default implementation without authentication
  // This should be overridden by auth module
  final dioClient = DioClient(
    endpointController: ref.watch(apiEndpointControllerProvider),
  );
  ref.onDispose(dioClient.dispose);
  return dioClient.dio;
}

/// Factory function to create authenticated Dio with auth callbacks
Dio createAuthenticatedDio({
  required TokenStorage tokenStorage,
  FutureOr<void> Function()? onUnauthorized,
  ApiEndpointController? endpointController,
}) {
  final dioClient = DioClient(
    tokenStorage: tokenStorage,
    onUnauthorized: onUnauthorized,
    endpointController: endpointController,
  );
  return dioClient.dio;
}
