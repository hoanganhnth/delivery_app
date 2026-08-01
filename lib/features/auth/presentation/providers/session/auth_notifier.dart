import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/social_login_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/store_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/get_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/clear_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:delivery_app/features/auth/presentation/providers/session/auth_state.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/auth_di_providers.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/storage_di_providers.dart';
import 'package:delivery_app/features/auth/services/auth_platform_ports.dart';
import 'package:delivery_app/core/services/app_initializer/_riverpod/app_initializer_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final LoginUseCase _loginUseCase;
  late final SocialLoginUseCase _socialLoginUseCase;
  late final RegisterUseCase _registerUseCase;
  late final RefreshTokenUseCase _refreshTokenUseCase;
  late final StoreTokensUseCase _storeTokensUseCase;
  late final GetTokensUseCase _getTokensUseCase;
  late final ClearTokensUseCase _clearTokensUseCase;
  late final LogoutUseCase _logoutUseCase;
  late final DeviceIdentityPort _deviceIdentity;
  late final SocialIdentityPort _socialIdentity;

  @override
  AuthState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    _socialLoginUseCase = ref.read(socialLoginUseCaseProvider);
    _registerUseCase = ref.read(registerUseCaseProvider);
    _refreshTokenUseCase = ref.read(refreshTokenUseCaseProvider);
    _storeTokensUseCase = ref.read(storeTokensUseCaseProvider);
    _getTokensUseCase = ref.read(getTokensUseCaseProvider);
    _clearTokensUseCase = ref.read(clearTokensUseCaseProvider);
    _logoutUseCase = ref.read(logoutUseCaseProvider);
    _deviceIdentity = ref.read(deviceIdentityPortProvider);
    _socialIdentity = ref.read(socialIdentityPortProvider);
    return const AuthState.initial();
  }

  // Login method
  Future<void> login({
    required String email,
    required String password,
    String? deviceId,
    String? deviceName,
    String? deviceType,
    String? ipAddress,
  }) async {
    if (state.isLoginLoading) return;
    state = const AuthState.unauthenticated(isLoginLoading: true);

    final resolvedDeviceId = deviceId ?? await _deviceIdentity.getDeviceId();

    final params = LoginParams(
      email: email,
      password: password,
      deviceId: resolvedDeviceId,
      deviceName: deviceName ?? _deviceIdentity.deviceName,
      deviceType: deviceType ?? _deviceIdentity.deviceType,
      ipAddress: ipAddress,
    );
    final result = await _loginUseCase(params);

    if (!ref.mounted) return;

    await result.fold(
      (failure) async {
        state = AuthState.unauthenticated(failure: failure);
      },
      (user) async {
        // Store tokens locally
        final storeResult = await _storeTokensUseCase(
          StoreTokensParams(tokens: user),
        );
        storeResult.fold(
          (failure) => AppLogger.e(
            'AuthNotifier: Failed to store tokens - ${failure.message}',
          ),
          (_) => AppLogger.d('AuthNotifier: Tokens stored successfully'),
        );

        if (!ref.mounted) return;
        state = AuthState.authenticated(
          refreshToken: user.refreshToken,
          accessToken: user.accessToken,
        );
      },
    );
  }

  // Google Sign In
  Future<void> loginWithGoogle() async {
    if (state.isLoginLoading) return;
    state = const AuthState.unauthenticated(isLoginLoading: true);

    try {
      final idToken = await _socialIdentity.getGoogleIdToken();

      if (idToken == null) {
        // User canceled the sign-in flow
        if (ref.mounted) {
          state = const AuthState.unauthenticated();
        }
        return;
      }

      final params = SocialLoginParams(
        provider: 'google',
        token: idToken,
        role: 'USER',
        deviceId: await _deviceIdentity.getDeviceId(),
        deviceName: _deviceIdentity.deviceName,
        deviceType: _deviceIdentity.deviceType,
      );

      final result = await _socialLoginUseCase(params);
      if (!ref.mounted) return;

      await result.fold(
        (failure) async {
          state = AuthState.unauthenticated(failure: failure);
        },
        (user) async {
          final storeResult = await _storeTokensUseCase(
            StoreTokensParams(tokens: user),
          );
          storeResult.fold(
            (failure) => AppLogger.e(
              'AuthNotifier: Failed to store tokens - ${failure.message}',
            ),
            (_) => AppLogger.d('AuthNotifier: Tokens stored successfully'),
          );

          if (!ref.mounted) return;
          state = AuthState.authenticated(
            refreshToken: user.refreshToken,
            accessToken: user.accessToken,
          );
        },
      );
    } catch (error) {
      AppLogger.e('Google Sign In Error', error);
      if (ref.mounted) {
        state = AuthState.unauthenticated(
          failure: ServerFailure('Google sign-in error: $error'),
        );
      }
    }
  }

  /// Login with saved tokens (for biometric authentication)
  Future<void> loginWithTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    AppLogger.d('AuthNotifier: Logging in with saved tokens');
    state = const AuthState.unauthenticated(isLoginLoading: true);

    // Store tokens locally
    final storeResult = await _storeTokensUseCase(
      StoreTokensParams(
        tokens: AuthEntity(
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      ),
    );

    if (!ref.mounted) return;

    storeResult.fold(
      (failure) {
        AppLogger.e(
          'AuthNotifier: Failed to store tokens - ${failure.message}',
        );
        state = AuthState.unauthenticated(failure: failure);
      },
      (_) {
        AppLogger.i('AuthNotifier: Logged in with tokens successfully');
        state = AuthState.authenticated(
          refreshToken: refreshToken,
          accessToken: accessToken,
        );
      },
    );
  }

  // Register method - simplified
  Future<bool> register({
    String? name,
    required String email,
    required String password,
    required String confirmPassword,
    String? deviceId,
    String? deviceName,
    String? deviceType,
    String? ipAddress,
  }) async {
    if (state.isRegisterLoading) return false;
    state = const AuthState.unauthenticated(isRegisterLoading: true);

    final params = RegisterParams(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    final result = await _registerUseCase(params);

    if (!ref.mounted) return false;

    return result.fold(
      (failure) {
        state = AuthState.unauthenticated(failure: failure);
        return false;
      },
      (success) {
        state = const AuthState.unauthenticated();
        return success;
      },
    );
  }

  // Logout method
  Future<void> logout() async {
    final refreshToken = state.refreshToken;

    // Run all centralized cleanup tasks (e.g. FCM unregister, clear profile cache)
    try {
      await ref.read(appInitializerServiceProvider).cleanup();
    } catch (e) {
      AppLogger.e('AuthNotifier: Cleanup failed - $e');
    }

    if (refreshToken != null && refreshToken.isNotEmpty) {
      final revokeResult = await _logoutUseCase(
        LogoutParams(refreshToken: refreshToken),
      );
      revokeResult.fold(
        (_) => AppLogger.w('AuthNotifier: Server session revocation failed'),
        (_) => AppLogger.d('AuthNotifier: Server session revoked'),
      );
    }

    // Clear stored tokens
    final clearResult = await _clearTokensUseCase(NoParams());
    clearResult.fold(
      (failure) => AppLogger.e(
        'AuthNotifier: Failed to clear tokens - ${failure.message}',
      ),
      (_) => AppLogger.d('AuthNotifier: Tokens cleared successfully'),
    );

    if (ref.mounted) {
      state = const AuthState.unauthenticated();
    }
  }

  /// Handles an expired/revoked session after the network layer has already
  /// cleared persisted tokens. This path must not make authenticated cleanup
  /// requests because doing so can recursively trigger another 401.
  Future<void> handleUnauthorized() async {
    if (!ref.mounted || !state.isAuthenticated) return;
    state = const AuthState.unauthenticated();
  }

  // Check if user is logged in
  Future<AuthState> checkAuthStatus() async {
    final tokensResult = await _getTokensUseCase(NoParams());

    if (!ref.mounted) return state;

    return tokensResult.fold(
      (failure) {
        state = const AuthState.unauthenticated();
        return state;
      },
      (tokens) {
        if (tokens != null) {
          state = AuthState.authenticated(
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken,
          );
        } else {
          state = const AuthState.unauthenticated();
        }
        return state;
      },
    );
  }

  // refreshToken
  Future<String?> refreshToken() async {
    final currentRefresh = state.refreshToken;
    final currentAccess = state.accessToken;

    if (currentRefresh == null || currentRefresh.isEmpty) {
      AppLogger.e('AuthNotifier: No refresh token available');
      state = const AuthState.unauthenticated();
      return null;
    }

    state = AuthState.authenticated(
      accessToken: currentAccess ?? '',
      refreshToken: currentRefresh,
      isRefreshLoading: true,
    );

    AppLogger.d('AuthNotifier: Refreshing token');

    final params = RefreshTokenParams(refreshToken: currentRefresh);
    final result = await _refreshTokenUseCase(params);

    if (!ref.mounted) return null;

    return await result.fold(
      (failure) async {
        AppLogger.e('AuthNotifier: Token refresh failed - ${failure.message}');
        state = AuthState.unauthenticated(failure: failure);
        return null;
      },
      (newTokens) async {
        AppLogger.i('AuthNotifier: Token refresh successful');

        // Store new tokens locally
        final storeResult = await _storeTokensUseCase(
          StoreTokensParams(tokens: newTokens),
        );

        if (!ref.mounted) return null;

        storeResult.fold(
          (failure) => AppLogger.e(
            'AuthNotifier: Failed to store new tokens - ${failure.message}',
          ),
          (_) => AppLogger.d('AuthNotifier: New tokens stored successfully'),
        );

        state = AuthState.authenticated(
          accessToken: newTokens.accessToken,
          refreshToken: newTokens.refreshToken,
        );

        return newTokens.accessToken;
      },
    );
  }

  // Get access token from state
  String? getAccessToken() => state.accessToken;

  // Get refresh token from state
  String? getRefreshToken() => state.refreshToken;

  // Check if authenticated
  bool get isAuthenticated => state.isAuthenticated;
}
