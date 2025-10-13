import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Toast message types
enum ToastType {
  success,
  error,
  info,
}

/// Toast message data
class ToastMessage {
  final String message;
  final ToastType type;
  final DateTime timestamp;

  const ToastMessage({
    required this.message,
    required this.type,
    required this.timestamp,
  });
}

/// Toast notifier
class ToastNotifier extends StateNotifier<ToastMessage?> {
  ToastNotifier() : super(null);

  void showSuccess(String message) {
    state = ToastMessage(
      message: message,
      type: ToastType.success,
      timestamp: DateTime.now(),
    );
  }

  void showError(String message) {
    state = ToastMessage(
      message: message,
      type: ToastType.error,
      timestamp: DateTime.now(),
    );
  }

  void showInfo(String message) {
    state = ToastMessage(
      message: message,
      type: ToastType.info,
      timestamp: DateTime.now(),
    );
  }

  void clear() {
    state = null;
  }
}

/// Global toast provider
final toastProvider = StateNotifierProvider<ToastNotifier, ToastMessage?>((ref) {
  return ToastNotifier();
});
