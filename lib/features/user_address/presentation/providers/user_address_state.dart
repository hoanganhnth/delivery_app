import '../../domain/entities/user_address_entity.dart';

/// State classes cho user address management

/// Operation result for tracking success/error states
class OperationResult {
  final String type; // 'delete', 'setDefault', etc.
  final bool isSuccess;
  final String? addressLabel;
  final DateTime timestamp;

  const OperationResult({
    required this.type,
    required this.isSuccess,
    this.addressLabel,
    required this.timestamp,
  });
}

class UserAddressListState {
  final bool isLoading;
  final List<UserAddressEntity> addresses;
  final UserAddressEntity? selectedAddress;
  final String? errorMessage;
  final OperationResult? lastOperation;

  const UserAddressListState({
    this.isLoading = false,
    this.addresses = const [],
    this.selectedAddress,
    this.errorMessage,
    this.lastOperation,
  });

  UserAddressListState copyWith({
    bool? isLoading,
    List<UserAddressEntity>? addresses,
    UserAddressEntity? selectedAddress,
    String? errorMessage,
    OperationResult? lastOperation,
    bool clearError = false,
    bool clearOperation = false,
  }) {
    return UserAddressListState(
      isLoading: isLoading ?? this.isLoading,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastOperation: clearOperation ? null : (lastOperation ?? this.lastOperation),
    );
  }

  /// Lấy địa chỉ mặc định
  UserAddressEntity? get defaultAddress {
    try {
      return addresses.firstWhere((address) => address.isDefault);
    } catch (e) {
      return null;
    }
  }

  /// Kiểm tra có địa chỉ nào không
  bool get hasAddresses => addresses.isNotEmpty;

  /// Lấy số lượng địa chỉ
  int get addressCount => addresses.length;
}
