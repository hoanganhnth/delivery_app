# Toast System

Hệ thống toast chung cho toàn app sử dụng `toastification` package.

## Cài đặt

Thêm dependency vào `pubspec.yaml`:

```yaml
dependencies:
  toastification: ^2.3.0
```

## Cách sử dụng

### 1. Import

```dart
import 'package:delivery_app/core/presentation/widgets/toast/toast.dart';
```

### 2. Sử dụng cơ bản

#### Với AppToast class:

```dart
// Success toast
AppToast.showSuccess(
  context: context,
  message: 'Đăng nhập thành công!',
  title: 'Thành công', // Optional
  duration: Duration(seconds: 4), // Optional
);

// Error toast
AppToast.showError(
  context: context,
  message: 'Email hoặc mật khẩu không đúng!',
  title: 'Lỗi đăng nhập',
);

// Warning toast
AppToast.showWarning(
  context: context,
  message: 'Phiên đăng nhập sắp hết hạn!',
);

// Info toast
AppToast.showInfo(
  context: context,
  message: 'Có phiên bản mới của ứng dụng!',
);
```

#### Với BuildContext extension:

```dart
// Ngắn gọn hơn
context.showSuccessToast('Đăng nhập thành công!');
context.showErrorToast('Email hoặc mật khẩu không đúng!');
context.showWarningToast('Phiên đăng nhập sắp hết hạn!');
context.showInfoToast('Có phiên bản mới của ứng dụng!');
```

#### Với String extension:

```dart
// Sử dụng trực tiếp từ String
'Đăng nhập thành công!'.showAsSuccessToast(context);
'Có lỗi xảy ra!'.showAsErrorToast(context);
```

### 3. Sử dụng ToastUtils cho các trường hợp phổ biến

```dart
// Hiển thị toast từ Failure
ToastUtils.showFailureToast(context, failure);

// Toast cho đăng nhập
ToastUtils.showLoginSuccess(context, userName: 'John Doe');

// Toast cho đăng xuất
ToastUtils.showLogoutSuccess(context);

// Toast cho đặt hàng
ToastUtils.showOrderSuccess(context, orderId: 'ORD123');

// Toast cho lỗi mạng
ToastUtils.showNetworkError(context);

// Toast cho cảnh báo phiên hết hạn
ToastUtils.showSessionExpiredWarning(context);
```

### 4. Quản lý toast

```dart
// Đóng tất cả toast
AppToast.dismissAll();

// Đóng toast cụ thể (nếu có reference)
AppToast.dismiss(toastItem);
```

## Các loại toast

### 1. Success (Thành công)
- **Màu**: Xanh lá (#10B981)
- **Icon**: check_circle
- **Sử dụng**: Thông báo thành công như đăng nhập, đặt hàng, cập nhật...

### 2. Error (Lỗi)
- **Màu**: Đỏ (#EF4444)
- **Icon**: error
- **Sử dụng**: Thông báo lỗi như đăng nhập thất bại, lỗi server...

### 3. Warning (Cảnh báo)
- **Màu**: Vàng cam (#F59E0B)
- **Icon**: warning
- **Sử dụng**: Cảnh báo như phiên hết hạn, dữ liệu không hợp lệ...

### 4. Info (Thông tin)
- **Màu**: Xanh dương (#3B82F6)
- **Icon**: info
- **Sử dụng**: Thông tin như cập nhật app, thông báo hệ thống...

## Tùy chỉnh

### Duration (Thời gian hiển thị)

```dart
AppToast.showSuccess(
  context: context,
  message: 'Message',
  duration: Duration(seconds: 10), // Hiển thị 10 giây
);
```

### Custom title

```dart
context.showSuccessToast(
  'Đăng nhập thành công!',
  title: 'Chào mừng bạn!',
);
```

## Ví dụ trong UI với Riverpod

```dart
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to auth state changes
    ref.listen(authStateProvider, (previous, next) {
      // Hiển thị toast khi có lỗi
      if (next.hasError && next.failure != null) {
        ToastUtils.showFailureToast(context, next.failure!);
      }

      // Hiển thị toast khi đăng nhập thành công
      if (next.isAuthenticated && next.user != null) {
        ToastUtils.showLoginSuccess(context, userName: next.user!.name);
      }
    });

    return Scaffold(
      // ... UI
    );
  }
}
```

## Ví dụ trong UI

```dart
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ... UI elements
          
          ElevatedButton(
            onPressed: () async {
              final result = await authNotifier.login(email, password);
              
              result.fold(
                (failure) => context.showErrorToast(failure.message),
                (user) => context.showSuccessToast('Đăng nhập thành công!'),
              );
            },
            child: Text('Đăng nhập'),
          ),
        ],
      ),
    );
  }
}
```

## Demo

Để xem demo các loại toast, sử dụng `ToastDemoWidget`:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ToastDemoWidget(),
  ),
);
```

## Lưu ý

1. **Context**: Luôn đảm bảo context còn mounted trước khi hiển thị toast
2. **Performance**: Tránh hiển thị quá nhiều toast cùng lúc
3. **UX**: Sử dụng đúng loại toast cho đúng mục đích
4. **Duration**: Thời gian mặc định là 4 giây, có thể tùy chỉnh
5. **Accessibility**: Toast hỗ trợ accessibility tốt với toastification package
