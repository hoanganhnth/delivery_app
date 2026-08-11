sealed class CatalogRestaurantDetailIntent {
  const CatalogRestaurantDetailIntent();
}

final class CatalogRestaurantDetailLoadRequested
    extends CatalogRestaurantDetailIntent {
  const CatalogRestaurantDetailLoadRequested();
}

final class CatalogRestaurantDetailBackRequested
    extends CatalogRestaurantDetailIntent {
  const CatalogRestaurantDetailBackRequested();
}

final class CatalogRestaurantDetailCartRequested
    extends CatalogRestaurantDetailIntent {
  const CatalogRestaurantDetailCartRequested();
}

final class CatalogRestaurantDetailIncrementRequested
    extends CatalogRestaurantDetailIntent {
  const CatalogRestaurantDetailIncrementRequested(this.menuItemId);

  final num menuItemId;
}

final class CatalogRestaurantDetailDecrementRequested
    extends CatalogRestaurantDetailIntent {
  const CatalogRestaurantDetailDecrementRequested(this.menuItemId);

  final num menuItemId;
}

final class CatalogRestaurantDetailRestaurantChangeConfirmed
    extends CatalogRestaurantDetailIntent {
  const CatalogRestaurantDetailRestaurantChangeConfirmed(this.menuItemId);

  final num menuItemId;
}

final class CatalogRestaurantDetailEffectConsumed
    extends CatalogRestaurantDetailIntent {
  const CatalogRestaurantDetailEffectConsumed(this.effectId);

  final int effectId;
}
