# Token Storage System Documentation

## Tổng quan

Hệ thống lưu trữ token được xây dựng theo kiến trúc Clean Architecture với các layer:

- **Domain Layer**: Chứa entities, repositories interfaces, và use cases
- **Data Layer**: Chứa implementations của repositories và data sources
- **Presentation Layer**: Chứa providers và UI logic

## Cấu trúc

### Domain Layer

1. **AuthEntity**: Entity chứa access token và refresh token
   ```dart
   class AuthEntity {
     final String accessToken;
     final String refreshToken;
   }
   ```

2. **TokenStorageRepository**: Interface cho việc lưu trữ token
   - `storeTokens(AuthEntity tokens)`: Lưu tokens
   - `getTokens()`: Lấy tokens đã lưu
   - `clearTokens()`: Xóa tokens
   - `hasTokens()`: Kiểm tra có tokens không
   - `updateAccessToken(String accessToken)`: Cập nhật access token

3. **Use Cases**:
   - `StoreTokensUseCase`: Lưu tokens
   - `GetTokensUseCase`: Lấy tokens
   - `ClearTokensUseCase`: Xóa tokens

### Data Layer

1. **TokenModel**: Model cho JSON serialization
   ```dart
   @freezed
   class TokenModel with _$TokenModel {
     const factory TokenModel({
       @JsonKey(name: 'access_token') required String accessToken,
       @JsonKey(name: 'refresh_token') required String refreshToken,
     }) = _TokenModel;
   }
   ```

2. **TokenLocalDataSource**: Interface cho local storage
3. **TokenLocalDataSourceImpl**: Implementation sử dụng SharedPreferences
4. **TokenStorageRepositoryImpl**: Implementation của repository

### Presentation Layer

1. **AuthNotifier**: StateNotifier quản lý authentication state
2. **Providers**: Riverpod providers cho dependency injection

## Cách sử dụng

### 1. Setup trong main.dart

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: MyApp(),
    ),
  );
}
```

### 2. Sử dụng trong Widget

```dart
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);
    
    return Scaffold(
      body: Column(
        children: [
          // Login form...
          ElevatedButton(
            onPressed: () async {
              await authNotifier.login(
                email: email,
                password: password,
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
```

### 3. Kiểm tra authentication status

```dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authStateProvider.select((state) => state.isAuthenticated));
    
    // Kiểm tra tokens đã lưu khi app khởi động
    ref.listen(authStateProvider, (previous, next) {
      // Handle auth state changes
    });
    
    return MaterialApp(
      home: isAuthenticated ? HomeScreen() : LoginScreen(),
    );
  }
}
```

## Tính năng

### Auto Login
- Tokens được lưu tự động sau khi login thành công
- Kiểm tra tokens đã lưu khi app khởi động
- Tự động set authentication status

### Token Management
- Lưu trữ an toàn bằng SharedPreferences
- Hỗ trợ update access token riêng biệt
- Clear tokens khi logout

### Error Handling
- Xử lý lỗi khi lưu/đọc tokens
- Logging đầy đủ cho debugging

## Các Provider có sẵn

### Token Storage Providers
```dart
// Providers cơ bản
final tokenStorageRepositoryProvider
final storeTokensUseCaseProvider
final getTokensUseCaseProvider
final clearTokensUseCaseProvider

// Providers tiện ích
final isAuthenticatedProvider  // bool
final accessTokenProvider      // String?
final refreshTokenProvider     // String?
```

### Auth Providers
```dart
final authStateProvider        // StateNotifierProvider<AuthNotifier, AuthState>
```

## Ví dụ hoàn chình

Xem file `token_storage_example.dart` để có ví dụ đầy đủ về cách sử dụng hệ thống.
