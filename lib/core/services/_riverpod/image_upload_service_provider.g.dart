// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_upload_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageUploadService)
final imageUploadServiceProvider = ImageUploadServiceProvider._();

final class ImageUploadServiceProvider
    extends
        $FunctionalProvider<
          IImageUploadService,
          IImageUploadService,
          IImageUploadService
        >
    with $Provider<IImageUploadService> {
  ImageUploadServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageUploadServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageUploadServiceHash();

  @$internal
  @override
  $ProviderElement<IImageUploadService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IImageUploadService create(Ref ref) {
    return imageUploadService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IImageUploadService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IImageUploadService>(value),
    );
  }
}

String _$imageUploadServiceHash() =>
    r'fee3fa0fd2e320939ebba5ee21decd0d9e4102b9';
