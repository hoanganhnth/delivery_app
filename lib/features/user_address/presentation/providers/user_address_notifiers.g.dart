// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier cho quản lý danh sách địa chỉ

@ProviderFor(UserAddressListNotifier)
final userAddressListProvider = UserAddressListNotifierProvider._();

/// Notifier cho quản lý danh sách địa chỉ
final class UserAddressListNotifierProvider
    extends $NotifierProvider<UserAddressListNotifier, UserAddressListState> {
  /// Notifier cho quản lý danh sách địa chỉ
  UserAddressListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAddressListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAddressListNotifierHash();

  @$internal
  @override
  UserAddressListNotifier create() => UserAddressListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAddressListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAddressListState>(value),
    );
  }
}

String _$userAddressListNotifierHash() =>
    r'b112b7d60fba5c6937e366e0bf35bf987ca0965f';

/// Notifier cho quản lý danh sách địa chỉ

abstract class _$UserAddressListNotifier
    extends $Notifier<UserAddressListState> {
  UserAddressListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserAddressListState, UserAddressListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserAddressListState, UserAddressListState>,
              UserAddressListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier cho tạo/cập nhật địa chỉ

@ProviderFor(AddressFormNotifier)
final addressFormProvider = AddressFormNotifierProvider._();

/// Notifier cho tạo/cập nhật địa chỉ
final class AddressFormNotifierProvider
    extends
        $NotifierProvider<AddressFormNotifier, AsyncValue<UserAddressEntity?>> {
  /// Notifier cho tạo/cập nhật địa chỉ
  AddressFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addressFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addressFormNotifierHash();

  @$internal
  @override
  AddressFormNotifier create() => AddressFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<UserAddressEntity?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<UserAddressEntity?>>(
        value,
      ),
    );
  }
}

String _$addressFormNotifierHash() =>
    r'e091cf4a82733ce1d646bfeca6c88619fbaab61f';

/// Notifier cho tạo/cập nhật địa chỉ

abstract class _$AddressFormNotifier
    extends $Notifier<AsyncValue<UserAddressEntity?>> {
  AsyncValue<UserAddressEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<UserAddressEntity?>,
              AsyncValue<UserAddressEntity?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<UserAddressEntity?>,
                AsyncValue<UserAddressEntity?>
              >,
              AsyncValue<UserAddressEntity?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
