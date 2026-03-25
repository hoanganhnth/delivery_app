// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guard_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for GuardManager

@ProviderFor(guardManager)
final guardManagerProvider = GuardManagerProvider._();

/// Provider for GuardManager

final class GuardManagerProvider
    extends $FunctionalProvider<GuardManager, GuardManager, GuardManager>
    with $Provider<GuardManager> {
  /// Provider for GuardManager
  GuardManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guardManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guardManagerHash();

  @$internal
  @override
  $ProviderElement<GuardManager> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GuardManager create(Ref ref) {
    return guardManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuardManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuardManager>(value),
    );
  }
}

String _$guardManagerHash() => r'2cef862770a51f6eca73720e5f3b9b523c63941b';
