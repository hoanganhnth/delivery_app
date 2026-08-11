import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/user_address/domain/entities/address_upsert_command.dart';
import 'package:delivery_app/features/user_address/application/address_list_intent.dart';
import 'package:delivery_app/features/user_address/application/address_list_view_model.dart';
import 'package:delivery_app/features/user_address/application/address_form_effect.dart';
import 'package:delivery_app/features/user_address/application/address_form_intent.dart';
import 'package:delivery_app/features/user_address/application/address_form_state.dart';
import 'package:delivery_app/features/user_address/application/address_form_view_model.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:delivery_app/features/user_address/domain/repositories/user_address_repository.dart';
import 'package:delivery_app/features/user_address/di/user_address_di_providers.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';
import 'package:delivery_app/features/user_address/application/address_form_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../support/fulfilment_builders.dart';

void main() {
  test(
    'address list ViewModel centralizes default selection and commands',
    () async {
      final repository = _FakeAddressRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.read(addressListViewModelProvider);
      final notifier = container.read(addressListViewModelProvider.notifier);
      repository.addressesResult = Right([
        buildAddress(),
        buildAddress(id: 402, label: 'Công ty', isDefault: false),
      ]);

      // The profile seam is intentionally absent in this provider-level test;
      // list state remains unchanged until the page's identity adapter dispatches load.
      await notifier.dispatch(const AddressListSelectRequested(401));
      expect(
        container.read(addressListViewModelProvider).selectedAddress,
        isNull,
      );

      await container.read(userAddressListProvider.notifier).loadAddresses(501);
      await notifier.dispatch(const AddressListSelectRequested(401));
      expect(
        container.read(addressListViewModelProvider).selectedAddress?.id,
        401,
      );
      repository.defaultResult = Right(buildAddress(id: 402, isDefault: true));
      await notifier.dispatch(const AddressListSetDefaultRequested(402));
      expect(
        container.read(addressListViewModelProvider).defaultAddress?.id,
        402,
      );
    },
  );

  test(
    'address form ViewModel validates, updates and confirms delete with effects',
    () async {
      final repository = _FakeAddressRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      final provider = addressFormViewModelProvider(
        AddressFormTarget(initialAddress: buildAddress()),
      );
      final notifier = container.read(provider.notifier);

      await notifier.dispatch(
        const AddressFormFieldChanged(AddressFormField.label, ''),
      );
      await notifier.dispatch(const AddressFormSubmitRequested());
      expect(
        container.read(provider).errorFor(AddressFormField.label),
        AddressFormValidationIssue.required,
      );
      expect(repository.lastUpdateId, isNull);

      await notifier.dispatch(
        const AddressFormFieldChanged(AddressFormField.label, 'Nhà mới'),
      );
      await notifier.dispatch(const AddressFormSubmitRequested());
      expect(repository.lastUpdateId, 401);
      expect(
        container.read(provider).effects.first.effect,
        isA<AddressFormShowOperationFeedback>(),
      );

      await notifier.dispatch(const AddressFormDeleteRequested());
      expect(
        container.read(provider).effects.last.effect,
        isA<AddressFormConfirmDelete>(),
      );
      repository.deleteResult = const Right(true);
      await notifier.dispatch(const AddressFormDeleteConfirmed());
      expect(
        container.read(provider).effects.last.effect,
        isA<AddressFormNavigateBack>(),
      );
    },
  );

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
      expect(
        state.addresses.firstWhere((address) => address.id == 401).isDefault,
        isFalse,
      );
      expect(state.lastOperation?.isSuccess, isTrue);

      repository.deleteResult = const Right(true);
      await notifier.deleteAddress(401);
      state = container.read(userAddressListProvider);
      expect(state.addresses.map((address) => address.id), [402]);
      expect(state.lastOperation?.type, 'delete');
    });

    test(
      'retains addresses after delete/default failures and retries',
      () async {
        final repository = _FakeAddressRepository();
        final container = _container(repository);
        addTearDown(container.dispose);
        container.listen(userAddressListProvider, (_, _) {});
        final notifier = container.read(userAddressListProvider.notifier);
        final home = buildAddress();
        final office = buildAddress(
          id: 402,
          label: 'Công ty',
          isDefault: false,
        );
        repository.addressesResult = Right([home, office]);
        await notifier.loadAddresses(501);

        repository.deleteResult = const Left(ServerFailure('Không thể xóa'));
        await notifier.deleteAddress(401);
        expect(container.read(userAddressListProvider).addresses, hasLength(2));
        expect(
          container.read(userAddressListProvider).lastOperation?.isSuccess,
          isFalse,
        );

        repository.deleteResult = const Right(true);
        await notifier.deleteAddress(401);
        expect(container.read(userAddressListProvider).addresses, hasLength(1));

        repository.defaultResult = const Left(
          ServerFailure('Không thể đặt mặc định'),
        );
        await notifier.setDefaultAddress(402);
        expect(
          container.read(userAddressListProvider).lastOperation?.isSuccess,
          isFalse,
        );
        expect(container.read(userAddressListProvider).defaultAddress, isNull);

        repository.defaultResult = Right(office.copyWith(isDefault: true));
        await notifier.setDefaultAddress(402);
        expect(container.read(userAddressListProvider).defaultAddress?.id, 402);
      },
    );
  });

  group('address form journey', () {
    test(
      'loads, creates and updates through the injected repository',
      () async {
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
      },
    );

    test('exposes create failure and allows retry', () async {
      final repository = _FakeAddressRepository();
      final container = _container(repository);
      addTearDown(container.dispose);
      container.listen(addressFormProvider, (_, _) {});
      final notifier = container.read(addressFormProvider.notifier);
      repository.addressResult = const Left(
        ServerFailure('Tọa độ không hợp lệ'),
      );

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

const _request = AddressUpsertCommand(
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
  AddressUpsertCommand? lastRequest;

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
    AddressUpsertCommand request,
  ) async {
    createCalls += 1;
    lastCreateUserId = userId;
    lastRequest = request;
    return addressResult;
  }

  @override
  Future<Either<Failure, UserAddressEntity>> updateAddress(
    int addressId,
    AddressUpsertCommand request,
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
