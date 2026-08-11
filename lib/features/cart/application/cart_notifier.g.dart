// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Cart notifier for state management using AsyncNotifier
/// Returns CartEntity directly, AsyncValue handles loading/error states

@ProviderFor(CartNotifier)
final cartProvider = CartNotifierProvider._();

/// Cart notifier for state management using AsyncNotifier
/// Returns CartEntity directly, AsyncValue handles loading/error states
final class CartNotifierProvider
    extends $AsyncNotifierProvider<CartNotifier, CartEntity> {
  /// Cart notifier for state management using AsyncNotifier
  /// Returns CartEntity directly, AsyncValue handles loading/error states
  CartNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartNotifierHash();

  @$internal
  @override
  CartNotifier create() => CartNotifier();
}

String _$cartNotifierHash() => r'e77a91e85bf06fd7c7864a6ce1e3109442a05937';

/// Cart notifier for state management using AsyncNotifier
/// Returns CartEntity directly, AsyncValue handles loading/error states

abstract class _$CartNotifier extends $AsyncNotifier<CartEntity> {
  FutureOr<CartEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CartEntity>, CartEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CartEntity>, CartEntity>,
              AsyncValue<CartEntity>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
