// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationApiService)
final notificationApiServiceProvider = NotificationApiServiceProvider._();

final class NotificationApiServiceProvider
    extends
        $FunctionalProvider<
          NotificationApiService,
          NotificationApiService,
          NotificationApiService
        >
    with $Provider<NotificationApiService> {
  NotificationApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationApiServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationApiService create(Ref ref) {
    return notificationApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationApiService>(value),
    );
  }
}

String _$notificationApiServiceHash() =>
    r'0012e114e22cabe7819ecdad2bef12da2f4b3a67';

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'589c2902dd570b31035ec6e0453860e65489eaea';
