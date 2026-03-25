import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio/dio_client.dart';
import 'auth_notifier.dart';

part 'auth_network_providers.g.dart';

/// Auth-aware Dio provider that includes authentication
/// This provider will be used by other features that need authenticated requests
@riverpod
Dio authAwareDio(Ref ref) {
  final dioClient = DioClient(
    getToken: () async {
      // Get token from auth state
      final authState = ref.read(authProvider);
      return authState.accessToken;
    },
    onRefreshToken: () async {
      // Handle token refresh
      try {
        final authNotifier = ref.read(authProvider.notifier);
        final access = await authNotifier.refreshToken();
        return access;
      } catch (e) {
        return null;
      }
    },
  );
  return dioClient.dio;
}

/// Provider override for the entire app
/// Use this in your main app to enable authenticated networking
@riverpod
Dio getAuthenticatedDioOverride(Ref ref) {
  return ref.watch(authAwareDioProvider);
}
