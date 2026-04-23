// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider để quản lý trạng thái tab hiện tại

@ProviderFor(SelectedTab)
final selectedTabProvider = SelectedTabProvider._();

/// Provider để quản lý trạng thái tab hiện tại
final class SelectedTabProvider extends $NotifierProvider<SelectedTab, AppTab> {
  /// Provider để quản lý trạng thái tab hiện tại
  SelectedTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTabProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTabHash();

  @$internal
  @override
  SelectedTab create() => SelectedTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppTab value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppTab>(value),
    );
  }
}

String _$selectedTabHash() => r'e44c1033e42413252591df7cccc5590f90e2e6f3';

/// Provider để quản lý trạng thái tab hiện tại

abstract class _$SelectedTab extends $Notifier<AppTab> {
  AppTab build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppTab, AppTab>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppTab, AppTab>,
              AppTab,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider để quản lý việc chuyển tab

@ProviderFor(navigationController)
final navigationControllerProvider = NavigationControllerProvider._();

/// Provider để quản lý việc chuyển tab

final class NavigationControllerProvider
    extends
        $FunctionalProvider<
          NavigationController,
          NavigationController,
          NavigationController
        >
    with $Provider<NavigationController> {
  /// Provider để quản lý việc chuyển tab
  NavigationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationControllerHash();

  @$internal
  @override
  $ProviderElement<NavigationController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NavigationController create(Ref ref) {
    return navigationController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavigationController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavigationController>(value),
    );
  }
}

String _$navigationControllerHash() =>
    r'40947c410b84ebf51727d61f6a34618e1a5b301b';
