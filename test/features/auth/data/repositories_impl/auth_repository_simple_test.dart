import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/refresh_token_response_dto.dart';
import 'package:delivery_app/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:delivery_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock implementation
class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  bool shouldReturnSuccess = true;
  bool shouldThrowException = false;
  String? errorMessage;

  @override
  Future<AuthResponseDto> login(request) async {
    if (shouldThrowException) {
      throw Exception('Network error');
    }

    if (shouldReturnSuccess) {
      final authData = AuthDataDto(
        accessToken: 'test_access_token',
        refreshToken: 'test_refresh_token',
        user: UserDto(
          id: 1,
          email: 'test@example.com',
          name: 'Test User',
        ),
      );

      final response = BaseResponseDto<AuthDataDto>(
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
  Future<BaseResponseDto<bool>> register(request) async {
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

      final response = BaseResponseDto<RefreshTokenDataDto>(
        status: 1,
        message: 'Token refreshed',
        data: refreshData,
      );

      return response;
    } else {
      throw Exception(errorMessage ?? 'Token refresh failed');
    }
  }
}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  group('AuthRepositoryImpl Login Tests', () {
    test('should return AuthEntity when login is successful', () async {
      // arrange
      mockRemoteDataSource.shouldReturnSuccess = true;
      
      final loginParams = LoginParams(
        email: 'test@example.com',
        password: 'password123',
      );

      // act
      final result = await repository.login(loginParams);

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

    test('should return ServerFailure when login fails with invalid credentials', () async {
      // arrange
      mockRemoteDataSource.shouldReturnSuccess = false;
      mockRemoteDataSource.errorMessage = 'Invalid credentials';
      
      final loginParams = LoginParams(
        email: 'test@example.com',
        password: 'wrong_password',
      );

      // act
      final result = await repository.login(loginParams);

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

    test('should return ServerFailure when unexpected exception occurs', () async {
      // arrange
      mockRemoteDataSource.shouldThrowException = true;
      
      final loginParams = LoginParams(
        email: 'test@example.com',
        password: 'password123',
      );

      // act
      final result = await repository.login(loginParams);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect((failure as ServerFailure).message, 'Unexpected error occurred');
        },
        (success) => fail('Should return failure'),
      );
    });

    test('should return ServerFailure when response data is null', () async {
      // arrange
      mockRemoteDataSource.shouldReturnSuccess = false;
      mockRemoteDataSource.errorMessage = 'No data returned';
      
      final loginParams = LoginParams(
        email: 'test@example.com',
        password: 'password123',
      );

      // act
      final result = await repository.login(loginParams);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect((failure as ServerFailure).message, 'No data returned');
        },
        (success) => fail('Should return failure'),
      );
    });
  });

  group('AuthRepositoryImpl Register Tests', () {
    test('should return true when registration is successful', () async {
      // arrange
      mockRemoteDataSource.shouldReturnSuccess = true;

      // act
      final result = await repository.register('test@example.com', 'password123');

      // assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should return success'),
        (success) => expect(success, true),
      );
    });

    test('should return ServerFailure when registration fails', () async {
      // arrange
      mockRemoteDataSource.shouldReturnSuccess = false;
      mockRemoteDataSource.errorMessage = 'Email already exists';

      // act
      final result = await repository.register('test@example.com', 'password123');

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect((failure as ServerFailure).message, 'Email already exists');
        },
        (success) => fail('Should return failure'),
      );
    });
  });

  group('AuthRepositoryImpl Extension Tests', () {
    test('BaseResponseDto extension should work correctly', () {
      // Test isSuccess
      final successResponse = BaseResponseDto(
        status: 1,
        message: 'Success',
        data: 'test_data',
      );
      expect(successResponse.isSuccess, true);
      expect(successResponse.isError, false);

      // Test isError
      final errorResponse = BaseResponseDto(
        status: 0,
        message: 'Error',
        data: null,
      );
      expect(errorResponse.isSuccess, false);
      expect(errorResponse.isError, true);
    });

    test('AuthDataDto extension should convert to entity correctly', () {
      final authDataDto = AuthDataDto(
        accessToken: 'test_access_token',
        refreshToken: 'test_refresh_token',
        user: UserDto(
          id: 1,
          email: 'test@example.com',
          name: 'Test User',
        ),
      );

      final authEntity = authDataDto.toEntity();

      expect(authEntity.accessToken, 'test_access_token');
      expect(authEntity.refreshToken, 'test_refresh_token');
    });
  });
}
