// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_list_notifier.dart';

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
