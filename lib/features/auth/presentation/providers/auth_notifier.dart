import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;

  AuthNotifier({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _refreshTokenUseCase = refreshTokenUseCase,
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

    AppLogger.d('AuthNotifier: Starting login for $email');

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
        AppLogger.e('AuthNotifier: Login failed - ${failure.message}');
        state = state.copyWith(
          isLoginLoading: false,
          isAuthenticated: false,
          failure: failure,
          clearUser: true,
        );
      },
      (user) {
        AppLogger.i('AuthNotifier: Login successful');
        state = state.copyWith(
          isLoginLoading: false,
          isAuthenticated: true,
          clearFailure: true,
        );
      },
    );
  }

  // Register method
  Future<void> register({
    required String email,
    required String password,
     String? confirmPassword,
    String? name,
  }) async {
    state = state.copyWith(isRegisterLoading: true, clearFailure: true);

    AppLogger.d('AuthNotifier: Starting registration for $email');

    final params = RegisterParams(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      name: name,
    );

    final result = await _registerUseCase(params);

    result.fold(
      (failure) {
        AppLogger.e('AuthNotifier: Registration failed - ${failure.message}');
        state = state.copyWith(
          isRegisterLoading: false,
          isAuthenticated: false,
          failure: failure,
          clearUser: true,
        );
      },
      (user) {
        AppLogger.i('AuthNotifier: Registration successful ');
        state = state.copyWith(
          isRegisterLoading: false,
          isAuthenticated: true,
          clearFailure: true,
        );
      },
    );
  }

  // Refresh token method
  Future<String?> refreshToken() async {
    final currentRefreshToken = state.refreshToken;
    if (currentRefreshToken == null) {
      AppLogger.w('AuthNotifier: No refresh token available');
      await logout();
      return null;
    }

    state = state.copyWith(isRefreshLoading: true);

    AppLogger.d('AuthNotifier: Refreshing token');

    final params = RefreshTokenParams(refreshToken: currentRefreshToken);
    final result = await _refreshTokenUseCase(params);

    return result.fold(
      (failure) {
        AppLogger.e('AuthNotifier: Token refresh failed - ${failure.message}');
        state = state.copyWith(isRefreshLoading: false, failure: failure);

        // If refresh fails, logout user
        if (failure is UnauthorizedFailure) {
          logout();
        }

        return null;
      },
      (newAccessToken) {
        AppLogger.i('AuthNotifier: Token refresh successful');

        // Update user with new access token
        final updatedUser = state.user?.copyWith(accessToken: newAccessToken);

        state = state.copyWith(
          isRefreshLoading: false,
          user: updatedUser,
          clearFailure: true,
        );

        return newAccessToken;
      },
    );
  }

  // Logout method
  Future<void> logout() async {
    AppLogger.i('AuthNotifier: Logging out user');

    state = state.copyWith(
      isAuthenticated: false,
      clearUser: true,
      clearFailure: true,
      isLoginLoading: false,
      isRegisterLoading: false,
      isRefreshLoading: false,
    );

    // Here you would typically:
    // - Clear stored tokens from secure storage
    // - Clear any cached data
    // - Reset other app state if needed
  }

  // Clear error method
  void clearError() {
    state = state.copyWith(clearFailure: true);
  }

  // Check if user is authenticated
  bool get isAuthenticated => state.isAuthenticated && state.user != null;

  // Get current user
  UserEntity? get currentUser => state.user;

  // Utility methods for UI
  bool get isLoading =>
      state.isLoginLoading || state.isRegisterLoading || state.isRefreshLoading;

  bool get canLogin => !state.isLoginLoading && !state.isRegisterLoading;

  bool get canRegister => !state.isLoginLoading && !state.isRegisterLoading;
}
