import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../../core/logger/app_logger.dart';
import 'auth_injection.dart';
import 'domain/entities/user_entity.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/refresh_token_usecase.dart';

class AuthExample {
  static Future<void> demonstrateAuthFlow() async {
    // Initialize auth dependencies
    AuthInjection.init();

    AppLogger.i('=== Auth Module Demo with Either ===');

    // Demo login
    await _demoLogin();

    // Demo register
    await _demoRegister();

    // Demo refresh token
    await _demoRefreshToken();
  }

  static Future<void> _demoLogin() async {
    AppLogger.i('\n--- Login Demo ---');
    
    final loginUseCase = AuthInjection.loginUseCase;
    
    // Test with valid credentials
    final validParams = LoginParams(
      email: 'user@example.com',
      password: 'password123',
    );

    final result = await loginUseCase(validParams);
    
    result.fold(
      (failure) {
        AppLogger.e('Login failed: ${failure.message}');
        _handleLoginFailure(failure);
      },
      (user) {
        AppLogger.i('Login successful: ${user.email}');
        _handleLoginSuccess(user);
      },
    );

    // Test with invalid email
    final invalidEmailParams = LoginParams(
      email: 'invalid-email',
      password: 'password123',
    );

    final invalidResult = await loginUseCase(invalidEmailParams);
    invalidResult.fold(
      (failure) => AppLogger.w('Expected validation failure: ${failure.message}'),
      (user) => AppLogger.e('Unexpected success with invalid email'),
    );
  }

  static Future<void> _demoRegister() async {
    AppLogger.i('\n--- Register Demo ---');
    
    final registerUseCase = AuthInjection.registerUseCase;
    
    // Test with valid data
    final validParams = RegisterParams(
      email: 'newuser@example.com',
      password: 'password123',
      confirmPassword: 'password123',
      name: 'New User',
    );

    final result = await registerUseCase(validParams);
    
    result.fold(
      (failure) {
        AppLogger.e('Registration failed: ${failure.message}');
        _handleRegistrationFailure(failure);
      },
      (user) {
        AppLogger.i('Registration successful: ${user.email}');
        _handleRegistrationSuccess(user);
      },
    );

    // Test with mismatched passwords
    final mismatchedParams = RegisterParams(
      email: 'test@example.com',
      password: 'password123',
      confirmPassword: 'different123',
    );

    final mismatchedResult = await registerUseCase(mismatchedParams);
    mismatchedResult.fold(
      (failure) => AppLogger.w('Expected validation failure: ${failure.message}'),
      (user) => AppLogger.e('Unexpected success with mismatched passwords'),
    );
  }

  static Future<void> _demoRefreshToken() async {
    AppLogger.i('\n--- Refresh Token Demo ---');
    
    final refreshTokenUseCase = AuthInjection.refreshTokenUseCase;
    
    // Test with valid refresh token
    final validParams = RefreshTokenParams(
      refreshToken: 'valid_refresh_token_here',
    );

    final result = await refreshTokenUseCase(validParams);
    
    result.fold(
      (failure) {
        AppLogger.e('Token refresh failed: ${failure.message}');
        _handleRefreshFailure(failure);
      },
      (newAccessToken) {
        AppLogger.i('Token refresh successful');
        _handleRefreshSuccess(newAccessToken);
      },
    );

    // Test with empty refresh token
    final emptyParams = RefreshTokenParams(refreshToken: '');
    
    final emptyResult = await refreshTokenUseCase(emptyParams);
    emptyResult.fold(
      (failure) => AppLogger.w('Expected validation failure: ${failure.message}'),
      (token) => AppLogger.e('Unexpected success with empty token'),
    );
  }

  // Helper methods for handling results
  static void _handleLoginSuccess(UserEntity user) {
    AppLogger.i('User logged in successfully:');
    AppLogger.i('- ID: ${user.id}');
    AppLogger.i('- Email: ${user.email}');
    AppLogger.i('- Name: ${user.name ?? 'N/A'}');
    AppLogger.i('- Access Token: ${user.accessToken.substring(0, 10)}...');
    
    // Here you would typically:
    // - Save tokens to secure storage
    // - Update app state
    // - Navigate to main screen
  }

  static void _handleLoginFailure(Failure failure) {
    if (failure is ValidationFailure) {
      AppLogger.w('Validation error: ${failure.message}');
      // Show validation error to user
    } else if (failure is UnauthorizedFailure) {
      AppLogger.w('Authentication failed: ${failure.message}');
      // Show "Invalid credentials" message
    } else if (failure is ServerFailure) {
      AppLogger.e('Server error: ${failure.message}');
      // Show "Server error, please try again" message
    } else {
      AppLogger.e('Unknown error: ${failure.message}');
      // Show generic error message
    }
  }

  static void _handleRegistrationSuccess(UserEntity user) {
    AppLogger.i('User registered successfully:');
    AppLogger.i('- ID: ${user.id}');
    AppLogger.i('- Email: ${user.email}');
    AppLogger.i('- Name: ${user.name ?? 'N/A'}');
    
    // Here you would typically:
    // - Save tokens to secure storage
    // - Update app state
    // - Navigate to main screen or email verification
  }

  static void _handleRegistrationFailure(Failure failure) {
    if (failure is ValidationFailure) {
      AppLogger.w('Validation error: ${failure.message}');
      // Show specific validation errors
    } else if (failure is ServerFailure) {
      AppLogger.e('Server error: ${failure.message}');
      // Show "Registration failed, please try again"
    } else {
      AppLogger.e('Unknown error: ${failure.message}');
      // Show generic error message
    }
  }

  static void _handleRefreshSuccess(String newAccessToken) {
    AppLogger.i('New access token received: ${newAccessToken.substring(0, 10)}...');
    
    // Here you would typically:
    // - Update stored access token
    // - Retry the original request that failed
  }

  static void _handleRefreshFailure(Failure failure) {
    if (failure is UnauthorizedFailure) {
      AppLogger.w('Refresh token expired: ${failure.message}');
      // Redirect to login screen
    } else {
      AppLogger.e('Refresh failed: ${failure.message}');
      // Show error and possibly redirect to login
    }
  }
}

// Extension to demonstrate functional programming patterns with Either
extension AuthResultExtensions on Either<Failure, UserEntity> {
  // Chain operations on successful login
  Either<Failure, String> extractAccessToken() {
    return map((user) => user.accessToken);
  }

  // Transform user data
  Either<Failure, Map<String, dynamic>> toUserProfile() {
    return map((user) => {
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'hasToken': user.accessToken.isNotEmpty,
    });
  }

  // Validate user data
  Either<Failure, UserEntity> validateUser() {
    return flatMap((user) {
      if (user.email.isEmpty) {
        return left(const ValidationFailure('Email is required'));
      }
      if (user.accessToken.isEmpty) {
        return left(const ValidationFailure('Access token is required'));
      }
      return right(user);
    });
  }
}
