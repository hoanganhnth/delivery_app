import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';

import 'package:delivery_app/features/user_address/application/address_store_state.dart';
import 'package:delivery_app/features/user_address/di/user_address_di_providers.dart';

part 'address_list_notifier.g.dart';

/// Notifier cho quản lý danh sách địa chỉ
@riverpod
class UserAddressListNotifier extends _$UserAddressListNotifier {
  int _loadGeneration = 0;

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
    // A new identity must never render the previous identity's addresses while
    // the request is in flight.
    state = const UserAddressListState(isLoading: true);

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
        state = state.copyWith(isLoading: false, addresses: addresses);
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
            selectedAddress: state.selectedAddress?.id == addressId
                ? null
                : state.selectedAddress,
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
    state = state.copyWith(selectedAddress: address);
  }

  /// Auto select default address if no address is selected
  void autoSelectDefaultAddress() {
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
}
