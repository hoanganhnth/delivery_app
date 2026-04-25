import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'toast.dart';

/// Widget demo để test các loại toast
class ToastDemoWidget extends StatelessWidget {
  const ToastDemoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Toast Demo',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.w),
            
            // Success Toast
            ElevatedButton.icon(
              onPressed: () {
                context.showSuccessToast(
                  'Đăng nhập thành công!',
                  title: 'Thành công',
                );
              },
              icon: Icon(Icons.check_circle, color: Colors.white),
              label: const Text('Success Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.w),
              ),
            ),
            
            SizedBox(height: 16.w),
            
            // Error Toast
            ElevatedButton.icon(
              onPressed: () {
                context.showErrorToast(
                  'Email hoặc mật khẩu không đúng!',
                  title: 'Đăng nhập thất bại',
                );
              },
              icon: Icon(Icons.error, color: Colors.white),
              label: const Text('Error Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.w),
              ),
            ),
            
            SizedBox(height: 16.w),
            
            // Warning Toast
            ElevatedButton.icon(
              onPressed: () {
                context.showWarningToast(
                  'Phiên đăng nhập sắp hết hạn!',
                  title: 'Cảnh báo',
                );
              },
              icon: Icon(Icons.warning, color: Colors.white),
              label: const Text('Warning Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.w),
              ),
            ),
            
            SizedBox(height: 16.w),
            
            // Info Toast
            ElevatedButton.icon(
              onPressed: () {
                context.showInfoToast(
                  'Có phiên bản mới của ứng dụng!',
                  title: 'Thông tin',
                );
              },
              icon: Icon(Icons.info, color: Colors.white),
              label: const Text('Info Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.w),
              ),
            ),
            
            SizedBox(height: 32.w),
            
            // Using String extension
            ElevatedButton.icon(
              onPressed: () {
                'Đây là toast từ String extension!'.showAsSuccessToast(context);
              },
              icon: Icon(Icons.extension),
              label: const Text('String Extension Toast'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.w),
              ),
            ),
            
            SizedBox(height: 16.w),
            
            // Custom duration
            ElevatedButton.icon(
              onPressed: () {
                AppToast.showSuccess(
                  context: context,
                  message: 'Toast này sẽ hiển thị trong 10 giây!',
                  title: 'Custom Duration',
                  duration: const Duration(seconds: 10),
                );
              },
              icon: Icon(Icons.timer),
              label: const Text('Custom Duration (10s)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.w),
              ),
            ),
            
            SizedBox(height: 32.w),
            
            // Dismiss all
            OutlinedButton.icon(
              onPressed: () {
                AppToast.dismissAll();
              },
              icon: Icon(Icons.clear_all),
              label: const Text('Dismiss All Toasts'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
