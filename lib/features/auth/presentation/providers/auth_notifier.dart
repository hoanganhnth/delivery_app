import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/usecases/store_tokens_usecase.dart';
import '../../domain/usecases/get_tokens_usecase.dart';
import '../../domain/usecases/clear_tokens_usecase.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final StoreTokensUseCase _storeTokensUseCase;
  final GetTokensUseCase _getTokensUseCase;
  final ClearTokensUseCase _clearTokensUseCase;

  AuthNotifier({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
    required StoreTokensUseCase storeTokensUseCase,
    required GetTokensUseCase getTokensUseCase,
    required ClearTokensUseCase clearTokensUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _refreshTokenUseCase = refreshTokenUseCase,
       _storeTokensUseCase = storeTokensUseCase,
       _getTokensUseCase = getTokensUseCase,
       _clearTokensUseCase = clearTokensUseCase,
       super(const AuthState());

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

    // AppLogger.d('AuthNotifier: Starting login for $email');

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
        // AppLogger.e('AuthNotifier: Login failed - ${failure.message}');
        state = state.copyWith(
          isLoginLoading: false,
          isAuthenticated: false,
          failure: failure,
          clearUser: true,
        );
      },
      (user) async {
        // AppLogger.i('AuthNotifier: Login successful');

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
    // AppLogger.d('AuthNotifier: Logging out');

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
  Future<void> checkAuthStatus() async {
    // AppLogger.d('AuthNotifier: Checking auth status');

    final tokensResult = await _getTokensUseCase(NoParams());

    tokensResult.fold(
      (failure) {
        // AppLogger.e('AuthNotifier: Failed to get tokens - ${failure.message}');
        state = state.copyWith(isAuthenticated: false, clearUser: true);
      },
      (tokens) {
        if (tokens != null) {
          // AppLogger.d('AuthNotifier: Found stored tokens');
          state = state.copyWith(
            isAuthenticated: true,
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken,
          );
        } else {
          // AppLogger.d('AuthNotifier: No tokens found');
          state = state.copyWith(isAuthenticated: false, clearUser: true);
        }
      },
    );
  }

  // refreshToken
  Future<void> refreshToken() async {
    if (state.refreshToken == null || state.refreshToken!.isEmpty) {
      AppLogger.e('AuthNotifier: No refresh token available');
      state = state.copyWith(isAuthenticated: false, clearUser: true);
      return;
    }

    state = state.copyWith(isRefreshLoading: true, clearFailure: true);
    AppLogger.d('AuthNotifier: Refreshing token');

    final params = RefreshTokenParams(refreshToken: state.refreshToken!);
    final result = await _refreshTokenUseCase(params);

    result.fold(
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
          StoreTokensParams(
            tokens: AuthEntity(
              accessToken: newTokens,
              refreshToken: state.refreshToken!,
            ),
          ),
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
          accessToken: newTokens,
        );
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
