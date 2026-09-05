import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';

import 'package:delivery_app/features/user_address/application/address_store_state.dart';
import 'package:delivery_app/features/user_address/di/user_address_di_providers.dart';

part 'address_list_notifier.g.dart';

/// Notifier cho quản lý danh sách địa chỉ
@riverpod
class UserAddressListNotifier extends _$UserAddressListNotifier {
  int _loadGeneration = 0;
  int? _loadedProfileId;

  @override
  UserAddressListState build() {
    return const UserAddressListState();
  }

  /// Load danh sách địa chỉ của user
  Future<bool> loadAddresses(int userId) async {
    if (userId <= 0) {
      clear();
      return false;
    }

    final generation = ++_loadGeneration;
    final preserveSelections = _loadedProfileId == userId;
    final previous = state;
    // A new identity must never render the previous identity's addresses while
    // the request is in flight.
    state = UserAddressListState(
      isLoading: true,
      selectedAddress: preserveSelections ? previous.selectedAddress : null,
      checkoutSelectedAddress: preserveSelections
          ? previous.checkoutSelectedAddress
          : null,
    );

    final getUserAddressesUseCase = ref.read(getUserAddressesUseCaseProvider);
    final result = await getUserAddressesUseCase(userId);

    if (!ref.mounted || generation != _loadGeneration) {
      return false;
    }

    return result.fold<bool>(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
        return false;
      },
      (addresses) {
        _loadedProfileId = userId;
        state = state.copyWith(
          isLoading: false,
          addresses: addresses,
          selectedAddress: _addressInList(addresses, state.selectedAddress),
          checkoutSelectedAddress: _addressInList(
            addresses,
            state.checkoutSelectedAddress,
          ),
        );
        return true;
      },
    );
  }

  /// Xóa địa chỉ
  Future<void> deleteAddress(int addressId) async {
    // Find address label for toast message
    final address = state.addresses.firstWhere((addr) => addr.id == addressId);
    final addressLabel = address.label;

    final deleteAddressUseCase = ref.read(deleteAddressUseCaseProvider);
    final result = await deleteAddressUseCase(addressId);

    result.fold(
      (failure) {
        state = state.copyWith(
          lastOperation: OperationResult(
            type: 'delete',
            isSuccess: false,
            timestamp: DateTime.now(),
          ),
        );
      },
      (success) {
        if (success) {
          // Remove từ state
          final updatedAddresses = state.addresses
              .where((address) => address.id != addressId)
              .toList();
          state = state.copyWith(
            addresses: updatedAddresses,
            clearSelectedAddress: state.selectedAddress?.id == addressId,
            clearCheckoutSelectedAddress:
                state.checkoutSelectedAddress?.id == addressId,
            lastOperation: OperationResult(
              type: 'delete',
              isSuccess: true,
              addressLabel: addressLabel,
              timestamp: DateTime.now(),
            ),
          );
        } else {
          state = state.copyWith(
            lastOperation: OperationResult(
              type: 'delete',
              isSuccess: false,
              timestamp: DateTime.now(),
            ),
          );
        }
      },
    );
  }

  /// Đặt địa chỉ mặc định
  Future<void> setDefaultAddress(int addressId) async {
    // Find address label for toast message
    final address = state.addresses.firstWhere((addr) => addr.id == addressId);
    final addressLabel = address.label;

    final setDefaultAddressUseCase = ref.read(setDefaultAddressUseCaseProvider);
    final result = await setDefaultAddressUseCase(addressId);

    result.fold(
      (failure) {
        state = state.copyWith(
          lastOperation: OperationResult(
            type: 'setDefault',
            isSuccess: false,
            timestamp: DateTime.now(),
          ),
        );
      },
      (updatedAddress) {
        // Cập nhật state: bỏ default của các địa chỉ khác và set cho địa chỉ mới
        final updatedAddresses = state.addresses.map<UserAddressEntity>((
          address,
        ) {
          if (address.id == addressId) {
            return updatedAddress;
          } else {
            return address.copyWith(isDefault: false);
          }
        }).toList();

        state = state.copyWith(
          addresses: updatedAddresses,
          selectedAddress: _addressInList(
            updatedAddresses,
            state.selectedAddress,
          ),
          checkoutSelectedAddress: _addressInList(
            updatedAddresses,
            state.checkoutSelectedAddress,
          ),
          lastOperation: OperationResult(
            type: 'setDefault',
            isSuccess: true,
            addressLabel: addressLabel,
            timestamp: DateTime.now(),
          ),
        );
      },
    );
  }

  /// Refresh danh sách
  Future<void> refresh(int userId) async {
    await loadAddresses(userId);
  }

  /// Clear identity-scoped state after logout or before another profile loads.
  void clear() {
    _loadGeneration += 1;
    _loadedProfileId = null;
    state = const UserAddressListState();
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Clear operation result
  void clearOperation() {
    state = state.copyWith(clearOperation: true);
  }

  /// Select address
  void selectAddress(UserAddressEntity? address) {
    selectHomeAddress(address);
  }

  /// Select the address used by Home and catalog browsing.
  void selectHomeAddress(UserAddressEntity? address) {
    state = state.copyWith(selectedAddress: address);
  }

  /// Select an address only for the current Checkout session.
  void selectCheckoutAddress(UserAddressEntity? address) {
    state = state.copyWith(checkoutSelectedAddress: address);
  }

  /// Drop the temporary Checkout selection without changing Home.
  void clearCheckoutSelection() {
    if (state.checkoutSelectedAddress == null) return;
    state = state.copyWith(clearCheckoutSelectedAddress: true);
  }

  /// Start/restart Checkout from Home's current selection.
  void beginCheckoutSelection() {
    final homeSelection = _addressInList(
      state.addresses,
      state.selectedAddress,
    );
    final address = homeSelection ?? state.defaultAddress;
    if (address == null) {
      clearCheckoutSelection();
      return;
    }
    state = state.copyWith(checkoutSelectedAddress: address);
  }

  /// Auto select Home's default address if Home has no valid selection.
  void autoSelectDefaultAddress() {
    ensureHomeSelection();
  }

  void ensureHomeSelection() {
    final selectedId = state.selectedAddress?.id;
    final selectedIsCurrent =
        selectedId != null &&
        state.addresses.any((address) => address.id == selectedId);
    if (selectedIsCurrent) {
      return;
    }

    final defaultAddress = state.addresses
        .where((addr) => addr.isDefault)
        .firstOrNull;
    state = state.copyWith(selectedAddress: defaultAddress);
  }

  UserAddressEntity? _addressInList(
    List<UserAddressEntity> addresses,
    UserAddressEntity? candidate,
  ) {
    final candidateId = candidate?.id;
    if (candidateId == null) return null;
    return addresses.where((address) => address.id == candidateId).firstOrNull;
  }
}
