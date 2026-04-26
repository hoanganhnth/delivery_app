import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/social_login_usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:delivery_app/features/auth/domain/usecases/store_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/get_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/clear_tokens_usecase.dart';
import 'package:delivery_app/features/auth/presentation/providers/session/auth_state.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/auth_di_providers.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/storage_di_providers.dart';
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

  @override
  AuthState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    _socialLoginUseCase = ref.read(socialLoginUseCaseProvider);
    _registerUseCase = ref.read(registerUseCaseProvider);
    _refreshTokenUseCase = ref.read(refreshTokenUseCaseProvider);
    _storeTokensUseCase = ref.read(storeTokensUseCaseProvider);
    _getTokensUseCase = ref.read(getTokensUseCaseProvider);
    _clearTokensUseCase = ref.read(clearTokensUseCaseProvider);
    return const AuthState();
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
    state = state.copyWith(isLoginLoading: true, clearFailure: true);

    final params = LoginParams(
      email: email,
      password: password,
      deviceId: deviceId,
      deviceName: deviceName,
      deviceType: deviceType,
      ipAddress: ipAddress,
    );
    final result = await _loginUseCase(params);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoginLoading: false,
          isAuthenticated: false,
          failure: failure,
          clearUser: true,
        );
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

        state = state.copyWith(
          isLoginLoading: false,
          isAuthenticated: true,
          clearFailure: true,
          refreshToken: user.refreshToken,
          accessToken: user.accessToken,
        );
      },
    );
  }

  // Google Sign In
  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoginLoading: true, clearFailure: true);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      
      if (account == null) {
        // User canceled the sign-in flow
        state = state.copyWith(isLoginLoading: false);
        return;
      }
      
      final GoogleSignInAuthentication auth = await account.authentication;
      final String? idToken = auth.idToken;
      
      if (idToken == null) {
        state = state.copyWith(
          isLoginLoading: false,
          isAuthenticated: false,
          failure: const ServerFailure('Google login failed: Empty ID token'),
        );
        return;
      }

      final params = SocialLoginParams(
        provider: 'google',
        token: idToken,
        role: 'CUSTOMER', // Default role for app users
        deviceId: 'social-auth', 
        deviceName: 'Mobile Device',
        deviceType: 'MOBILE',
        ipAddress: '127.0.0.1',
      );

      final result = await _socialLoginUseCase(params);

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoginLoading: false,
            isAuthenticated: false,
            failure: failure,
            clearUser: true,
          );
        },
        (user) async {
          final storeResult = await _storeTokensUseCase(
            StoreTokensParams(tokens: user),
          );
          storeResult.fold(
            (failure) => AppLogger.e('AuthNotifier: Failed to store tokens - ${failure.message}'),
            (_) => AppLogger.d('AuthNotifier: Tokens stored successfully'),
          );

          state = state.copyWith(
            isLoginLoading: false,
            isAuthenticated: true,
            clearFailure: true,
            refreshToken: user.refreshToken,
            accessToken: user.accessToken,
          );
        },
      );
    } catch (error) {
      AppLogger.e('Google Sign In Error', error);
      state = state.copyWith(
        isLoginLoading: false,
        isAuthenticated: false,
        failure: ServerFailure('Google sign-in error: $error'),
      );
    }
  }

  /// Login with saved tokens (for biometric authentication)
  Future<void> loginWithTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    AppLogger.d('AuthNotifier: Logging in with saved tokens');
    state = state.copyWith(isLoginLoading: true, clearFailure: true);

    // Store tokens locally
    final storeResult = await _storeTokensUseCase(
      StoreTokensParams(
        tokens: AuthEntity(
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      ),
    );

    storeResult.fold(
      (failure) {
        AppLogger.e(
          'AuthNotifier: Failed to store tokens - ${failure.message}',
        );
        state = state.copyWith(
          isLoginLoading: false,
          isAuthenticated: false,
          failure: failure,
        );
      },
      (_) {
        AppLogger.i('AuthNotifier: Logged in with tokens successfully');
        state = state.copyWith(
          isLoginLoading: false,
          isAuthenticated: true,
          clearFailure: true,
          refreshToken: refreshToken,
          accessToken: accessToken,
        );
      },
    );
  }

  // Register method - simplified
  Future<void> register({
    String? name,
    required String email,
    required String password,
    required String confirmPassword,
    String? deviceId,
    String? deviceName,
    String? deviceType,
    String? ipAddress,
  }) async {
    state = state.copyWith(isRegisterLoading: true, clearFailure: true);

    final params = RegisterParams(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    final result = await _registerUseCase(params);

    result.fold(
      (failure) {
        state = state.copyWith(isRegisterLoading: false, failure: failure);
      },
      (success) {
        // Register successful, now login to get tokens
        if (success) {
          login(email: email, password: password);
        } else {
          state = state.copyWith(isRegisterLoading: false);
        }
      },
    );
  }

  // Logout method
  Future<void> logout() async {
    // Clear stored tokens
    final clearResult = await _clearTokensUseCase(NoParams());
    clearResult.fold(
      (failure) => AppLogger.e(
        'AuthNotifier: Failed to clear tokens - ${failure.message}',
      ),
      (_) => AppLogger.d('AuthNotifier: Tokens cleared successfully'),
    );

    state = state.copyWith(
      isAuthenticated: false,
      clearUser: true,
      clearFailure: true,
    );
  }

  // Check if user is logged in
  Future<AuthState> checkAuthStatus() async {
    final tokensResult = await _getTokensUseCase(NoParams());

    // fold trả về giá trị gì thì return luôn giá trị đó
    return tokensResult.fold(
      (failure) {
        state = state.copyWith(isAuthenticated: false, clearUser: true);
        return state;
      },
      (tokens) {
        if (tokens != null) {
          state = state.copyWith(
            isAuthenticated: true,
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken,
          );
        } else {
          state = state.copyWith(isAuthenticated: false, clearUser: true);
        }
        return state;
      },
    );
  }

  // refreshToken
  Future refreshToken() async {
    if (state.refreshToken == null || state.refreshToken!.isEmpty) {
      AppLogger.e('AuthNotifier: No refresh token available');
      state = state.copyWith(isAuthenticated: false, clearUser: true);
      return;
    }

    state = state.copyWith(isRefreshLoading: true, clearFailure: true);
    AppLogger.d('AuthNotifier: Refreshing token');

    final params = RefreshTokenParams(refreshToken: state.refreshToken!);
    final result = await _refreshTokenUseCase(params);

    await result.fold(
      (failure) {
        AppLogger.e('AuthNotifier: Token refresh failed - ${failure.message}');
        state = state.copyWith(
          isRefreshLoading: false,
          isAuthenticated: false,
          failure: failure,
          clearUser: true,
        );
      },
      (newTokens) async {
        AppLogger.i('AuthNotifier: Token refresh successful');

        // Store new tokens locally
        final storeResult = await _storeTokensUseCase(
          StoreTokensParams(tokens: newTokens),
        );

        storeResult.fold(
          (failure) => AppLogger.e(
            'AuthNotifier: Failed to store new tokens - ${failure.message}',
          ),
          (_) => AppLogger.d('AuthNotifier: New tokens stored successfully'),
        );

        state = state.copyWith(
          isRefreshLoading: false,
          isAuthenticated: true,
          clearFailure: true,
          accessToken: newTokens.accessToken,
          refreshToken: newTokens.refreshToken,
        );
      },
    );
    return state.accessToken;
  }

  // Get access token from state
  String? getAccessToken() => state.accessToken;

  // Get refresh token from state
  String? getRefreshToken() => state.refreshToken;

  // Check if authenticated
  bool get isAuthenticated => state.isAuthenticated;
}
