import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:delivery_app/features/auth/domain/repositories/token_storage_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/clear_tokens_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'clear_tokens_usecase_test.mocks.dart';

// Generate mocks for domain layer tests
@GenerateMocks([TokenStorageRepository])
void main() {
  late ClearTokensUseCase usecase;
  late MockTokenStorageRepository mockRepository;

  // Provide dummy for Either type
  provideDummy<Either<Failure, void>>(
    left(const ServerFailure('dummy')),
  );

  setUp(() {
    mockRepository = MockTokenStorageRepository();
    usecase = ClearTokensUseCase(mockRepository);
  });

  group('ClearTokensUseCase - Domain Layer Tests', () {
    group('Business Logic Tests', () {
      test('should clear tokens successfully', () async {
        // Arrange
        when(mockRepository.clearTokens())
            .thenAnswer((_) async => right(null));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isRight(), true);
        verify(mockRepository.clearTokens()).called(1);
      });

      test('should return CacheFailure when clear operation fails', () async {
        // Arrange
        const cacheFailure = CacheFailure('Failed to clear tokens');
        when(mockRepository.clearTokens())
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Failed to clear tokens');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRepository.clearTokens()).called(1);
      });
    });

    group('Edge Cases', () {
      test('should handle clearing already empty storage', () async {
        // Arrange
        when(mockRepository.clearTokens())
            .thenAnswer((_) async => right(null));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isRight(), true);
        verify(mockRepository.clearTokens()).called(1);
      });

      test('should handle storage access denied', () async {
        // Arrange
        const cacheFailure = CacheFailure('Storage access denied');
        when(mockRepository.clearTokens())
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Storage access denied');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRepository.clearTokens()).called(1);
      });

      test('should handle storage corruption during clear', () async {
        // Arrange
        const cacheFailure = CacheFailure('Storage corruption detected');
        when(mockRepository.clearTokens())
            .thenAnswer((_) async => left(cacheFailure));

        // Act
        final result = await usecase(NoParams());

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<CacheFailure>());
            expect(failure.message, 'Storage corruption detected');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRepository.clearTokens()).called(1);
      });

      test('should only call repository once per invocation', () async {
        // Arrange
        when(mockRepository.clearTokens())
            .thenAnswer((_) async => right(null));

        // Act
        await usecase(NoParams());
        await usecase(NoParams());

        // Assert
        verify(mockRepository.clearTokens()).called(2);
        verifyNoMoreInteractions(mockRepository);
      });
    });
  });
}
