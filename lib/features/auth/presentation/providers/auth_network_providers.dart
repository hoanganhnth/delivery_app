import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/authenticated_network_providers.dart';
import '../../../../core/network/dio_client.dart';
import 'auth_providers.dart';

/// Auth-aware Dio provider that includes authentication
/// This provider will be used by other features that need authenticated requests
final authAwareDioProvider = Provider<Dio>((ref) {
  final dioClient = DioClient(
    getToken: () async {
      // Get token from auth state
      final authState = ref.read(authStateProvider);
      return authState.accessToken;
    },
    onRefreshToken: () async {
      // Handle token refresh
      try {
        final authNotifier = ref.read(authStateProvider.notifier);
        // final updatedAuthState = ref.read(authStateProvider);
        // print("access1: + ${updatedAuthState.accessToken}");
       final access =  await authNotifier.refreshToken();

        // Get the new access token from updated state
        // print("access2: + ${access}");

        return access;
      } catch (e) {
        return null;
      }
    },
  );
  return dioClient.dio;
});

/// Provider scope overrides for the entire app
/// Use this in your main app to enable authenticated networking
List<Override> getAppProviderOverrides() {
  return [
    // Override the global authenticated dio with auth-aware implementation
    authenticatedDioProvider.overrideWith(
      (ref) => ref.watch(authAwareDioProvider),
    ),
  ];
}
