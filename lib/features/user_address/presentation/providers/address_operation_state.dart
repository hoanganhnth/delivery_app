import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_operation_state.g.dart';

/// Enum for operation types
enum UserAddressOperationType {
  delete,
  setDefault,
  create,
  update,
}

/// State for operation results
class AddressOperationResult {
  final UserAddressOperationType type;
  final bool isSuccess;
  final String? message;
  final DateTime timestamp;

  const AddressOperationResult({
    required this.type,
    required this.isSuccess,
    this.message,
    required this.timestamp,
  });

  AddressOperationResult copyWith({
    UserAddressOperationType? type,
    bool? isSuccess,
    String? message,
    DateTime? timestamp,
  }) {
    return AddressOperationResult(
      type: type ?? this.type,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

/// StateNotifier for operation results
@riverpod
class AddressOperationNotifier extends _$AddressOperationNotifier {
  @override
  AddressOperationResult? build() {
    return null;
  }

  void notifySuccess(UserAddressOperationType type, [String? message]) {
    state = AddressOperationResult(
      type: type,
      isSuccess: true,
      message: message,
      timestamp: DateTime.now(),
    );
  }

  void notifyError(UserAddressOperationType type, [String? message]) {
    state = AddressOperationResult(
      type: type,
      isSuccess: false,
      message: message,
      timestamp: DateTime.now(),
    );
  }

  void clear() {
    state = null;
  }
}
