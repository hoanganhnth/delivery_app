import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

// Generate mocks for domain layer tests
@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockRepository;

  // Provide dummy for Either type
  provideDummy<Either<Failure, AuthEntity>>(
    left(const ServerFailure('dummy')),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase - Domain Layer Tests', () {
    final validLoginParams = LoginParams(
      email: 'test@example.com',
      password: 'password123',
      deviceId: 'device-123',
      deviceName: 'Test Device',
      deviceType: 'iOS',
      ipAddress: '192.168.1.100',
    );

    final validAuthEntity = AuthEntity(
      accessToken: 'access_token_123',
      refreshToken: 'refresh_token_123',
    );

    group('Business Logic Tests', () {
      test('should return AuthEntity when credentials are valid and login succeeds', () async {
        // Arrange
        when(mockRepository.login(any))
            .thenAnswer((_) async => right(validAuthEntity));

        // Act
        final result = await usecase(validLoginParams);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (authEntity) {
            expect(authEntity.accessToken, 'access_token_123');
            expect(authEntity.refreshToken, 'refresh_token_123');
          },
        );

        verify(mockRepository.login(validLoginParams)).called(1);
      });

      test('should return ServerFailure when repository returns failure', () async {
        // Arrange
        const serverFailure = ServerFailure('Invalid credentials');
        when(mockRepository.login(any))
            .thenAnswer((_) async => left(serverFailure));

        // Act
        final result = await usecase(validLoginParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Invalid credentials');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.login(validLoginParams)).called(1);
      });

      test('should return NetworkFailure when repository returns network error', () async {
        // Arrange
        const networkFailure = NetworkFailure('No internet connection');
        when(mockRepository.login(any))
            .thenAnswer((_) async => left(networkFailure));

        // Act
        final result = await usecase(validLoginParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, 'No internet connection');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.login(validLoginParams)).called(1);
      });
    });

    group('Edge Cases', () {
      test('should handle empty device information gracefully', () async {
        // Arrange
        final paramsWithoutDevice = LoginParams(
          email: 'test@example.com',
          password: 'password123',
          // No device info provided
        );

        when(mockRepository.login(any))
            .thenAnswer((_) async => right(validAuthEntity));

        // Act
        final result = await usecase(paramsWithoutDevice);

        // Assert
        expect(result.isRight(), true);
        verify(mockRepository.login(paramsWithoutDevice)).called(1);
      });

      test('should validate required fields are passed to repository', () async {
        // Arrange
        when(mockRepository.login(any))
            .thenAnswer((_) async => right(validAuthEntity));

        // Act
        final result = await usecase(validLoginParams);

        // Assert
        expect(result.isRight(), true);
        final captured = verify(mockRepository.login(captureAny)).captured.single as LoginParams;
        expect(captured.email, 'test@example.com');
        expect(captured.password, 'password123');
        expect(captured.deviceId, 'device-123');
      });
    });
  });
}
