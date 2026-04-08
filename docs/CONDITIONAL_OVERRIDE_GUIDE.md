# 🔐 Conditional Override - Token Injection Smart Logic

## 🎯 Vấn đề

Khi override unconditionally, user chưa login sẽ bị gửi:
```
Authorization: Bearer null  ❌ INVALID
```

## ✅ Giải pháp: Conditional Override

Chỉ override khi user đã authenticated:

```dart
// lib/main.dart
core_net.authenticatedDioProvider.overrideWith((ref) {
  final authState = ref.watch(authProvider);
  
  // ✅ Nếu đã login, dùng authAwareDio (có token)
  if (authState.isAuthenticated && authState.accessToken != null) {
    return ref.watch(auth_net.authAwareDioProvider);
  }
  
  // ❌ Chưa login, dùng Dio mặc định (không token)
  return DioClient().dio;
})
```

---

## 📊 Logic Flow

### Scenario 1: User chưa login

```
main.dart override
  ├─ authState.isAuthenticated = false
  ├─ authState.accessToken = null
  └─ Check: if (false && null) → FALSE
     └─ return DioClient().dio  ✅
        ├─ No token
        ├─ Can call: POST /login
        ├─ Can call: POST /register
        └─ Cannot call: GET /orders (protected)
```

### Scenario 2: User đã login

```
main.dart override
  ├─ authState.isAuthenticated = true
  ├─ authState.accessToken = "eyJhbGc..."
  └─ Check: if (true && "token") → TRUE
     └─ return ref.watch(authAwareDioProvider)  ✅
        ├─ Has token
        ├─ Can call: POST /login (with token)
        ├─ Can call: GET /orders (protected)
        ├─ Can call: GET /user (protected)
        └─ API request: Authorization: Bearer "token"
```

---

## 🔄 Workflow

```
┌──────────────────────────────────────────────────────┐
│ App Startup (main.dart)                              │
├──────────────────────────────────────────────────────┤
│                                                      │
│ 1. Read authProvider state                          │
│                                                      │
│ 2. isAuthenticated?                                 │
│    ├─ NO  → Dio without token                       │
│    │       └─ Login Screen                          │
│    │          └─ POST /login → Success              │
│    │             └─ AuthNotifier.login()            │
│    │                └─ authState = authenticated    │
│    │                   └─ accessToken = "token"     │
│    │                      ↓                         │
│    └─ YES → Dio with token                          │
│            └─ Orders Screen                         │
│               └─ GET /orders                        │
│                  └─ Authorization: Bearer token ✅  │
│                                                      │
└──────────────────────────────────────────────────────┘
```

---

## 🎯 Advantages

| Case | Before (Unconditional) | After (Conditional) |
|------|------------------------|-------------------|
| **User not login** | Bearer null ❌ | No Authorization ✅ |
| **Login request** | Bearer null → Invalid ❌ | No Bearer → Valid ✅ |
| **User logged in** | Bearer token ✅ | Bearer token ✅ |
| **API calls** | All same Dio | Smart Dio based on auth |

---

## 💡 Key Points

### 1. **ref.watch(authProvider)**
```dart
// Watch auth state reactively
final authState = ref.watch(authProvider);

// Khi authState thay đổi:
// - isAuthenticated: false → true
// - accessToken: null → "token"
// → Riverpod tự động rebuild override
// → authenticatedDioProvider tự động switch
```

### 2. **Automatic Provider Switch**
```dart
// Trước login:
authenticatedDioProvider → DioClient() [NO TOKEN]

// Sau login:
authenticatedDioProvider → DioClient(getToken: ...) [WITH TOKEN]
// (Tự động, không cần restart app)
```

### 3. **Zero Code Change in Features**
```dart
// lib/features/orders/providers/order_providers.dart
final orderApiServiceProvider = Provider((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return OrderApiService(dio);  // ← Vẫn giống cũ
});

// Nhưng giờ:
// - Trước login: Dio không token
// - Sau login: Dio có token
// ✅ Tự động chuyển đổi!
```

---

## 🧪 Testing Scenarios

### Test 1: Login Flow
```dart
test('Should use tokenless Dio before login', () {
  // Before login
  final dio = ref.watch(authenticatedDioProvider);
  expect(dio.interceptors, contains(isA<RequestInterceptor>()));
  // Token sẽ null
});

test('Should use token Dio after login', () {
  // After login
  ref.read(authProvider.notifier).login(...);
  final dio = ref.watch(authenticatedDioProvider);
  // Token sẽ "abc123..."
});
```

### Test 2: Orders API
```dart
test('Orders API should fail before login', () {
  // GET /orders without token
  final result = await ref.read(ordersListProvider.future);
  expect(result, isLeft(Failure)); // 401 Unauthorized
});

test('Orders API should succeed after login', () {
  // Login first
  await ref.read(authProvider.notifier).login(...);
  
  // GET /orders with token
  final result = await ref.read(ordersListProvider.future);
  expect(result, isRight(List<Order>)); // 200 OK
});
```

---

## 🚀 Implementation Checklist

- [x] Add DioClient import
- [x] Add auth_notifier import
- [x] Update override logic with conditional
- [x] Check authState.isAuthenticated
- [x] Check authState.accessToken != null
- [x] Return authAwareDio when authenticated
- [x] Return default DioClient when not authenticated
- [x] Validate no compile errors
- [x] Test login flow

---

## 📝 Code Review

### Before
```dart
// ❌ Always override dengan authAwareDio
core_net.authenticatedDioProvider.overrideWith(
  (ref) => ref.watch(auth_net.authAwareDioProvider)
),
```

### After
```dart
// ✅ Conditional override
core_net.authenticatedDioProvider.overrideWith((ref) {
  final authState = ref.watch(authProvider);
  
  if (authState.isAuthenticated && authState.accessToken != null) {
    return ref.watch(auth_net.authAwareDioProvider);
  }
  
  return DioClient().dio;
})
```

---

**Result:** Token được inject **thông minh** - chỉ khi user login, tất cả API calls tự động có token! 🎉
