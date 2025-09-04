# Splash Screen System Documentation

## Tổng quan

Splash Screen System được thiết kế để xử lý khởi tạo app và điều hướng người dùng đến màn hình phù hợp khi app được mở.

## Cấu trúc

### 1. Splash Controller (`splash_controller.dart`)

Controller quản lý logic khởi tạo app và các trạng thái:

```dart
enum SplashState {
  initializing,    // Đang khởi tạo app
  checkingAuth,    // Đang kiểm tra authentication
  navigating,      // Đang điều hướng
  error,          // Có lỗi xảy ra
}
```

**Chức năng chính:**
- `initializeApp()`: Khởi tạo app và điều hướng
- `loadingMessage`: Lấy message tương ứng với state
- `hasError`: Kiểm tra có lỗi không

### 2. Splash Screen (`splash_screen.dart`)

UI component với animations và trạng thái tương tác:

**Tính năng:**
- ✨ Animated logo với fade và scale effects
- 📱 Responsive design
- 🔄 Loading indicator với status text
- ❌ Error handling với retry button
- 🎨 Themed colors và typography

### 3. Router Integration

**Initial Route**: `/splash` (được set trong `router_config.dart`)

**Navigation Flow:**
```
App Start → Splash Screen → Initialize App → Check Auth → Navigate to Login/Main
```

## Flow hoạt động

### 1. App Startup
1. App khởi động với route `/splash`
2. Splash Screen được hiển thị với animations
3. Splash Controller được kích hoạt

### 2. Initialization Process
```dart
SplashState.initializing → 
SplashState.checkingAuth → 
SplashState.navigating → 
Navigate to appropriate screen
```

### 3. Authentication Check
- Sử dụng `AppInitializerService` để:
  - Kiểm tra tokens đã lưu
  - Load user profile nếu đã authenticated
  - Set authentication state

### 4. Navigation Decision
- **Authenticated**: Navigate to `/main`
- **Not Authenticated**: Navigate to `/login`
- **Error**: Stay on splash with retry option

## Cấu hình

### Router Setup
```dart
// router_config.dart
const AppRouterConfig({
  this.initialLocation = '/splash', // ✅ Set splash as initial
});

// app_router.dart
GoRoute(
  path: AppRoutes.splash,
  name: 'splash',
  builder: (context, state) => const SplashScreen(),
),
```

### Provider Setup
```dart
final splashControllerProvider = StateNotifierProvider<SplashController, SplashState>((ref) {
  return SplashController(ref);
});
```

## Customization

### 1. Splash Duration
```dart
// Trong splash_controller.dart
await Future.delayed(const Duration(seconds: 2)); // Thay đổi duration
```

### 2. Animations
```dart
// Trong splash_screen.dart
AnimationController(
  duration: const Duration(milliseconds: 1500), // Thay đổi animation duration
  vsync: this,
);
```

### 3. UI Styling
```dart
// Tùy chỉnh colors, fonts, sizes trong build method
Text(
  'Delivery App',
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
    fontWeight: FontWeight.bold,
    color: Theme.of(context).primaryColor,
  ),
),
```

### 4. Error Handling
```dart
// Thêm logic xử lý lỗi cụ thể trong splash_controller.dart
catch (error, stackTrace) {
  if (error is NetworkException) {
    // Handle network error
  } else if (error is AuthException) {
    // Handle auth error
  }
  // ...
}
```

## Testing

### Unit Tests
```dart
// Test controller states
controller.state = SplashState.initializing;
expect(controller.loadingMessage, 'Initializing app...');

// Test error state
expect(controller.hasError, true);
```

### Widget Tests  
```dart
// Test UI elements
expect(find.byIcon(Icons.delivery_dining), findsOneWidget);
expect(find.text('Delivery App'), findsOneWidget);

// Test error state UI
expect(find.byIcon(Icons.error_outline), findsOneWidget);
expect(find.text('Retry'), findsOneWidget);
```

## Best Practices

### 1. Performance
- ✅ Minimum splash duration để không quá nhanh
- ✅ Lazy loading các resources không cần thiết
- ✅ Sử dụng SingleTickerProviderStateMixin cho animations

### 2. UX
- ✅ Smooth animations và transitions
- ✅ Clear loading states và progress indication
- ✅ Error handling với retry option
- ✅ Branded experience với logo và colors

### 3. Architecture
- ✅ Separation of concerns (Controller/UI)
- ✅ Proper state management với Riverpod
- ✅ Integration với existing auth system
- ✅ Testable code structure

## Troubleshooting

### Common Issues

1. **Splash không hiển thị**: Kiểm tra `initialLocation` trong router config
2. **Navigation không hoạt động**: Kiểm tra auth providers và routes
3. **Animations bị lag**: Sử dụng `SingleTickerProviderStateMixin`
4. **Memory leaks**: Đảm bảo dispose animation controllers

### Debug Tips

1. Enable router logging để trace navigation
2. Sử dụng `AppLogger` để debug initialization process
3. Check provider states trong DevTools
4. Test với các auth states khác nhau

## Example Usage

### Basic Implementation
```dart
// Đã được tích hợp sẵn, chỉ cần:
// 1. App sẽ tự động mở splash screen
// 2. Splash sẽ tự động initialize và navigate
// 3. Không cần code thêm gì!
```

### Custom Navigation
```dart
// Từ bất kỳ đâu trong app
context.goToSplash(); // Quay lại splash screen
```

### Manual Initialization
```dart
// Nếu cần khởi tạo lại
final controller = ref.read(splashControllerProvider.notifier);
await controller.initializeApp(router);
```
