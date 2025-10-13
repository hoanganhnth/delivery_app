import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:delivery_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_usecase_test.mocks.dart';

// Generate mocks for domain layer tests
@GenerateMocks([AuthRepository])
void main() {
  late RegisterUseCase usecase;
  late MockAuthRepository mockRepository;

  // Provide dummy for Either type
  provideDummy<Either<Failure, bool>>(
    left(const ServerFailure('dummy')),
  );

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = RegisterUseCase(mockRepository);
  });

  group('RegisterUseCase - Domain Layer Tests', () {
    final validRegisterParams = RegisterParams(
      email: 'test@example.com',
      password: 'password123',
      confirmPassword: 'password123',
      name: 'Test User',
    );

    group('Input Validation', () {
      test('should return ValidationFailure when email is invalid', () async {
        // Arrange
        final invalidParams = RegisterParams(
          email: 'invalid-email',
          password: 'password123',
          confirmPassword: 'password123',
        );

        // Act
        final result = await usecase(invalidParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Invalid email format');
          },
          (success) => fail('Should not return success'),
        );

        verifyNever(mockRepository.register(any, any));
      });

      test('should return ValidationFailure when password is too short', () async {
        // Arrange
        final invalidParams = RegisterParams(
          email: 'test@example.com',
          password: '123', // Less than 6 characters
          confirmPassword: '123',
        );

        // Act
        final result = await usecase(invalidParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Password must be at least 6 characters');
          },
          (success) => fail('Should not return success'),
        );

        verifyNever(mockRepository.register(any, any));
      });

      test('should return ValidationFailure when passwords do not match', () async {
        // Arrange
        final invalidParams = RegisterParams(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'differentPassword',
        );

        // Act
        final result = await usecase(invalidParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ValidationFailure>());
            expect(failure.message, 'Passwords do not match');
          },
          (success) => fail('Should not return success'),
        );

        verifyNever(mockRepository.register(any, any));
      });
    });

    group('Business Logic Tests', () {
      test('should return true when registration is successful', () async {
        // Arrange
        when(mockRepository.register(any, any))
            .thenAnswer((_) async => right(true));

        // Act
        final result = await usecase(validRegisterParams);

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Should not return failure'),
          (success) => expect(success, true),
        );

        verify(mockRepository.register('test@example.com', 'password123')).called(1);
      });

      test('should return ServerFailure when repository returns failure', () async {
        // Arrange
        const serverFailure = ServerFailure('Email already exists');
        when(mockRepository.register(any, any))
            .thenAnswer((_) async => left(serverFailure));

        // Act
        final result = await usecase(validRegisterParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, 'Email already exists');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRepository.register('test@example.com', 'password123')).called(1);
      });

      test('should return NetworkFailure when repository returns network error', () async {
        // Arrange
        const networkFailure = NetworkFailure('No internet connection');
        when(mockRepository.register(any, any))
            .thenAnswer((_) async => left(networkFailure));

        // Act
        final result = await usecase(validRegisterParams);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<NetworkFailure>());
            expect(failure.message, 'No internet connection');
          },
          (success) => fail('Should not return success'),
        );

        verify(mockRepository.register('test@example.com', 'password123')).called(1);
      });
    });

    group('Edge Cases', () {
      test('should handle registration without name', () async {
        // Arrange
        final paramsWithoutName = RegisterParams(
          email: 'test@example.com',
          password: 'password123',
          confirmPassword: 'password123',
          // No name provided
        );

        when(mockRepository.register(any, any))
            .thenAnswer((_) async => right(true));

        // Act
        final result = await usecase(paramsWithoutName);

        // Assert
        expect(result.isRight(), true);
        verify(mockRepository.register('test@example.com', 'password123')).called(1);
      });

      test('should validate email format strictly', () async {
        // Arrange
        final testCases = [
          'invalid',
          '@example.com',
          'test@',
          'test @example.com',
        ];

        for (final invalidEmail in testCases) {
          // Reset mock for each test case
          reset(mockRepository);
          
          final params = RegisterParams(
            email: invalidEmail,
            password: 'password123',
            confirmPassword: 'password123',
          );

          // Act
          final result = await usecase(params);

          // Assert
          expect(result.isLeft(), true, reason: 'Should reject email: $invalidEmail');
          result.fold(
            (failure) => expect(failure, isA<ValidationFailure>()),
            (_) => fail('Should reject invalid email: $invalidEmail'),
          );
          
          // Verify repository was not called for this specific invalid email
          verifyNever(mockRepository.register(any, any));
        }
      });

      test('should validate minimum password requirements', () async {
        // Arrange
        final weakPasswords = ['', '1', '12', '123', '1234', '12345']; // All < 6 chars

        for (final weakPassword in weakPasswords) {
          final params = RegisterParams(
            email: 'test@example.com',
            password: weakPassword,
            confirmPassword: weakPassword,
          );

          // Act
          final result = await usecase(params);

          // Assert
          expect(result.isLeft(), true, reason: 'Should reject password: $weakPassword');
          result.fold(
            (failure) => expect(failure, isA<ValidationFailure>()),
            (_) => fail('Should reject weak password: $weakPassword'),
          );
        }

        verifyNever(mockRepository.register(any, any));
      });
    });
  });
}
