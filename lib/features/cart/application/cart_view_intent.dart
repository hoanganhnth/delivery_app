sealed class CartViewIntent {
  const CartViewIntent();
}

final class CartPriceSyncRequested extends CartViewIntent {
  const CartPriceSyncRequested();
}

final class CartRetryRequested extends CartViewIntent {
  const CartRetryRequested();
}

final class CartBackRequested extends CartViewIntent {
  const CartBackRequested();
}

final class CartBrowseRestaurantsRequested extends CartViewIntent {
  const CartBrowseRestaurantsRequested();
}

final class CartCheckoutRequested extends CartViewIntent {
  const CartCheckoutRequested();
}

final class CartClearRequested extends CartViewIntent {
  const CartClearRequested();
}

final class CartClearConfirmed extends CartViewIntent {
  const CartClearConfirmed();
}

final class CartIncrementRequested extends CartViewIntent {
  const CartIncrementRequested(this.menuItemId);
  final num menuItemId;
}

final class CartDecrementRequested extends CartViewIntent {
  const CartDecrementRequested(this.menuItemId);
  final num menuItemId;
}

final class CartEffectConsumed extends CartViewIntent {
  const CartEffectConsumed(this.effectId);
  final int effectId;
}
