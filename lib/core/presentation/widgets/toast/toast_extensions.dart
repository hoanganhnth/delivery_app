import 'package:flutter/material.dart';
import 'app_toast.dart';

/// Extension cho BuildContext để sử dụng toast dễ dàng hơn
extension ToastExtension on BuildContext {
  /// Hiển thị toast success
  void showSuccessToast(
    String message, {
    String? title,
    Duration? duration,
  }) {
    AppToast.showSuccess(
      context: this,
      message: message,
      title: title,
      duration: duration,
    );
  }

  /// Hiển thị toast error
  void showErrorToast(
    String message, {
    String? title,
    Duration? duration,
  }) {
    AppToast.showError(
      context: this,
      message: message,
      title: title,
      duration: duration,
    );
  }

  /// Hiển thị toast warning
  void showWarningToast(
    String message, {
    String? title,
    Duration? duration,
  }) {
    AppToast.showWarning(
      context: this,
      message: message,
      title: title,
      duration: duration,
    );
  }

  /// Hiển thị toast info
  void showInfoToast(
    String message, {
    String? title,
    Duration? duration,
  }) {
    AppToast.showInfo(
      context: this,
      message: message,
      title: title,
      duration: duration,
    );
  }
}

/// Extension cho String để hiển thị toast nhanh
extension StringToastExtension on String {
  /// Hiển thị toast success với message là string hiện tại
  void showAsSuccessToast(
    BuildContext context, {
    String? title,
    Duration? duration,
  }) {
    AppToast.showSuccess(
      context: context,
      message: this,
      title: title,
      duration: duration,
    );
  }

  /// Hiển thị toast error với message là string hiện tại
  void showAsErrorToast(
    BuildContext context, {
    String? title,
    Duration? duration,
  }) {
    AppToast.showError(
      context: context,
      message: this,
      title: title,
      duration: duration,
    );
  }

  /// Hiển thị toast warning với message là string hiện tại
  void showAsWarningToast(
    BuildContext context, {
    String? title,
    Duration? duration,
  }) {
    AppToast.showWarning(
      context: context,
      message: this,
      title: title,
      duration: duration,
    );
  }

  /// Hiển thị toast info với message là string hiện tại
  void showAsInfoToast(
    BuildContext context, {
    String? title,
    Duration? duration,
  }) {
    AppToast.showInfo(
      context: context,
      message: this,
      title: title,
      duration: duration,
    );
  }
}
