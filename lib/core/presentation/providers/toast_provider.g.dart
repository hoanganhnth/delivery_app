// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toast_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Toast notifier

@ProviderFor(Toast)
final toastProvider = ToastProvider._();

/// Toast notifier
final class ToastProvider extends $NotifierProvider<Toast, ToastMessage?> {
  /// Toast notifier
  ToastProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toastProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toastHash();

  @$internal
  @override
  Toast create() => Toast();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToastMessage? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToastMessage?>(value),
    );
  }
}

String _$toastHash() => r'255c3ccde575d5008c49c4a0cc75361869c8dedc';

/// Toast notifier

abstract class _$Toast extends $Notifier<ToastMessage?> {
  ToastMessage? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ToastMessage?, ToastMessage?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ToastMessage?, ToastMessage?>,
              ToastMessage?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
