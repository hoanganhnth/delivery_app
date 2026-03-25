import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user_address_entity.dart';
import '../../data/dtos/user_address_request_dto.dart';
import 'user_address_state.dart';
import 'user_address_providers.dart';

part 'user_address_notifiers.g.dart';

/// Notifier cho quản lý danh sách địa chỉ
@riverpod
class UserAddressListNotifier extends _$UserAddressListNotifier {
  @override
  UserAddressListState build() {
    return const UserAddressListState();
  }

  /// Load danh sách địa chỉ của user
  Future<void> loadAddresses(int userId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final getUserAddressesUseCase = ref.read(getUserAddressesUseCaseProvider);
    final result = await getUserAddressesUseCase(userId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (addresses) => state = state.copyWith(
        isLoading: false,
        addresses: addresses,
      ),
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
        final updatedAddresses = state.addresses.map<UserAddressEntity>((address) {
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
    if (state.selectedAddress == null) {
      final defaultAddress = state.addresses.where((addr) => addr.isDefault).firstOrNull;
      if (defaultAddress != null) {
        state = state.copyWith(selectedAddress: defaultAddress);
      }
    }
  }
}

/// Notifier cho tạo/cập nhật địa chỉ
@riverpod
class AddressFormNotifier extends _$AddressFormNotifier {
  @override
  AsyncValue<UserAddressEntity?> build() {
    return const AsyncValue.data(null);
  }

  /// Load địa chỉ để edit
  Future<void> loadAddress(int addressId) async {
    state = const AsyncValue.loading();

    final getAddressByIdUseCase = ref.read(getAddressByIdUseCaseProvider);
    final result = await getAddressByIdUseCase(addressId);

    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (address) => state = AsyncValue.data(address),
    );
  }

  /// Tạo địa chỉ mới
  Future<UserAddressEntity?> createAddress(
    int userId,
    UserAddressRequestDto request,
  ) async {
    state = const AsyncValue.loading();

    final createAddressUseCase = ref.read(createAddressUseCaseProvider);
    final result = await createAddressUseCase(userId, request);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return null;
      },
      (address) {
        state = AsyncValue.data(address);
        return address;
      },
    );
  }

  /// Cập nhật địa chỉ
  Future<UserAddressEntity?> updateAddress(
    int addressId,
    UserAddressRequestDto request,
  ) async {
    state = const AsyncValue.loading();

    final updateAddressUseCase = ref.read(updateAddressUseCaseProvider);
    final result = await updateAddressUseCase(addressId, request);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        return null;
      },
      (address) {
        state = AsyncValue.data(address);
        return address;
      },
    );
  }

  /// Reset state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
