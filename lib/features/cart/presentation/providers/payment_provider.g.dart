// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(paymentApiService)
final paymentApiServiceProvider = PaymentApiServiceProvider._();

final class PaymentApiServiceProvider
    extends
        $FunctionalProvider<
          PaymentApiService,
          PaymentApiService,
          PaymentApiService
        >
    with $Provider<PaymentApiService> {
  PaymentApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentApiServiceHash();

  @$internal
  @override
  $ProviderElement<PaymentApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PaymentApiService create(Ref ref) {
    return paymentApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentApiService>(value),
    );
  }
}

String _$paymentApiServiceHash() => r'ee28e53c86846b86da8465d0c08040707794007f';

@ProviderFor(PaymentNotifier)
final paymentProvider = PaymentNotifierProvider._();

final class PaymentNotifierProvider
    extends $AsyncNotifierProvider<PaymentNotifier, PaymentOrderDto?> {
  PaymentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentNotifierHash();

  @$internal
  @override
  PaymentNotifier create() => PaymentNotifier();
}

String _$paymentNotifierHash() => r'd00c06ede3f17f05f17a95f69dc66fc9f85f0ff7';

abstract class _$PaymentNotifier extends $AsyncNotifier<PaymentOrderDto?> {
  FutureOr<PaymentOrderDto?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PaymentOrderDto?>, PaymentOrderDto?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PaymentOrderDto?>, PaymentOrderDto?>,
              AsyncValue<PaymentOrderDto?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
