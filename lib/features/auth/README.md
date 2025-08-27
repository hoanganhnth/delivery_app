# Auth Module với Either (fpdart) và Riverpod

Module xác thực được thiết kế theo Clean Architecture với xử lý lỗi functional programming sử dụng Either từ fpdart và state management với Riverpod.

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
│   │   ├── auth_providers.dart
│   │   ├── auth_state.dart
│   │   └── auth_notifier.dart
│   ├── screens/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   └── widgets/
│       └── auth_demo_widget.dart
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

### 3. Riverpod State Management
- Reactive state management
- Dependency injection với providers
- Type-safe và testable

### 4. Shared Dio Architecture
- Một Dio instance duy nhất cho toàn bộ app
- Auth module override authenticated Dio provider
- Tránh circular dependencies
- Dễ dàng testing và mocking

## Cách sử dụng

### 1. Setup với Riverpod và Shared Dio

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/app_setup.dart';

void main() {
  runApp(
    AppSetup.setupApp(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      home: AuthDemoWidget(),
    );
  }
}
```

### 2. Sử dụng với Riverpod trong Widget

```dart
class LoginWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);

    // Listen to state changes
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      } else if (next.isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    return Column(
      children: [
        if (authState.isLoginLoading)
          CircularProgressIndicator(),
        ElevatedButton(
          onPressed: authState.isLoginLoading ? null : () async {
            await authNotifier.login(
              email: emailController.text,
              password: passwordController.text,
            );
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
```

### 3. Sử dụng Direct Use Cases (nếu cần)

```dart
class AuthService extends ConsumerWidget {
  Future<void> directLogin(WidgetRef ref, String email, String password) async {
    final loginUseCase = ref.read(loginUseCaseProvider);

    final params = LoginParams(email: email, password: password);
    final result = await loginUseCase(params);

    result.fold(
      (failure) => print('Login failed: ${failure.message}'),
      (user) => print('Login success: ${user.email}'),
    );
  }
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

## Shared Dio Architecture

### Core Network Providers

```dart
// lib/core/network/network_providers.dart
final dioProvider = Provider<Dio>((ref) {
  final dioClient = DioClient();
  return dioClient.dio;
});

final authenticatedDioProvider = Provider<Dio>((ref) {
  // Default implementation, will be overridden by auth module
  return ref.watch(dioProvider);
});
```

### Auth Module Override

```dart
// lib/features/auth/presentation/providers/auth_network_providers.dart
final authAwareDioProvider = Provider<Dio>((ref) {
  final dioClient = DioClient(
    getToken: () async {
      final authState = ref.read(authStateProvider);
      return authState.user?.accessToken;
    },
    onRefreshToken: () async {
      final authNotifier = ref.read(authStateProvider.notifier);
      return await authNotifier.refreshToken();
    },
  );
  return dioClient.dio;
});

List<Override> getAppProviderOverrides() {
  return [
    authenticatedDioProvider.overrideWith((ref) => ref.watch(authAwareDioProvider)),
  ];
}
```

### Usage in Other Features

```dart
// Any other feature can use authenticated Dio
final someApiServiceProvider = Provider<SomeApiService>((ref) {
  final dio = ref.watch(authenticatedDioProvider); // Gets auth-aware Dio
  return SomeApiService(dio);
});
```

## Demo

Chạy `auth_example.dart` để xem demo đầy đủ về cách sử dụng auth module với Either và shared Dio.
