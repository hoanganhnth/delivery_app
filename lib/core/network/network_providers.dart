import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dio_client.dart';

/// Global Dio provider for the entire app
/// This should be used by all features that need HTTP client
final dioProvider = Provider<Dio>((ref) {
  // Create DioClient without auth dependencies to avoid circular reference
  final dioClient = DioClient();
  return dioClient.dio;
});

/// Authenticated Dio provider that includes auth token handling
/// This will be configured later when auth providers are available
// final authenticatedDioProvider = Provider<Dio>((ref) {
//   // This will be overridden by auth module when needed
//   // For now, return the basic dio instance
//   return ref.watch(dioProvider);
// });

/// Provider for base URL configuration
final baseUrlProvider = Provider<String>((ref) {
  // You can make this configurable based on environment
  return "http://localhost:8079/api";
});

/// Provider for network timeout configuration
final networkTimeoutProvider = Provider<Duration>((ref) {
  return const Duration(seconds: 10);
});
