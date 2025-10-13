import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/repositories/token_storage_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/store_tokens_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'store_tokens_usecase_test.mocks.dart';

// Generate mocks for domain layer tests
@GenerateMocks([TokenStorageRepository])
void main() {
  late StoreTokensUseCase usecase;
  late MockTokenStorageRepository mockRepository;

  // Provide dummy for Either type
  provideDummy<Either<Failure, void>>(
    left(const ServerFailure('dummy')),
  );

  setUp(() {
    mockRepository = MockTokenStorageRepository();
    usecase = StoreTokensUseCase(mockRepository);
  });

  group('StoreTokensUseCase - Domain Layer Tests', () {
    final validAuthEntity = AuthEntity(
      accessToken: 'access_token_123',
      refreshToken: 'refresh_token_456',
    );

    final validStoreTokensParams = StoreTokensParams(
      tokens: validAuthEntity,
    );

    group('Business Logic Tests', () {
      test('should store tokens successfully when valid tokens are provided', () async {
        // Arrange
        when(mockRepository.storeTokens(any))
            .thenAnswer((_) async => right(null));

        // Act
        final result = await usecase(validStoreTokensParams);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (success) {
            // void return type - just check that it succeeded
          },
        );

        verify(mockRepository.storeTokens(validAuthEntity)).called(1);
      });

      test('should return CacheFailure when storage operation fails', () async {
        // Arrange
        const cacheFailure = CacheFailure('Failed to store tokens');
        when(mockRepository.storeTokens(any))
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(validStoreTokensParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Failed to store tokens');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRepository.storeTokens(validAuthEntity)).called(1);
      });
    });

    group('Edge Cases', () {
      test('should handle storage unavailable gracefully', () async {
        // Arrange
        const cacheFailure = CacheFailure('Storage unavailable');
        when(mockRepository.storeTokens(any))
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(validStoreTokensParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Storage unavailable');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRepository.storeTokens(validAuthEntity)).called(1);
      });

      test('should handle disk space full error', () async {
        // Arrange
        const cacheFailure = CacheFailure('Insufficient storage space');
        when(mockRepository.storeTokens(any))
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(validStoreTokensParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Insufficient storage space');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRepository.storeTokens(validAuthEntity)).called(1);
      });

      test('should pass correct tokens to repository', () async {
        // Arrange
        when(mockRepository.storeTokens(any))
            .thenAnswer((_) async => right(null));

        // Act
        final result = await usecase(validStoreTokensParams);

        // Assert
        expect(result.isRight(), true);
        final captured = verify(mockRepository.storeTokens(captureAny)).captured.single as AuthEntity;
        expect(captured.accessToken, 'access_token_123');
        expect(captured.refreshToken, 'refresh_token_456');
      });

      test('should handle empty tokens gracefully', () async {
        // Arrange
        final emptyTokens = AuthEntity(
          accessToken: '',
          refreshToken: '',
        );
        final emptyParams = StoreTokensParams(tokens: emptyTokens);

        when(mockRepository.storeTokens(any))
            .thenAnswer((_) async => right(null));

        // Act
        final result = await usecase(emptyParams);

        // Assert
        expect(result.isRight(), true);
        verify(mockRepository.storeTokens(emptyTokens)).called(1);
      });
    });
  });
}
