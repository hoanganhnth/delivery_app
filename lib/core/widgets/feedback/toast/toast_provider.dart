import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toast_provider.g.dart';

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
@riverpod
class Toast extends _$Toast {
  @override
  ToastMessage? build() => null;

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
