import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

// Mock Repository
class MockAuthRepository implements AuthRepository {
  bool shouldReturnSuccess = true;
  String? errorMessage;

  @override
  Future<Either<Failure, AuthEntity>> login(LoginParams params) async {
    if (shouldReturnSuccess) {
      return right(AuthEntity(
        accessToken: 'test_access_token',
        refreshToken: 'test_refresh_token',
      ));
    } else {
      return left(ServerFailure(errorMessage ?? 'Login failed'));
    }
  }

  @override
  Future<Either<Failure, bool>> register(String email, String password) async {
    if (shouldReturnSuccess) {
      return right(true);
    } else {
      return left(ServerFailure(errorMessage ?? 'Registration failed'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> refreshToken(String refreshToken) async {
    if (shouldReturnSuccess) {
      return right(AuthEntity(
        accessToken: 'new_access_token',
        refreshToken: 'refresh_token',
      ));
    } else {
      return left(ServerFailure(errorMessage ?? 'Token refresh failed'));
    }
  }
}

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase Tests', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tDeviceId = 'device123';
    const tDeviceName = 'iPhone 15';
    const tDeviceType = 'iOS';
    const tIpAddress = '192.168.1.1';

    test('should return AuthEntity when login is successful', () async {
      // arrange
      mockRepository.shouldReturnSuccess = true;
      
      final params = LoginParams(
        email: tEmail,
        password: tPassword,
        deviceId: tDeviceId,
        deviceName: tDeviceName,
        deviceType: tDeviceType,
        ipAddress: tIpAddress,
      );

      // act
      final result = await loginUseCase(params);

      // assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should return success'),
        (authEntity) {
          expect(authEntity, isA<AuthEntity>());
          expect(authEntity.accessToken, 'test_access_token');
          expect(authEntity.refreshToken, 'test_refresh_token');
        },
      );
    });

    test('should return ServerFailure when login fails', () async {
      // arrange
      mockRepository.shouldReturnSuccess = false;
      mockRepository.errorMessage = 'Invalid credentials';
      
      final params = LoginParams(
        email: tEmail,
        password: 'wrong_password',
      );

      // act
      final result = await loginUseCase(params);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect((failure as ServerFailure).message, 'Invalid credentials');
        },
        (success) => fail('Should return failure'),
      );
    });

    test('should validate email format', () async {
      
      // arrange
      final params = LoginParams(
        email: 'invalid-email',
        password: tPassword,
      );

      // act
      final result = await loginUseCase(params);

      // assert - Assuming validation is implemented
      expect(result.isLeft(), true);
    });

    test('should validate password length', () async {
      // arrange
      final params = LoginParams(
        email: tEmail,
        password: '123', // Too short
      );

      // act
      final result = await loginUseCase(params);

      // assert - Assuming validation is implemented
      expect(result.isLeft(), true);
    });

    test('should handle empty email', () async {
      // arrange
      final params = LoginParams(
        email: '',
        password: tPassword,
      );

      // act
      final result = await loginUseCase(params);

      // assert
      expect(result.isLeft(), true);
    });

    test('should handle empty password', () async {
      // arrange
      final params = LoginParams(
        email: tEmail,
        password: '',
      );

      // act
      final result = await loginUseCase(params);

      // assert
      expect(result.isLeft(), true);
    });
  });

  group('LoginParams Tests', () {
    test('should create LoginParams with required fields', () {
      // arrange & act
      final params = LoginParams(
        email: 'test@example.com',
        password: 'password123',
      );

      // assert
      expect(params.email, 'test@example.com');
      expect(params.password, 'password123');
      expect(params.deviceId, null);
      expect(params.deviceName, null);
      expect(params.deviceType, null);
      expect(params.ipAddress, null);
    });

    test('should create LoginParams with all fields', () {
      // arrange & act
      final params = LoginParams(
        email: 'test@example.com',
        password: 'password123',
        deviceId: 'device123',
        deviceName: 'iPhone 15',
        deviceType: 'iOS',
        ipAddress: '192.168.1.1',
      );

      // assert
      expect(params.email, 'test@example.com');
      expect(params.password, 'password123');
      expect(params.deviceId, 'device123');
      expect(params.deviceName, 'iPhone 15');
      expect(params.deviceType, 'iOS');
      expect(params.ipAddress, '192.168.1.1');
    });

    test('should support equality comparison', () {
      // arrange
      final params1 = LoginParams(
        email: 'test@example.com',
        password: 'password123',
      );
      
      final params2 = LoginParams(
        email: 'test@example.com',
        password: 'password123',
      );

      final params3 = LoginParams(
        email: 'different@example.com',
        password: 'password123',
      );

      // assert
      expect(params1 == params2, true);
      expect(params1 == params3, false);
    });

    test('should have proper toString representation', () {
      // arrange
      final params = LoginParams(
        email: 'test@example.com',
        password: 'password123',
        deviceId: 'device123',
      );

      // act
      final stringRepresentation = params.toString();

      // assert
      expect(stringRepresentation, contains('test@example.com'));
      expect(stringRepresentation, contains('device123'));
      // Password should not be in toString for security
      expect(stringRepresentation, isNot(contains('password123')));
    });
  });
}
