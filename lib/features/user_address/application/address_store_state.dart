import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';

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
  static const _unset = Object();
  final bool isLoading;
  final List<UserAddressEntity> addresses;

  /// Home's persistent-in-session selection. Kept under the legacy name so
  /// existing catalog consumers continue to read the Home contract.
  final UserAddressEntity? selectedAddress;

  /// Checkout-only selection. It must never overwrite [selectedAddress].
  final UserAddressEntity? checkoutSelectedAddress;
  final String? errorMessage;
  final OperationResult? lastOperation;

  const UserAddressListState({
    this.isLoading = false,
    this.addresses = const [],
    this.selectedAddress,
    this.checkoutSelectedAddress,
    this.errorMessage,
    this.lastOperation,
  });

  UserAddressListState copyWith({
    bool? isLoading,
    List<UserAddressEntity>? addresses,
    Object? selectedAddress = _unset,
    Object? checkoutSelectedAddress = _unset,
    String? errorMessage,
    OperationResult? lastOperation,
    bool clearError = false,
    bool clearOperation = false,
    bool clearSelectedAddress = false,
    bool clearCheckoutSelectedAddress = false,
  }) {
    return UserAddressListState(
      isLoading: isLoading ?? this.isLoading,
      addresses: addresses ?? this.addresses,
      selectedAddress: clearSelectedAddress
          ? null
          : identical(selectedAddress, _unset)
          ? this.selectedAddress
          : selectedAddress as UserAddressEntity?,
      checkoutSelectedAddress: clearCheckoutSelectedAddress
          ? null
          : identical(checkoutSelectedAddress, _unset)
          ? this.checkoutSelectedAddress
          : checkoutSelectedAddress as UserAddressEntity?,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      lastOperation: clearOperation
          ? null
          : (lastOperation ?? this.lastOperation),
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
