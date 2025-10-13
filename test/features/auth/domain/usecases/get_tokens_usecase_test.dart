import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/repositories/token_storage_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/get_tokens_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_tokens_usecase_test.mocks.dart';

// Generate mocks for domain layer tests
@GenerateMocks([TokenStorageRepository])
void main() {
  late GetTokensUseCase usecase;
  late MockTokenStorageRepository mockRepository;

  // Provide dummy for Either type
  provideDummy<Either<Failure, AuthEntity?>>(
    left(const ServerFailure('dummy')),
  );

  setUp(() {
    mockRepository = MockTokenStorageRepository();
    usecase = GetTokensUseCase(mockRepository);
  });

  group('GetTokensUseCase - Domain Layer Tests', () {
    final validAuthEntity = AuthEntity(
      accessToken: 'stored_access_token_123',
      refreshToken: 'stored_refresh_token_456',
    );

    group('Business Logic Tests', () {
      test('should return AuthEntity when tokens are stored', () async {
        // Arrange
        when(mockRepository.getTokens())
            .thenAnswer((_) async => right(validAuthEntity));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (authEntity) {
            expect(authEntity, isNotNull);
            expect(authEntity!.accessToken, 'stored_access_token_123');
            expect(authEntity.refreshToken, 'stored_refresh_token_456');
          },
        );

        verify(mockRepository.getTokens()).called(1);
      });

      test('should return null when no tokens are stored', () async {
        // Arrange
        when(mockRepository.getTokens())
            .thenAnswer((_) async => right(null));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (authEntity) => expect(authEntity, isNull),
        );

        verify(mockRepository.getTokens()).called(1);
      });

      test('should return CacheFailure when storage operation fails', () async {
        // Arrange
        const cacheFailure = CacheFailure('Failed to read tokens');
        when(mockRepository.getTokens())
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Failed to read tokens');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.getTokens()).called(1);
      });
    });

    group('Edge Cases', () {
      test('should handle corrupted token data gracefully', () async {
        // Arrange
        const cacheFailure = CacheFailure('Corrupted token data');
        when(mockRepository.getTokens())
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Corrupted token data');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.getTokens()).called(1);
      });

      test('should handle device storage unavailable', () async {
        // Arrange
        const cacheFailure = CacheFailure('Storage unavailable');
        when(mockRepository.getTokens())
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Storage unavailable');
          },
          (authEntity) => fail('Should not return auth entity'),
        );

        verify(mockRepository.getTokens()).called(1);
      });

      test('should only call repository once per invocation', () async {
        // Arrange
        when(mockRepository.getTokens())
            .thenAnswer((_) async => right(validAuthEntity));

        // Act
        await usecase(NoParams());
        await usecase(NoParams());

        // Assert
        verify(mockRepository.getTokens()).called(2);
        verifyNoMoreInteractions(mockRepository);
      });
    });
  });
}
