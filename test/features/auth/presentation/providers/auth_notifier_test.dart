import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/usecases/clear_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/get_tokens_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:delivery_app/features/auth/domain/usecases/store_tokens_usecase.dart';
import 'package:delivery_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_notifier_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoginUseCase>(),
  MockSpec<RegisterUseCase>(),
  MockSpec<RefreshTokenUseCase>(),
  MockSpec<StoreTokensUseCase>(),
  MockSpec<GetTokensUseCase>(),
  MockSpec<ClearTokensUseCase>(),
])
void main() {
  late AuthNotifier authNotifier;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockRefreshTokenUseCase mockRefreshTokenUseCase;
  late MockStoreTokensUseCase mockStoreTokensUseCase;
  late MockGetTokensUseCase mockGetTokensUseCase;
  late MockClearTokensUseCase mockClearTokensUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockRefreshTokenUseCase = MockRefreshTokenUseCase();
    mockStoreTokensUseCase = MockStoreTokensUseCase();
    mockGetTokensUseCase = MockGetTokensUseCase();
    mockClearTokensUseCase = MockClearTokensUseCase();

    // Provide dummy values for Either types that Mockito can't auto-generate
    provideDummy<Either<Failure, AuthEntity>>(
      right(AuthEntity(accessToken: 'dummy', refreshToken: 'dummy')),
    );
    provideDummy<Either<Failure, bool>>(right(true));
    provideDummy<Either<Failure, void>>(Right<Failure, Unit>(unit));
    provideDummy<Either<Failure, AuthEntity?>>(right(null));

    authNotifier = AuthNotifier(
      loginUseCase: mockLoginUseCase,
      registerUseCase: mockRegisterUseCase,
      refreshTokenUseCase: mockRefreshTokenUseCase,
      storeTokensUseCase: mockStoreTokensUseCase,
      getTokensUseCase: mockGetTokensUseCase,
      clearTokensUseCase: mockClearTokensUseCase,
    );
  });

  tearDown(() {
    authNotifier.dispose();
  });

  group('AuthNotifier - Login', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testAccessToken = 'test_access_token';
    const testRefreshToken = 'test_refresh_token';

    final testUser = AuthEntity(
      accessToken: testAccessToken,
      refreshToken: testRefreshToken,
    );

    test('should emit loading and success states on successful login', () async {
      // Arrange
      when(mockLoginUseCase(any)).thenAnswer(
        (_) async => right(testUser),
      );
      when(mockStoreTokensUseCase(any)).thenAnswer(
        (_) async => Right<Failure, Unit>(unit),
      );

      // Act
      await authNotifier.login(
        email: testEmail,
        password: testPassword,
      );

      // Wait for all state updates to complete
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert - Should be authenticated with tokens after login completes
      expect(authNotifier.state.isLoginLoading, false);
      expect(authNotifier.state.isAuthenticated, true);
      expect(authNotifier.state.accessToken, testAccessToken);
      expect(authNotifier.state.refreshToken, testRefreshToken);
      expect(authNotifier.state.failure, null);

      // Verify usecases were called
      verify(mockLoginUseCase(any)).called(1);
      verify(mockStoreTokensUseCase(any)).called(1);
    });

    test('should emit loading and failure states on login failure', () async {
      // Arrange
      const failure = ServerFailure('Login failed');
      when(mockLoginUseCase(any)).thenAnswer(
        (_) async => left(failure),
      );

      // Act
      await authNotifier.login(
        email: testEmail,
        password: testPassword,
      );

      // Assert
      expect(authNotifier.state.isLoginLoading, false);
      expect(authNotifier.state.isAuthenticated, false);
      expect(authNotifier.state.failure, failure);
      expect(authNotifier.state.accessToken, '');

      verify(mockLoginUseCase(any)).called(1);
      verifyNever(mockStoreTokensUseCase(any));
    });

    test('should handle store tokens failure gracefully', () async {
      // Arrange
      when(mockLoginUseCase(any)).thenAnswer(
        (_) async => right(testUser),
      );
      when(mockStoreTokensUseCase(any)).thenAnswer(
        (_) async => left(const CacheFailure('Failed to store tokens')),
      );

      // Act
      await authNotifier.login(
        email: testEmail,
        password: testPassword,
      );

      // Wait for all state updates
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert - Should still be authenticated even if storing fails
      expect(authNotifier.state.isAuthenticated, true);
      expect(authNotifier.state.accessToken, testAccessToken);
      expect(authNotifier.state.refreshToken, testRefreshToken);

      verify(mockLoginUseCase(any)).called(1);
      verify(mockStoreTokensUseCase(any)).called(1);
    });

    test('should pass device info to login usecase', () async {
      // Arrange
      const deviceId = 'device123';
      const deviceName = 'iPhone 13';
      const deviceType = 'iOS';
      const ipAddress = '192.168.1.1';

      when(mockLoginUseCase(any)).thenAnswer(
        (_) async => right(testUser),
      );
      when(mockStoreTokensUseCase(any)).thenAnswer(
        (_) async => Right<Failure, Unit>(unit),
      );

      // Act
      await authNotifier.login(
        email: testEmail,
        password: testPassword,
        deviceId: deviceId,
        deviceName: deviceName,
        deviceType: deviceType,
        ipAddress: ipAddress,
      );

      // Assert
      final captured = verify(mockLoginUseCase(captureAny)).captured.single as LoginParams;
      expect(captured.email, testEmail);
      expect(captured.password, testPassword);
      expect(captured.deviceId, deviceId);
      expect(captured.deviceName, deviceName);
      expect(captured.deviceType, deviceType);
      expect(captured.ipAddress, ipAddress);
    });
  });

  group('AuthNotifier - Register', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testName = 'Test User';

    test('should emit loading state and call login on successful register', () async {
      // Arrange
      when(mockRegisterUseCase(any)).thenAnswer(
        (_) async => right(true),
      );
      when(mockLoginUseCase(any)).thenAnswer(
        (_) async => right(AuthEntity(
          accessToken: 'token',
          refreshToken: 'refresh',
        )),
      );
      when(mockStoreTokensUseCase(any)).thenAnswer(
        (_) async => Right<Failure, Unit>(unit),
      );

      // Act
      final registerFuture = authNotifier.register(
        name: testName,
        email: testEmail,
        password: testPassword,
        confirmPassword: testPassword,
      );

      await Future.delayed(Duration.zero);
      expect(authNotifier.state.isRegisterLoading, true);

      await registerFuture;

      // Assert - Should trigger login after successful register
      verify(mockRegisterUseCase(any)).called(1);
      verify(mockLoginUseCase(any)).called(1);
    });

    test('should emit failure state on register failure', () async {
      // Arrange
      const failure = ServerFailure('Registration failed');
      when(mockRegisterUseCase(any)).thenAnswer(
        (_) async => left(failure),
      );

      // Act
      await authNotifier.register(
        name: testName,
        email: testEmail,
        password: testPassword,
        confirmPassword: testPassword,
      );

      // Assert
      expect(authNotifier.state.isRegisterLoading, false);
      expect(authNotifier.state.failure, failure);

      verify(mockRegisterUseCase(any)).called(1);
      verifyNever(mockLoginUseCase(any));
    });
  });

  group('AuthNotifier - Logout', () {
    test('should clear tokens and reset state on logout', () async {
      // Arrange
      when(mockClearTokensUseCase(any)).thenAnswer(
        (_) async => Right<Failure, Unit>(unit),
      );

      // Set initial authenticated state
      authNotifier.state = authNotifier.state.copyWith(
        isAuthenticated: true,
        accessToken: 'token',
        refreshToken: 'refresh',
      );

      // Act
      await authNotifier.logout();

      // Assert
      expect(authNotifier.state.isAuthenticated, false);
      expect(authNotifier.state.accessToken, '');
      expect(authNotifier.state.refreshToken, '');

      verify(mockClearTokensUseCase(any)).called(1);
    });

    test('should handle clear tokens failure gracefully', () async {
      // Arrange
      when(mockClearTokensUseCase(any)).thenAnswer(
        (_) async => left(const CacheFailure('Failed to clear')),
      );

      authNotifier.state = authNotifier.state.copyWith(
        isAuthenticated: true,
        accessToken: 'token',
      );

      // Act
      await authNotifier.logout();

      // Assert - Should still logout even if clearing fails
      expect(authNotifier.state.isAuthenticated, false);
      verify(mockClearTokensUseCase(any)).called(1);
    });
  });

  group('AuthNotifier - Check Auth Status', () {
    test('should set authenticated state when tokens exist', () async {
      // Arrange
      final tokens = AuthEntity(
        accessToken: 'access_token',
        refreshToken: 'refresh_token',
      );
      when(mockGetTokensUseCase(any)).thenAnswer(
        (_) async => right(tokens),
      );

      // Act
      await authNotifier.checkAuthStatus();

      // Assert
      expect(authNotifier.state.isAuthenticated, true);
      expect(authNotifier.state.accessToken, 'access_token');
      expect(authNotifier.state.refreshToken, 'refresh_token');

      verify(mockGetTokensUseCase(any)).called(1);
    });

    test('should set unauthenticated state when no tokens found', () async {
      // Arrange
      when(mockGetTokensUseCase(any)).thenAnswer(
        (_) async => right(null),
      );

      // Act
      await authNotifier.checkAuthStatus();

      // Assert
      expect(authNotifier.state.isAuthenticated, false);
      expect(authNotifier.state.accessToken, '');

      verify(mockGetTokensUseCase(any)).called(1);
    });

    test('should set unauthenticated state on get tokens failure', () async {
      // Arrange
      when(mockGetTokensUseCase(any)).thenAnswer(
        (_) async => left(const CacheFailure('No tokens')),
      );

      // Act
      await authNotifier.checkAuthStatus();

      // Assert
      expect(authNotifier.state.isAuthenticated, false);
      verify(mockGetTokensUseCase(any)).called(1);
    });
  });

  group('AuthNotifier - Refresh Token', () {
    const oldRefreshToken = 'old_refresh_token';
    const newAccessToken = 'new_access_token';
    const newRefreshToken = 'new_refresh_token';

    test('should refresh tokens and update state on success', () async {
      // Arrange
      authNotifier.state = authNotifier.state.copyWith(
        refreshToken: oldRefreshToken,
        isAuthenticated: true,
      );

      final newTokens = AuthEntity(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      when(mockRefreshTokenUseCase(any)).thenAnswer(
        (_) async => right(newTokens),
      );
      when(mockStoreTokensUseCase(any)).thenAnswer(
        (_) async => Right<Failure, Unit>(unit),
      );

      // Act
      final result = await authNotifier.refreshToken();

      // Assert
      expect(result, newAccessToken);
      expect(authNotifier.state.isRefreshLoading, false);
      expect(authNotifier.state.isAuthenticated, true);
      expect(authNotifier.state.accessToken, newAccessToken);
      expect(authNotifier.state.refreshToken, newRefreshToken);

      verify(mockRefreshTokenUseCase(any)).called(1);
      verify(mockStoreTokensUseCase(any)).called(1);
    });

    test('should logout on refresh token failure', () async {
      // Arrange
      authNotifier.state = authNotifier.state.copyWith(
        refreshToken: oldRefreshToken,
        isAuthenticated: true,
        accessToken: 'old_access',
      );

      when(mockRefreshTokenUseCase(any)).thenAnswer(
        (_) async => left(const ServerFailure('Token expired')),
      );

      // Act
      await authNotifier.refreshToken();

      // Assert
      expect(authNotifier.state.isAuthenticated, false);
      expect(authNotifier.state.accessToken, '');
      expect(authNotifier.state.refreshToken, '');

      verify(mockRefreshTokenUseCase(any)).called(1);
      verifyNever(mockStoreTokensUseCase(any));
    });

    test('should not refresh when no refresh token available', () async {
      // Arrange - No refresh token set
      authNotifier.state = authNotifier.state.copyWith(
        refreshToken: null,
        isAuthenticated: false,
      );

      // Act
      await authNotifier.refreshToken();

      // Assert
      expect(authNotifier.state.isAuthenticated, false);
      verifyNever(mockRefreshTokenUseCase(any));
    });

    test('should handle store tokens failure after refresh', () async {
      // Arrange
      authNotifier.state = authNotifier.state.copyWith(
        refreshToken: oldRefreshToken,
      );

      final newTokens = AuthEntity(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );

      when(mockRefreshTokenUseCase(any)).thenAnswer(
        (_) async => right(newTokens),
      );
      when(mockStoreTokensUseCase(any)).thenAnswer(
        (_) async => const Left(CacheFailure('Store failed')),
      );

      // Act
      await authNotifier.refreshToken();

      // Assert - Should still update state even if storing fails
      expect(authNotifier.state.isAuthenticated, true);
      expect(authNotifier.state.accessToken, newAccessToken);
      expect(authNotifier.state.refreshToken, newRefreshToken);

      verify(mockRefreshTokenUseCase(any)).called(1);
      verify(mockStoreTokensUseCase(any)).called(1);
    });
  });

  group('AuthNotifier - Getters', () {
    test('getAccessToken should return current access token', () {
      // Arrange
      const token = 'test_access_token';
      authNotifier.state = authNotifier.state.copyWith(accessToken: token);

      // Act & Assert
      expect(authNotifier.getAccessToken(), token);
    });

    test('getRefreshToken should return current refresh token', () {
      // Arrange
      const token = 'test_refresh_token';
      authNotifier.state = authNotifier.state.copyWith(refreshToken: token);

      // Act & Assert
      expect(authNotifier.getRefreshToken(), token);
    });

    test('isAuthenticated should return current auth status', () {
      // Arrange
      authNotifier.state = authNotifier.state.copyWith(isAuthenticated: true);

      // Act & Assert
      expect(authNotifier.isAuthenticated, true);
    });
  });
}
