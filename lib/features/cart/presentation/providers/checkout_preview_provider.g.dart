// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_preview_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider cho OrderApiService (checkout-specific)

@ProviderFor(checkoutOrderApiService)
final checkoutOrderApiServiceProvider = CheckoutOrderApiServiceProvider._();

/// Provider cho OrderApiService (checkout-specific)

final class CheckoutOrderApiServiceProvider
    extends
        $FunctionalProvider<OrderApiService, OrderApiService, OrderApiService>
    with $Provider<OrderApiService> {
  /// Provider cho OrderApiService (checkout-specific)
  CheckoutOrderApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkoutOrderApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkoutOrderApiServiceHash();

  @$internal
  @override
  $ProviderElement<OrderApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderApiService create(Ref ref) {
    return checkoutOrderApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderApiService>(value),
    );
  }
}

String _$checkoutOrderApiServiceHash() =>
    r'79f90c4babe279357671bd042c8ac369800e8fbb';

/// ✅ Checkout Preview Provider
/// Gọi server để tính giá chính xác trước khi đặt hàng.

@ProviderFor(CheckoutPreviewNotifier)
final checkoutPreviewProvider = CheckoutPreviewNotifierProvider._();

/// ✅ Checkout Preview Provider
/// Gọi server để tính giá chính xác trước khi đặt hàng.
final class CheckoutPreviewNotifierProvider
    extends
        $AsyncNotifierProvider<
          CheckoutPreviewNotifier,
          CheckoutPreviewResponse?
        > {
  /// ✅ Checkout Preview Provider
  /// Gọi server để tính giá chính xác trước khi đặt hàng.
  CheckoutPreviewNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkoutPreviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkoutPreviewNotifierHash();

  @$internal
  @override
  CheckoutPreviewNotifier create() => CheckoutPreviewNotifier();
}

String _$checkoutPreviewNotifierHash() =>
    r'50c98de0639a33edaa47947d95588d3bcccf7d7f';

/// ✅ Checkout Preview Provider
/// Gọi server để tính giá chính xác trước khi đặt hàng.

abstract class _$CheckoutPreviewNotifier
    extends $AsyncNotifier<CheckoutPreviewResponse?> {
  FutureOr<CheckoutPreviewResponse?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CheckoutPreviewResponse?>,
              CheckoutPreviewResponse?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CheckoutPreviewResponse?>,
                CheckoutPreviewResponse?
              >,
              AsyncValue<CheckoutPreviewResponse?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
