# 🔐 Dio Authentication Token Flow

## 📌 Vấn đề

Token luôn `null` khi gọi API vì **Orders feature dùng `authenticatedDioProvider`** (core - không có auth) thay vì **`authAwareDioProvider`** (auth feature - có token).

---

## 🏗️ Kiến trúc hiện tại

### 1. Core Layer (`lib/core/network/dio/`)

#### `authenticated_network_providers.dart`
```dart
@Riverpod(keepAlive: true)
Dio authenticatedDio(Ref ref) {
  // ❌ Default: KHÔNG có authentication
  final dioClient = DioClient();
  return dioClient.dio;
}
```

**Mục đích:** Provider mặc định, sẽ được **override** bởi auth module.

---

### 2. Auth Feature Layer (`lib/features/auth/presentation/providers/`)

#### `auth_network_providers.dart`
```dart
@Riverpod(keepAlive: true)
Dio authAwareDio(Ref ref) {
  final dioClient = DioClient(
    getToken: () async {
      // ✅ Lấy token từ AuthNotifier
      final authState = ref.read(authProvider);
      return authState.accessToken;
    },
    onRefreshToken: () async {
      // ✅ Refresh token khi hết hạn
      final authNotifier = ref.read(authProvider.notifier);
      return await authNotifier.refreshToken();
    },
  );
  return dioClient.dio;
}
```

**Mục đích:** Provider có authentication logic.

---

### 3. Orders Feature Layer (và các feature khác)

#### `order_providers.dart`
```dart
final orderApiServiceProvider = Provider<OrderApiService>((ref) {
  // ❌ BUG: Dùng authenticatedDioProvider (core - không có token)
  final dio = ref.watch(authenticatedDioProvider);
  return OrderApiService(dio);
});
```

---

## 🔧 Giải pháp: Provider Override trong `main.dart`

### File: `lib/main.dart`

```dart
import 'features/auth/presentation/providers/auth_network_providers.dart' as auth_net;
import 'core/network/dio/authenticated_network_providers.dart' as core_net;

Future<void> main() async {
  // ...

  runApp(
    AppSetup.setupApp(
      child: const MainApp(),
      additionalOverrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        
        // 🔑 KEY FIX: Override core provider với auth provider
        core_net.authenticatedDioProvider.overrideWith(
          (ref) => ref.watch(auth_net.authAwareDioProvider)
        ),
      ],
    ),
  );
}
```

---

## 📊 Token Flow Diagram

### ❌ Trước khi fix:

```
Orders Feature
    ↓
ref.watch(authenticatedDioProvider)  <- Core provider
    ↓
DioClient() <- KHÔNG có getToken callback
    ↓
RequestInterceptor
    ↓
final token = await getToken?.call()
    ↓
token = null ❌ (vì getToken là null)
```

### ✅ Sau khi fix:

```
Orders Feature
    ↓
ref.watch(authenticatedDioProvider)  <- Core provider
    ↓ [OVERRIDE in main.dart]
    ↓
ref.watch(authAwareDioProvider)      <- Auth provider
    ↓
DioClient(getToken: ...)  <- ✅ Có getToken callback
    ↓
RequestInterceptor
    ↓
final token = await getToken?.call()
    ↓
final authState = ref.read(authProvider)
    ↓
token = authState.accessToken ✅
    ↓
options.headers["Authorization"] = "Bearer $token"
```

---

## 🎯 Tại sao cần Override?

### 1. **Tránh Circular Dependency**
- Core layer không thể import Auth feature (vi phạm Clean Architecture)
- Auth feature có thể import Core layer
- Solution: Core cung cấp interface, Auth override implementation

### 2. **Separation of Concerns**
- Core: Định nghĩa networking infrastructure
- Auth: Quản lý authentication logic
- Features: Chỉ cần dùng `authenticatedDioProvider`, không cần biết nó được implement như thế nào

### 3. **Testability**
- Test có thể override `authenticatedDioProvider` với mock Dio
- Không cần thay đổi code feature

---

## 🔍 Debug Checklist

Nếu token vẫn null, kiểm tra:

### 1. **Auth State có token không?**
```dart
final authState = ref.read(authProvider);
print('Access Token: ${authState.accessToken}'); // Should not be null
```

### 2. **Provider có được override không?**
```dart
// In main.dart
additionalOverrides: [
  core_net.authenticatedDioProvider.overrideWith(...), // ✅ Phải có
]
```

### 3. **AuthNotifier có keepAlive không?**
```dart
@Riverpod(keepAlive: true)  // ✅ Bắt buộc để không bị dispose
class AuthNotifier extends _$AuthNotifier {
  // ...
}
```

### 4. **User đã login chưa?**
```dart
final authState = ref.read(authProvider);
print('Is Authenticated: ${authState.isAuthenticated}'); // Should be true
```

---

## 🚀 Best Practices

### 1. **Luôn dùng keepAlive cho Auth providers**
```dart
@Riverpod(keepAlive: true)  // ✅ Không bị dispose
Dio authAwareDio(Ref ref) {
  // ...
}
```

### 2. **Dùng ref.read cho callback**
```dart
getToken: () async {
  // ✅ ref.read - không watch để tránh rebuild
  final authState = ref.read(authProvider);
  return authState.accessToken;
}
```

### 3. **Dùng ref.watch cho override**
```dart
core_net.authenticatedDioProvider.overrideWith(
  // ✅ ref.watch - để reactive khi authAwareDio thay đổi
  (ref) => ref.watch(auth_net.authAwareDioProvider)
)
```

---

## 📝 Tóm tắt

| Component | Responsibility |
|-----------|---------------|
| **Core `authenticatedDioProvider`** | Interface/contract cho authenticated Dio |
| **Auth `authAwareDioProvider`** | Implementation với auth logic |
| **`main.dart` override** | Wire up implementation vào interface |
| **Features** | Dùng `authenticatedDioProvider` (transparent) |

**Key Point:** Features không cần biết authentication được implement như thế nào, chỉ cần dùng `authenticatedDioProvider` và nó sẽ tự động có token nhờ override trong `main.dart`.

---

## 🎓 Related Concepts

- **Dependency Injection** - Riverpod provider override
- **Clean Architecture** - Layer separation
- **Provider Pattern** - Interface vs Implementation
- **Riverpod keepAlive** - Prevent auto-dispose
