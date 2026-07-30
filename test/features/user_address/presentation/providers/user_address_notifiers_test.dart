import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/user_address/data/dtos/user_address_request_dto.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:delivery_app/features/user_address/domain/repositories/user_address_repository.dart';
import 'package:delivery_app/features/user_address/presentation/providers/di/user_address_di_providers.dart';
import 'package:delivery_app/features/user_address/presentation/providers/list/user_address_list_notifier.dart';
import 'package:delivery_app/features/user_address/presentation/providers/operation/address_form_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  group('address list journey', () {
    test('loads, auto-selects default, changes default and deletes', () async {
      final repository = _FakeAddressRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(userAddressListProvider, (_, _) {});
      final notifier = container.read(userAddressListProvider.notifier);

      final home = buildAddress();
      final office = buildAddress(id: 402, label: 'Công ty', isDefault: false);
      repository.addressesResult = Right([home, office]);
      final load = notifier.loadAddresses(501);
      expect(container.read(userAddressListProvider).isLoading, isTrue);
      await load;
      notifier.autoSelectDefaultAddress();
      expect(container.read(userAddressListProvider).selectedAddress?.id, 401);

      repository.defaultResult = Right(office.copyWith(isDefault: true));
      await notifier.setDefaultAddress(402);
      var state = container.read(userAddressListProvider);
      expect(state.defaultAddress?.id, 402);
      expect(state.addresses.firstWhere((address) => address.id == 401).isDefault, isFalse);
      expect(state.lastOperation?.isSuccess, isTrue);

      repository.deleteResult = const Right(true);
      await notifier.deleteAddress(401);
      state = container.read(userAddressListProvider);
      expect(state.addresses.map((address) => address.id), [402]);
      expect(state.lastOperation?.type, 'delete');
    });

    test('retains addresses after delete/default failures and retries', () async {
      final repository = _FakeAddressRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(userAddressListProvider, (_, _) {});
      final notifier = container.read(userAddressListProvider.notifier);
      final home = buildAddress();
      final office = buildAddress(id: 402, label: 'Công ty', isDefault: false);
      repository.addressesResult = Right([home, office]);
      await notifier.loadAddresses(501);

      repository.deleteResult = const Left(ServerFailure('Không thể xóa'));
      await notifier.deleteAddress(401);
      expect(container.read(userAddressListProvider).addresses, hasLength(2));
      expect(container.read(userAddressListProvider).lastOperation?.isSuccess, isFalse);

      repository.deleteResult = const Right(true);
      await notifier.deleteAddress(401);
      expect(container.read(userAddressListProvider).addresses, hasLength(1));

      repository.defaultResult = const Left(ServerFailure('Không thể đặt mặc định'));
      await notifier.setDefaultAddress(402);
      expect(container.read(userAddressListProvider).lastOperation?.isSuccess, isFalse);
      expect(container.read(userAddressListProvider).defaultAddress, isNull);

      repository.defaultResult = Right(office.copyWith(isDefault: true));
      await notifier.setDefaultAddress(402);
      expect(container.read(userAddressListProvider).defaultAddress?.id, 402);
    });
  });

  group('address form journey', () {
    test('loads, creates and updates through the injected repository', () async {
      final repository = _FakeAddressRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(addressFormProvider, (_, _) {});
      final notifier = container.read(addressFormProvider.notifier);
      final address = buildAddress();
      repository.addressResult = Right(address);

      await notifier.loadAddress(401);
      expect(container.read(addressFormProvider).value?.id, 401);

      final created = await notifier.createAddress(501, _request);
      expect(created?.id, 401);
      expect(repository.lastCreateUserId, 501);
      expect(repository.lastRequest, _request);

      final updated = await notifier.updateAddress(401, _request);
      expect(updated?.id, 401);
      expect(repository.lastUpdateId, 401);
      notifier.reset();
      expect(container.read(addressFormProvider).value, isNull);
    });

    test('exposes create failure and allows retry', () async {
      final repository = _FakeAddressRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(addressFormProvider, (_, _) {});
      final notifier = container.read(addressFormProvider.notifier);
      repository.addressResult = const Left(ServerFailure('Tọa độ không hợp lệ'));

      final first = await notifier.createAddress(501, _request);
      expect(first, isNull);
      expect(container.read(addressFormProvider).hasError, isTrue);
      expect(
        container.read(addressFormProvider).error.toString(),
        contains('Tọa độ không hợp lệ'),
      );

      repository.addressResult = Right(buildAddress());
      final retry = await notifier.createAddress(501, _request);
      expect(retry?.id, 401);
      expect(container.read(addressFormProvider).hasValue, isTrue);
      expect(repository.createCalls, 2);
    });
  });
}

const _request = UserAddressRequestDto(
  label: 'Nhà',
  recipientName: 'Customer Test',
  phoneNumber: '0900000002',
  addressLine: '2 Đường Khách',
  ward: 'Phường Test',
  district: 'Quận 1',
  city: 'TP.HCM',
  latitude: 10.78,
  longitude: 106.71,
  isDefault: true,
);

ProviderContainer _container(_FakeAddressRepository repository) {
  return ProviderContainer(
    overrides: [userAddressRepositoryProvider.overrideWithValue(repository)],
  );
}

class _FakeAddressRepository implements UserAddressRepository {
  Either<Failure, List<UserAddressEntity>> addressesResult = Right([
    buildAddress(),
  ]);
  Either<Failure, UserAddressEntity> addressResult = Right(buildAddress());
  Either<Failure, bool> deleteResult = const Right(true);
  Either<Failure, UserAddressEntity> defaultResult = Right(buildAddress());

  int createCalls = 0;
  int? lastCreateUserId;
  int? lastUpdateId;
  UserAddressRequestDto? lastRequest;

  @override
  Future<Either<Failure, List<UserAddressEntity>>> getUserAddresses(
    int userId,
  ) async => addressesResult;

  @override
  Future<Either<Failure, UserAddressEntity>> getAddressById(
    int addressId,
  ) async => addressResult;

  @override
  Future<Either<Failure, UserAddressEntity>> createAddress(
    int userId,
    UserAddressRequestDto request,
  ) async {
    createCalls += 1;
    lastCreateUserId = userId;
    lastRequest = request;
    return addressResult;
  }

  @override
  Future<Either<Failure, UserAddressEntity>> updateAddress(
    int addressId,
    UserAddressRequestDto request,
  ) async {
    lastUpdateId = addressId;
    lastRequest = request;
    return addressResult;
  }

  @override
  Future<Either<Failure, bool>> deleteAddress(int addressId) async =>
      deleteResult;

  @override
  Future<Either<Failure, UserAddressEntity>> setDefaultAddress(
    int addressId,
  ) async => defaultResult;
}
