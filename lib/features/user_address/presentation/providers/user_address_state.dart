import '../../domain/entities/user_address_entity.dart';

/// State classes cho user address management

class UserAddressListState {
  final bool isLoading;
  final List<UserAddressEntity> addresses;
  final UserAddressEntity? selectedAddress;
  final String? errorMessage;

  const UserAddressListState({
    this.isLoading = false,
    this.addresses = const [],
    this.selectedAddress,
    this.errorMessage,
  });

  UserAddressListState copyWith({
    bool? isLoading,
    List<UserAddressEntity>? addresses,
    UserAddressEntity? selectedAddress,
    String? errorMessage,
    bool clearError = false,
  }) {
    return UserAddressListState(
      isLoading: isLoading ?? this.isLoading,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
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
