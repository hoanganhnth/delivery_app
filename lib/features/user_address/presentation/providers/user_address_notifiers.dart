import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_address_entity.dart';
import '../../data/dtos/user_address_request_dto.dart';
import '../../domain/usecases/user_address_usecases.dart';
import 'user_address_state.dart';

/// StateNotifier cho quản lý danh sách địa chỉ
class UserAddressListNotifier extends StateNotifier<UserAddressListState> {
  final GetUserAddressesUseCase _getUserAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final SetDefaultAddressUseCase _setDefaultAddressUseCase;

  UserAddressListNotifier({
    required GetUserAddressesUseCase getUserAddressesUseCase,
    required DeleteAddressUseCase deleteAddressUseCase,
    required SetDefaultAddressUseCase setDefaultAddressUseCase,
  })  : _getUserAddressesUseCase = getUserAddressesUseCase,
        _deleteAddressUseCase = deleteAddressUseCase,
        _setDefaultAddressUseCase = setDefaultAddressUseCase,
        super(const UserAddressListState());

  /// Load danh sách địa chỉ của user
  Future<void> loadAddresses(int userId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _getUserAddressesUseCase(userId);

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
  Future<bool> deleteAddress(int addressId) async {
    final result = await _deleteAddressUseCase(addressId);

    return result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
        return false;
      },
      (success) {
        if (success) {
          // Remove từ state
          final updatedAddresses = state.addresses
              .where((address) => address.id != addressId)
              .toList();
          state = state.copyWith(addresses: updatedAddresses);
        }
        return success;
      },
    );
  }

  /// Đặt địa chỉ mặc định
  Future<bool> setDefaultAddress(int addressId) async {
    final result = await _setDefaultAddressUseCase(addressId);

    return result.fold(
      (failure) {
        state = state.copyWith(errorMessage: failure.message);
        return false;
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

        state = state.copyWith(addresses: updatedAddresses);
        return true;
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

  /// Select address
  void selectAddress(UserAddressEntity? address) {
    state = state.copyWith(selectedAddress: address);
  }
}

/// StateNotifier cho tạo/cập nhật địa chỉ
class AddressFormNotifier extends StateNotifier<AsyncValue<UserAddressEntity?>> {
  final CreateAddressUseCase _createAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final GetAddressByIdUseCase _getAddressByIdUseCase;

  AddressFormNotifier({
    required CreateAddressUseCase createAddressUseCase,
    required UpdateAddressUseCase updateAddressUseCase,
    required GetAddressByIdUseCase getAddressByIdUseCase,
  })  : _createAddressUseCase = createAddressUseCase,
        _updateAddressUseCase = updateAddressUseCase,
        _getAddressByIdUseCase = getAddressByIdUseCase,
        super(const AsyncValue.data(null));

  /// Load địa chỉ để edit
  Future<void> loadAddress(int addressId) async {
    state = const AsyncValue.loading();

    final result = await _getAddressByIdUseCase(addressId);

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

    final result = await _createAddressUseCase(userId, request);

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

    final result = await _updateAddressUseCase(addressId, request);

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
