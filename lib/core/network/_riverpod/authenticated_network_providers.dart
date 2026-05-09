import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../dio/dio_client.dart';
import '../dio/token_storage.dart';

part 'authenticated_network_providers.g.dart';

/// Provider for authenticated Dio instance
/// This should be overridden by features that need authentication
@Riverpod(keepAlive: true)
Dio authenticatedDio(Ref ref) {
  // Default implementation without authentication
  // This should be overridden by auth module
  final dioClient = DioClient();
  return dioClient.dio;
}

/// Factory function to create authenticated Dio with auth callbacks
Dio createAuthenticatedDio({
  required TokenStorage tokenStorage,
  void Function()? onUnauthorized,
}) {
  final dioClient = DioClient(
    tokenStorage: tokenStorage,
    onUnauthorized: onUnauthorized,
  );
  return dioClient.dio;
}
