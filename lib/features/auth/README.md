# Auth Module với Either (fpdart)

Module xác thực được thiết kế theo Clean Architecture với xử lý lỗi functional programming sử dụng Either từ fpdart.

## Cấu trúc

```
auth/
├── data/
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart
│   │   └── auth_remote_datasource_impl.dart
│   ├── dtos/
│   │   ├── auth_response_dto.dart
│   │   ├── login_request_dto.dart
│   │   ├── register_request_dto.dart
│   │   └── refresh_token_response_dto.dart
│   ├── models/
│   │   └── auth_model.dart
│   └── repositories_impl/
│       └── auth_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── user_entity.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_usecase.dart
│       ├── register_usecase.dart
│       └── refresh_token_usecase.dart
├── presentation/
│   ├── providers/
│   └── screens/
├── auth_injection.dart
├── auth_example.dart
└── README.md
```

## Tính năng chính

### 1. Xử lý lỗi với Either
- Sử dụng `Either<Failure, Success>` thay vì try-catch
- Functional programming approach
- Type-safe error handling

### 2. Clean Architecture
- Domain layer: Entities, Use cases, Repository interfaces
- Data layer: DTOs, Data sources, Repository implementations
- Presentation layer: UI components

### 3. Dependency Injection
- Centralized dependency management
- Easy testing và mocking

## Cách sử dụng

### 1. Khởi tạo dependencies

```dart
import 'package:delivery_app/features/auth/auth_injection.dart';

void main() {
  // Initialize auth module
  AuthInjection.init(
    getToken: () async {
      // Return stored access token
      return await SecureStorage.getAccessToken();
    },
    onRefreshToken: () async {
      // Handle token refresh
      return await AuthInjection.refreshTokenUseCase(
        RefreshTokenParams(refreshToken: storedRefreshToken)
      ).then((result) => result.fold(
        (failure) => null,
        (newToken) => newToken,
      ));
    },
  );
  
  runApp(MyApp());
}
```

### 2. Sử dụng Login Use Case

```dart
import 'package:fpdart/fpdart.dart';

Future<void> handleLogin(String email, String password) async {
  final loginUseCase = AuthInjection.loginUseCase;
  
  final params = LoginParams(
    email: email,
    password: password,
  );
  
  final result = await loginUseCase(params);
  
  result.fold(
    (failure) {
      // Handle error
      if (failure is ValidationFailure) {
        showValidationError(failure.message);
      } else if (failure is UnauthorizedFailure) {
        showInvalidCredentialsError();
      } else if (failure is ServerFailure) {
        showServerError();
      }
    },
    (user) {
      // Handle success
      await saveUserTokens(user.accessToken, user.refreshToken);
      navigateToMainScreen();
    },
  );
}
```

### 3. Sử dụng Register Use Case

```dart
Future<void> handleRegister(String email, String password, String confirmPassword) async {
  final registerUseCase = AuthInjection.registerUseCase;
  
  final params = RegisterParams(
    email: email,
    password: password,
    confirmPassword: confirmPassword,
    name: 'User Name', // optional
  );
  
  final result = await registerUseCase(params);
  
  result.fold(
    (failure) => handleRegistrationError(failure),
    (user) => handleRegistrationSuccess(user),
  );
}
```

### 4. Functional Programming Patterns

```dart
// Chain operations
final result = await loginUseCase(params);

final userProfile = result
  .map((user) => user.copyWith(name: user.name?.toUpperCase()))
  .flatMap((user) => validateUserProfile(user))
  .map((user) => UserProfile.fromEntity(user));

userProfile.fold(
  (failure) => print('Error: ${failure.message}'),
  (profile) => print('Profile: $profile'),
);

// Transform data
final accessToken = result.map((user) => user.accessToken);

// Validate and transform
final validatedUser = result.flatMap((user) {
  if (user.email.contains('@')) {
    return right(user);
  } else {
    return left(ValidationFailure('Invalid email'));
  }
});
```

## Types của Failure

```dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server Failure"]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = "Unauthorized"]);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = "Validation Error"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "Network Error"]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "Cache Error"]);
}
```

## Testing

```dart
// Mock repository for testing
class MockAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    if (email == 'test@example.com' && password == 'password') {
      return right(UserEntity(
        id: '1',
        email: email,
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
      ));
    }
    return left(UnauthorizedFailure('Invalid credentials'));
  }
  
  // ... other methods
}

// Test use case
void main() {
  group('LoginUseCase', () {
    late LoginUseCase loginUseCase;
    late MockAuthRepository mockRepository;
    
    setUp(() {
      mockRepository = MockAuthRepository();
      loginUseCase = LoginUseCase(mockRepository);
    });
    
    test('should return user when login is successful', () async {
      // Arrange
      final params = LoginParams(
        email: 'test@example.com',
        password: 'password',
      );
      
      // Act
      final result = await loginUseCase(params);
      
      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Expected success but got failure'),
        (user) => expect(user.email, 'test@example.com'),
      );
    });
  });
}
```

## Lợi ích của Either

1. **Type Safety**: Compiler sẽ bắt buộc xử lý cả success và error cases
2. **Functional**: Có thể chain operations mà không cần nested try-catch
3. **Explicit**: Error handling rõ ràng và dễ đọc
4. **Composable**: Dễ dàng combine và transform results
5. **Testable**: Dễ test cả success và error scenarios

## Demo

Chạy `auth_example.dart` để xem demo đầy đủ về cách sử dụng auth module với Either.
