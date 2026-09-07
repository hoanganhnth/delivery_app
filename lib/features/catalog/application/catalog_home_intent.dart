sealed class CatalogHomeIntent {
  const CatalogHomeIntent();
}

/// Lifecycle intent dispatched by the page adapter when the tab first mounts.
final class CatalogHomeLoadRequested extends CatalogHomeIntent {
  const CatalogHomeLoadRequested();
}

final class CatalogHomeSearchRequested extends CatalogHomeIntent {
  const CatalogHomeSearchRequested();
}

final class CatalogHomeAllRestaurantsRequested extends CatalogHomeIntent {
  const CatalogHomeAllRestaurantsRequested();
}

final class CatalogHomeVouchersRequested extends CatalogHomeIntent {
  const CatalogHomeVouchersRequested();
}

final class CatalogHomeLivestreamRequested extends CatalogHomeIntent {
  const CatalogHomeLivestreamRequested();
}

final class CatalogHomeAddressRequested extends CatalogHomeIntent {
  const CatalogHomeAddressRequested();
}

final class CatalogHomeNotificationsRequested extends CatalogHomeIntent {
  const CatalogHomeNotificationsRequested();
}

final class CatalogHomeCartRequested extends CatalogHomeIntent {
  const CatalogHomeCartRequested();
}

final class CatalogHomeRestaurantRequested extends CatalogHomeIntent {
  const CatalogHomeRestaurantRequested(this.restaurantId);

  final num restaurantId;
}

final class CatalogHomeEffectConsumed extends CatalogHomeIntent {
  const CatalogHomeEffectConsumed(this.effectId);

  final int effectId;
}
