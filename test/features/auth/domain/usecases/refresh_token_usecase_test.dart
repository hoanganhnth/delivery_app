import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'refresh_token_usecase_test.mocks.dart';

// Generate mocks for domain layer tests
@GenerateMocks([AuthRepository])
void main() {
  late RefreshTokenUseCase usecase;
  late MockAuthRepository mockRepository;

  // Provide dummy for Either type
  provideDummy<Either<Failure, AuthEntity>>(
    left(const ServerFailure('dummy')),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = RefreshTokenUseCase(mockRepository);
  });

  group('RefreshTokenUseCase - Domain Layer Tests', () {
    final validRefreshTokenParams = RefreshTokenParams(
      refreshToken: 'valid_refresh_token_123',
    );

    final validAuthEntity = AuthEntity(
      accessToken: 'new_access_token_456',
      refreshToken: 'new_refresh_token_789',
    );

    group('Input Validation', () {
      test('should return ValidationFailure when refresh token is empty', () async {
        // Arrange
        final invalidParams = RefreshTokenParams(
          refreshToken: '',
        );

        // Act
        final result = await usecase(invalidParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Refresh token cannot be empty');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verifyNever(mockRepository.refreshToken(any));
      });
    });

    group('Business Logic Tests', () {
      test('should return new AuthEntity when refresh token is valid', () async {
        // Arrange
        when(mockRepository.refreshToken(any))
            .thenAnswer((_) async => right(validAuthEntity));

        // Act
        final result = await usecase(validRefreshTokenParams);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (authEntity) {
            expect(authEntity.accessToken, 'new_access_token_456');
            expect(authEntity.refreshToken, 'new_refresh_token_789');
          },
        );

        verify(mockRepository.refreshToken('valid_refresh_token_123')).called(1);
      });

      test('should return ServerFailure when refresh token is invalid', () async {
        // Arrange
        const serverFailure = ServerFailure('Invalid refresh token');
        when(mockRepository.refreshToken(any))
            .thenAnswer((_) async => left(serverFailure));

        // Act
        final result = await usecase(validRefreshTokenParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Invalid refresh token');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.refreshToken('valid_refresh_token_123')).called(1);
      });

      test('should return NetworkFailure when repository returns network error', () async {
        // Arrange
        const networkFailure = NetworkFailure('No internet connection');
        when(mockRepository.refreshToken(any))
            .thenAnswer((_) async => left(networkFailure));

        // Act
        final result = await usecase(validRefreshTokenParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, 'No internet connection');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.refreshToken('valid_refresh_token_123')).called(1);
      });
    });

    group('Edge Cases', () {
      test('should handle malformed refresh token', () async {
        // Arrange
        final malformedParams = RefreshTokenParams(
          refreshToken: 'malformed.token.here',
        );

        const serverFailure = ServerFailure('Malformed token');
        when(mockRepository.refreshToken(any))
            .thenAnswer((_) async => left(serverFailure));

        // Act
        final result = await usecase(malformedParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Malformed token');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.refreshToken('malformed.token.here')).called(1);
      });

      test('should handle expired refresh token', () async {
        // Arrange
        final expiredParams = RefreshTokenParams(
          refreshToken: 'expired_refresh_token',
        );

        const serverFailure = ServerFailure('Refresh token expired');
        when(mockRepository.refreshToken(any))
            .thenAnswer((_) async => left(serverFailure));

        // Act
        final result = await usecase(expiredParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Refresh token expired');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.refreshToken('expired_refresh_token')).called(1);
      });

      test('should validate token is passed correctly to repository', () async {
        // Arrange
        when(mockRepository.refreshToken(any))
            .thenAnswer((_) async => right(validAuthEntity));

        // Act
        final result = await usecase(validRefreshTokenParams);

        // Assert
        expect(result.isRight(), true);
        final captured = verify(mockRepository.refreshToken(captureAny)).captured.single as String;
        expect(captured, 'valid_refresh_token_123');
      });
    });
  });
}
