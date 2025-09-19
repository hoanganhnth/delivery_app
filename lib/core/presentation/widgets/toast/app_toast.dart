import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

/// Enum cho các loại toast
enum ToastType {
  success,
  error,
  warning,
  info,
}

/// Widget toast chung cho toàn app
class AppToast {
  AppToast._();

  /// Hiển thị toast success
  static void showSuccess({
    required BuildContext context,
    required String message,
    String? title,
    Duration? duration,
  }) {
    _showToast(
      context: context,
      type: ToastType.success,
      title: title ?? 'Thành công',
      message: message,
      duration: duration,
    );
  }

  /// Hiển thị toast error
  static void showError({
    required BuildContext context,
    required String message,
    String? title,
    Duration? duration,
  }) {
    _showToast(
      context: context,
      type: ToastType.error,
      title: title ?? 'Lỗi',
      message: message,
      duration: duration,
    );
  }

  /// Hiển thị toast warning
  static void showWarning({
    required BuildContext context,
    required String message,
    String? title,
    Duration? duration,
  }) {
    _showToast(
      context: context,
      type: ToastType.warning,
      title: title ?? 'Cảnh báo',
      message: message,
      duration: duration,
    );
  }

  /// Hiển thị toast info
  static void showInfo({
    required BuildContext context,
    required String message,
    String? title,
    Duration? duration,
  }) {
    _showToast(
      context: context,
      type: ToastType.info,
      title: title ?? 'Thông tin',
      message: message,
      duration: duration,
    );
  }

  /// Method chung để hiển thị toast
  static void _showToast({
    required BuildContext context,
    required ToastType type,
    required String title,
    required String message,
    Duration? duration,
  }) {
    final toastType = _getToastificationType(type);
    final primaryColor = _getPrimaryColor(type);
    final backgroundColor = _getBackgroundColor(type);
    final icon = _getIcon(type);

    toastification.show(
      context: context,
      type: toastType,
      // style: ToastificationStyle.fillColored,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
      description: Text(
        message,
        style: TextStyle(
          fontSize: 14.sp,
        ),
      ),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.w,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.w,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      autoCloseDuration: duration ?? const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).chain(
                CurveTween(curve: Curves.easeOut),
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }

  /// Lấy ToastificationType từ ToastType
  static ToastificationType _getToastificationType(ToastType type) {
    switch (type) {
      case ToastType.success:
        return ToastificationType.success;
      case ToastType.error:
        return ToastificationType.error;
      case ToastType.warning:
        return ToastificationType.warning;
      case ToastType.info:
        return ToastificationType.info;
    }
  }

  /// Lấy màu chính cho toast
  static Color _getPrimaryColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return const Color(0xFF10B981); // Green
      case ToastType.error:
        return const Color(0xFFEF4444); // Red
      case ToastType.warning:
        return const Color(0xFFF59E0B); // Amber
      case ToastType.info:
        return const Color(0xFF3B82F6); // Blue
    }
  }

  /// Lấy màu nền cho toast
  static Color _getBackgroundColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return const Color(0xFF10B981);
      case ToastType.error:
        return const Color(0xFFEF4444);
      case ToastType.warning:
        return const Color(0xFFF59E0B);
      case ToastType.info:
        return const Color(0xFF3B82F6);
    }
  }

  /// Lấy icon cho toast
  static IconData _getIcon(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }

  /// Đóng tất cả toast
  static void dismissAll() {
    toastification.dismissAll();
  }

  /// Đóng toast theo ID
  static void dismiss(ToastificationItem item) {
    toastification.dismiss(item);
  }
}
