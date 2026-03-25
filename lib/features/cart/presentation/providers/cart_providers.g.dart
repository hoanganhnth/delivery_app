// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Data source provider

@ProviderFor(cartLocalDataSource)
final cartLocalDataSourceProvider = CartLocalDataSourceProvider._();

/// Data source provider

final class CartLocalDataSourceProvider
    extends
        $FunctionalProvider<
          CartLocalDataSource,
          CartLocalDataSource,
          CartLocalDataSource
        >
    with $Provider<CartLocalDataSource> {
  /// Data source provider
  CartLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<CartLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CartLocalDataSource create(Ref ref) {
    return cartLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartLocalDataSource>(value),
    );
  }
}

String _$cartLocalDataSourceHash() =>
    r'1d58803c8dca1f8cba7770dc8c7b7a68dc7494aa';

/// Repository provider

@ProviderFor(cartRepository)
final cartRepositoryProvider = CartRepositoryProvider._();

/// Repository provider

final class CartRepositoryProvider
    extends
        $FunctionalProvider<
          CartRepositoryImpl,
          CartRepositoryImpl,
          CartRepositoryImpl
        >
    with $Provider<CartRepositoryImpl> {
  /// Repository provider
  CartRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartRepositoryHash();

  @$internal
  @override
  $ProviderElement<CartRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CartRepositoryImpl create(Ref ref) {
    return cartRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartRepositoryImpl>(value),
    );
  }
}

String _$cartRepositoryHash() => r'f3f7036f8cd94a024afa84d1776407f944f24000';

/// Get cart use case provider

@ProviderFor(getCartUseCase)
final getCartUseCaseProvider = GetCartUseCaseProvider._();

/// Get cart use case provider

final class GetCartUseCaseProvider
    extends $FunctionalProvider<GetCartUseCase, GetCartUseCase, GetCartUseCase>
    with $Provider<GetCartUseCase> {
  /// Get cart use case provider
  GetCartUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCartUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCartUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCartUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetCartUseCase create(Ref ref) {
    return getCartUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCartUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCartUseCase>(value),
    );
  }
}

String _$getCartUseCaseHash() => r'89e5dc5208faea7e2d4c0ae933b2eba22a085b9f';

/// Add to cart use case provider

@ProviderFor(addToCartUseCase)
final addToCartUseCaseProvider = AddToCartUseCaseProvider._();

/// Add to cart use case provider

final class AddToCartUseCaseProvider
    extends
        $FunctionalProvider<
          AddToCartUseCase,
          AddToCartUseCase,
          AddToCartUseCase
        >
    with $Provider<AddToCartUseCase> {
  /// Add to cart use case provider
  AddToCartUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addToCartUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addToCartUseCaseHash();

  @$internal
  @override
  $ProviderElement<AddToCartUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddToCartUseCase create(Ref ref) {
    return addToCartUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddToCartUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddToCartUseCase>(value),
    );
  }
}

String _$addToCartUseCaseHash() => r'c3827af3d6686a3fcd177dc3bc3b7cbaf9aec7ba';

/// Update cart item quantity use case provider

@ProviderFor(updateCartItemQuantityUseCase)
final updateCartItemQuantityUseCaseProvider =
    UpdateCartItemQuantityUseCaseProvider._();

/// Update cart item quantity use case provider

final class UpdateCartItemQuantityUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateCartItemQuantityUseCase,
          UpdateCartItemQuantityUseCase,
          UpdateCartItemQuantityUseCase
        >
    with $Provider<UpdateCartItemQuantityUseCase> {
  /// Update cart item quantity use case provider
  UpdateCartItemQuantityUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateCartItemQuantityUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateCartItemQuantityUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateCartItemQuantityUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateCartItemQuantityUseCase create(Ref ref) {
    return updateCartItemQuantityUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateCartItemQuantityUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateCartItemQuantityUseCase>(
        value,
      ),
    );
  }
}

String _$updateCartItemQuantityUseCaseHash() =>
    r'1f62b5285bb2aea1fb107b509ff86eae94b26069';

/// Remove from cart use case provider

@ProviderFor(removeFromCartUseCase)
final removeFromCartUseCaseProvider = RemoveFromCartUseCaseProvider._();

/// Remove from cart use case provider

final class RemoveFromCartUseCaseProvider
    extends
        $FunctionalProvider<
          RemoveFromCartUseCase,
          RemoveFromCartUseCase,
          RemoveFromCartUseCase
        >
    with $Provider<RemoveFromCartUseCase> {
  /// Remove from cart use case provider
  RemoveFromCartUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'removeFromCartUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$removeFromCartUseCaseHash();

  @$internal
  @override
  $ProviderElement<RemoveFromCartUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoveFromCartUseCase create(Ref ref) {
    return removeFromCartUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoveFromCartUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoveFromCartUseCase>(value),
    );
  }
}

String _$removeFromCartUseCaseHash() =>
    r'b02a0a9288413bc43c3413547a8c17c08c93122d';

/// Clear cart use case provider

@ProviderFor(clearCartUseCase)
final clearCartUseCaseProvider = ClearCartUseCaseProvider._();

/// Clear cart use case provider

final class ClearCartUseCaseProvider
    extends
        $FunctionalProvider<
          ClearCartUseCase,
          ClearCartUseCase,
          ClearCartUseCase
        >
    with $Provider<ClearCartUseCase> {
  /// Clear cart use case provider
  ClearCartUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clearCartUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clearCartUseCaseHash();

  @$internal
  @override
  $ProviderElement<ClearCartUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClearCartUseCase create(Ref ref) {
    return clearCartUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClearCartUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClearCartUseCase>(value),
    );
  }
}

String _$clearCartUseCaseHash() => r'a306aa590f6c594b07b46e51ec57ce55254a22db';

/// Update cart item notes use case provider

@ProviderFor(updateCartItemNotesUseCase)
final updateCartItemNotesUseCaseProvider =
    UpdateCartItemNotesUseCaseProvider._();

/// Update cart item notes use case provider

final class UpdateCartItemNotesUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateCartItemNotesUseCase,
          UpdateCartItemNotesUseCase,
          UpdateCartItemNotesUseCase
        >
    with $Provider<UpdateCartItemNotesUseCase> {
  /// Update cart item notes use case provider
  UpdateCartItemNotesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateCartItemNotesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateCartItemNotesUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateCartItemNotesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateCartItemNotesUseCase create(Ref ref) {
    return updateCartItemNotesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateCartItemNotesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateCartItemNotesUseCase>(value),
    );
  }
}

String _$updateCartItemNotesUseCaseHash() =>
    r'be3926a3a7d34dd2fb3108fce0b5a823d6a96938';
