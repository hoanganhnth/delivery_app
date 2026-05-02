// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_calculation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CheckoutCalculationNotifier)
final checkoutCalculationProvider = CheckoutCalculationNotifierProvider._();

final class CheckoutCalculationNotifierProvider
    extends
        $AsyncNotifierProvider<
          CheckoutCalculationNotifier,
          CalculateResponseDto?
        > {
  CheckoutCalculationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkoutCalculationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkoutCalculationNotifierHash();

  @$internal
  @override
  CheckoutCalculationNotifier create() => CheckoutCalculationNotifier();
}

String _$checkoutCalculationNotifierHash() =>
    r'e03d4f4851b77168906033af2b7f07850b6b37eb';

abstract class _$CheckoutCalculationNotifier
    extends $AsyncNotifier<CalculateResponseDto?> {
  FutureOr<CalculateResponseDto?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<CalculateResponseDto?>, CalculateResponseDto?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CalculateResponseDto?>,
                CalculateResponseDto?
              >,
              AsyncValue<CalculateResponseDto?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
