import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dio_client.dart';

/// Provider for authenticated Dio instance
/// This should be overridden by features that need authentication
/// 
/// Usage example:
/// ```dart
/// // In auth module, override this provider
/// final authenticatedDioProvider = Provider.override(
///   authenticatedDioProvider,
///   (ref) {
///     final dioClient = DioClient(
///       getToken: () async {
///         final authState = ref.read(authStateProvider);
///         return authState.user?.accessToken;
///       },
///       onRefreshToken: () async {
///         final authNotifier = ref.read(authStateProvider.notifier);
///         return await authNotifier.refreshToken();
///       },
///     );
///     return dioClient.dio;
///   },
/// );
/// ```
final authenticatedDioProvider = Provider<Dio>((ref) {
  // Default implementation without authentication
  // This should be overridden by auth module
  final dioClient = DioClient();
  return dioClient.dio;
});

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
