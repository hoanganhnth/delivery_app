import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/user_address_entity.dart';
import '../../../data/dtos/user_address_request_dto.dart';
import '../di/user_address_di_providers.dart';

part 'address_form_notifier.g.dart';

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
