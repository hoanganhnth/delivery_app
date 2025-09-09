import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:delivery_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/login_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/register_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/refresh_token_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

// Simple Mock DataSource Implementation
class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  bool shouldReturnSuccess = true;
  bool shouldThrowException = false;
  String? errorMessage;

  @override
  Future<AuthResponseDto> login(LoginRequestDto request) async {
    if (shouldThrowException) {
      throw Exception('Network error');
    }

    if (shouldReturnSuccess) {
      final authData = AuthDataDto(
        accessToken: 'test_access_token',
        refreshToken: 'test_refresh_token',
        user: UserDto(
          id: 1,
          email: request.email,
          name: 'Test User',
        ),
      );

      final response = AuthResponseDto(
        status: 1,
        message: 'Login successful',
        data: authData,
      );

      return response;
    } else {
      throw Exception(errorMessage ?? 'Login failed');
    }
  }

  @override
  Future<BaseResponseDto<bool>> register(RegisterRequestDto request) async {
    if (shouldThrowException) {
      throw Exception('Network error');
    }

    if (shouldReturnSuccess) {
      final response = BaseResponseDto<bool>(
        status: 1,
        message: 'Registration successful',
        data: true,
      );

      return response;
    } else {
      throw Exception(errorMessage ?? 'Registration failed');
    }
  }

  @override
  Future<RefreshTokenResponseDto> refreshToken(String refreshToken) async {
    if (shouldThrowException) {
      throw Exception('Network error');
    }

    if (shouldReturnSuccess) {
      final refreshData = RefreshTokenDataDto(
        accessToken: 'new_access_token',
      );

      final response = RefreshTokenResponseDto(
        status: 1,
        message: 'Token refreshed successfully',
        data: refreshData,
      );

      return response;
    } else {
      throw Exception(errorMessage ?? 'Token refresh failed');
    }
  }
}

void main() {
  late MockAuthRemoteDataSource dataSource;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
  });

  group('AuthRemoteDataSource Login Tests', () {
    final tLoginRequest = LoginRequestDto(
      email: 'test@example.com',
      password: 'password123',
      deviceId: 'device123',
      deviceName: 'iPhone 15',
      deviceType: 'iOS',
      ipAddress: '192.168.1.1',
    );

    test('should return success response when login is successful', () async {
      // arrange
      dataSource.shouldReturnSuccess = true;

      // act
      final result = await dataSource.login(tLoginRequest);

      // assert
      expect(result.status, 1);
      expect(result.message, 'Login successful');
      expect(result.data, isNotNull);
      expect(result.data!.accessToken, 'test_access_token');
      expect(result.data!.refreshToken, 'test_refresh_token');
      expect(result.data!.user!.email, 'test@example.com');
    });

    test('should throw exception when login returns error', () async {
      // arrange
      dataSource.shouldReturnSuccess = false;
      dataSource.errorMessage = 'Invalid credentials';

      // act & assert
      expect(
        () async => await dataSource.login(tLoginRequest),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Invalid credentials'),
        )),
      );
    });

    test('should throw exception when network error occurs', () async {
      // arrange
      dataSource.shouldThrowException = true;

      // act & assert
      expect(
        () async => await dataSource.login(tLoginRequest),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Network error'),
        )),
      );
    });
  });

  group('AuthRemoteDataSource Register Tests', () {
    final tRegisterRequest = RegisterRequestDto(
      email: 'test@example.com',
      password: 'password123',
      name: 'Test User',
    );

    test('should return success response when register is successful', () async {
      // arrange
      dataSource.shouldReturnSuccess = true;

      // act
      final result = await dataSource.register(tRegisterRequest);

      // assert
      expect(result.status, 1);
      expect(result.message, 'Registration successful');
      expect(result.data, isNotNull);
      expect(result.data, true);
    });

    test('should throw exception when register returns error', () async {
      // arrange
      dataSource.shouldReturnSuccess = false;
      dataSource.errorMessage = 'Email already exists';

      // act & assert
      expect(
        () async => await dataSource.register(tRegisterRequest),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Email already exists'),
        )),
      );
    });
  });

  group('AuthRemoteDataSource RefreshToken Tests', () {
    const tRefreshToken = 'test_refresh_token_123';

    test('should return new access token when refresh is successful', () async {
      // arrange
      dataSource.shouldReturnSuccess = true;

      // act
      final result = await dataSource.refreshToken(tRefreshToken);

      // assert
      expect(result.status, 1);
      expect(result.message, 'Token refreshed successfully');
      expect(result.data, isNotNull);
      expect(result.data!.accessToken, 'new_access_token');
    });

    test('should throw exception when refresh token is invalid', () async {
      // arrange
      dataSource.shouldReturnSuccess = false;
      dataSource.errorMessage = 'Invalid refresh token';

      // act & assert
      expect(
        () async => await dataSource.refreshToken(tRefreshToken),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Invalid refresh token'),
        )),
      );
    });

    test('should handle network error during token refresh', () async {
      // arrange
      dataSource.shouldThrowException = true;

      // act & assert
      expect(
        () async => await dataSource.refreshToken(tRefreshToken),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Network error'),
        )),
      );
    });
  });

  group('DataSource Interface Tests', () {
    test('should implement AuthRemoteDataSource interface', () {
      // assert
      expect(dataSource, isA<AuthRemoteDataSource>());
    });

    test('should handle all required methods', () async {
      // Test that all interface methods are implemented
      final loginRequest = LoginRequestDto(email: 'test@test.com', password: 'password');
      final registerRequest = RegisterRequestDto(email: 'test@test.com', password: 'password');

      // These should not throw compilation errors
      expect(() => dataSource.login(loginRequest), returnsNormally);
      expect(() => dataSource.register(registerRequest), returnsNormally);
      expect(() => dataSource.refreshToken('token'), returnsNormally);
    });
  });
}
