import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/login_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/register_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/refresh_token_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fake implementation for testing data layer
/// Uses deterministic responses instead of mocks
class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  // Test configurations
  bool _shouldReturnSuccess = true;
  bool _shouldThrowException = false;
  String? _customErrorMessage;
  
  // Behavior control methods
  void setSuccessResponse() {
    _shouldReturnSuccess = true;
    _shouldThrowException = false;
    _customErrorMessage = null;
  }
  
  void setErrorResponse([String? message]) {
    _shouldReturnSuccess = false;
    _shouldThrowException = false;
    _customErrorMessage = message;
  }
  
  void setNetworkException() {
    _shouldThrowException = true;
    _shouldReturnSuccess = false;
  }

  @override
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    if (_shouldThrowException) {
      throw Exception('Network connection failed');
    }

    if (_shouldReturnSuccess) {
      return _createSuccessfulLoginResponse(request);
    } else {
      return _createFailedLoginResponse();
    }
  }

  @override
  Future<BaseResponseDto<bool>> register(RegisterRequestDto request) async {
    if (_shouldThrowException) {
      throw Exception('Network connection failed');
    }

    if (_shouldReturnSuccess) {
      return BaseResponseDto<bool>(
        status: 1,
        message: 'Registration successful',
        data: true,
      );
    } else {
      return BaseResponseDto<bool>(
        status: 0,
        message: _customErrorMessage ?? 'Registration failed',
        data: false,
      );
    }
  }

  @override
  Future<RefreshTokenResponseDto> refreshToken(String refreshToken) async {
    if (_shouldThrowException) {
      throw Exception('Network connection failed');
    }

    if (_shouldReturnSuccess) {
      return RefreshTokenResponseDto(
        status: 1,
        message: 'Token refreshed successfully',
        data: const RefreshTokenDataDto(
          accessToken: 'new_access_token_from_refresh',
        ),
      );
    } else {
      return RefreshTokenResponseDto(
        status: 0,
        message: _customErrorMessage ?? 'Token refresh failed',
        data: null,
      );
    }
  }

  // Helper methods for creating test data
  AuthResponseDto _createSuccessfulLoginResponse(LoginRequestDto request) {
    return AuthResponseDto(
      status: 1,
      message: 'Login successful',
      data: AuthDataDto(
        accessToken: 'fake_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'fake_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        user: UserDto(
          id: 123,
          email: request.email,
          name: 'Test User for ${request.email}',
        ),
      ),
    );
  }

  AuthResponseDto _createFailedLoginResponse() {
    return AuthResponseDto(
      status: 0,
      message: _customErrorMessage ?? 'Invalid credentials',
      data: null,
    );
  }
}

void main() {
  late FakeAuthRemoteDataSource dataSource;

  setUp(() {
    dataSource = FakeAuthRemoteDataSource();
  });

  group('AuthRemoteDataSource - Data Layer Tests', () {
    group('Login Operation', () {
      final validLoginRequest = LoginRequestDto(
        email: 'test@example.com',
        password: 'password123',
        deviceId: 'test-device-123',
        deviceName: 'Test Device',
        deviceType: 'iOS',
        ipAddress: '192.168.1.100',
      );

      test('should return successful auth response with valid credentials', () async {
        // Arrange
        dataSource.setSuccessResponse();

        // Act
        final result = await dataSource.login(validLoginRequest);

        // Assert
        expect(result.status, 1);
        expect(result.message, 'Login successful');
        expect(result.data, isNotNull);
        expect(result.data!.accessToken, startsWith('fake_access_token_'));
        expect(result.data!.refreshToken, startsWith('fake_refresh_token_'));
        expect(result.data!.user!.email, validLoginRequest.email);
        expect(result.data!.user!.id, 123);
      });

      test('should return error response with invalid credentials', () async {
        // Arrange
        dataSource.setErrorResponse('Invalid email or password');

        // Act
        final result = await dataSource.login(validLoginRequest);

        // Assert
        expect(result.status, 0);
        expect(result.message, 'Invalid email or password');
        expect(result.data, isNull);
      });

      test('should throw exception when network fails', () async {
        // Arrange
        dataSource.setNetworkException();

        // Act & Assert
        expect(
          () => dataSource.login(validLoginRequest),
          throwsException,
        );
      });
    });

    group('Register Operation', () {
      final validRegisterRequest = RegisterRequestDto(
        email: 'newuser@example.com',
        password: 'securePassword123',
        name: 'New User',
      );

      test('should return success when registration is valid', () async {
        // Arrange
        dataSource.setSuccessResponse();

        // Act
        final result = await dataSource.register(validRegisterRequest);

        // Assert
        expect(result.status, 1);
        expect(result.message, 'Registration successful');
        expect(result.data, true);
      });

      test('should return error when registration fails', () async {
        // Arrange
        dataSource.setErrorResponse('Email already exists');

        // Act
        final result = await dataSource.register(validRegisterRequest);

        // Assert
        expect(result.status, 0);
        expect(result.message, 'Email already exists');
        expect(result.data, false);
      });

      test('should throw exception when network fails during registration', () async {
        // Arrange
        dataSource.setNetworkException();

        // Act & Assert
        expect(
          () => dataSource.register(validRegisterRequest),
          throwsException,
        );
      });
    });

    group('Token Refresh Operation', () {
      const validRefreshToken = 'valid_refresh_token_123';

      test('should return new access token when refresh is successful', () async {
        // Arrange
        dataSource.setSuccessResponse();

        // Act
        final result = await dataSource.refreshToken(validRefreshToken);

        // Assert
        expect(result.status, 1);
        expect(result.message, 'Token refreshed successfully');
        expect(result.data, isNotNull);
        expect(result.data!.accessToken, 'new_access_token_from_refresh');
      });

      test('should return error when refresh token is invalid', () async {
        // Arrange
        dataSource.setErrorResponse('Invalid refresh token');

        // Act
        final result = await dataSource.refreshToken(validRefreshToken);

        // Assert
        expect(result.status, 0);
        expect(result.message, 'Invalid refresh token');
        expect(result.data, isNull);
      });

      test('should throw exception when network fails during token refresh', () async {
        // Arrange
        dataSource.setNetworkException();

        // Act & Assert
        expect(
          () => dataSource.refreshToken(validRefreshToken),
          throwsException,
        );
      });
    });
  });
}
