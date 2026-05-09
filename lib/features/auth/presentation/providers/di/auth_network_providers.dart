import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/network/dio/dio_client.dart';
import '../../../../../core/network/dio/token_storage.dart';
import '../../../../../core/usecases/usecase.dart';
import '../session/auth_notifier.dart';
import 'storage_di_providers.dart';

part 'auth_network_providers.g.dart';

class _AuthTokenStorage implements TokenStorage {
  final Ref ref;
  _AuthTokenStorage(this.ref);

  @override
  Future<String?> getAccessToken() async {
    return ref.read(authProvider).accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    return ref.read(authProvider).refreshToken;
  }

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await ref.read(authProvider.notifier).loginWithTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<void> clearTokens() async {
    // Chỉ thực hiện xóa token ở tầng Storage, không can thiệp vào App Flow
    // (Việc logout/điều hướng sẽ do onUnauthorized callback đảm nhận)
    await ref.read(clearTokensUseCaseProvider)(NoParams());
  }
}

/// Auth-aware Dio provider that includes authentication
/// This provider will be used by other features that need authenticated requests
@Riverpod(keepAlive: true)
Dio authAwareDio(Ref ref) {
  final authNotifier = ref.read(authProvider.notifier);
  
  final dioClient = DioClient(
    tokenStorage: _AuthTokenStorage(ref),
    onUnauthorized: () {
      authNotifier.logout();
    },
  );
  return dioClient.dio;
}
