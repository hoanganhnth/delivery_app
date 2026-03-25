import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dio_client.dart';

part 'authenticated_network_providers.g.dart';

/// Provider for authenticated Dio instance
/// This should be overridden by features that need authentication
/// 
/// Usage example:
/// ```dart
/// // In auth module, override this provider
/// @riverpod
/// Dio authenticatedDio(Ref ref) {
///   final dioClient = DioClient(
///     getToken: () async {
///       final authState = ref.read(authProvider);
///       return authState.user?.accessToken;
///     },
///     onRefreshToken: () async {
///       final authNotifier = ref.read(authProvider.notifier);
///       return await authNotifier.refreshToken();
///     },
///   );
///   return dioClient.dio;
/// }
/// ```
@riverpod
Dio authenticatedDio(Ref ref) {
  // Default implementation without authentication
  // This should be overridden by auth module
  final dioClient = DioClient();
  return dioClient.dio;
}

/// Factory function to create authenticated Dio with auth callbacks
Dio createAuthenticatedDio({
  required Future<String?> Function() getToken,
  required Future<String?> Function() onRefreshToken,
}) {
  final dioClient = DioClient(
    getToken: getToken,
    onRefreshToken: onRefreshToken,
  );
  return dioClient.dio;
}
