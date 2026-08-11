sealed class CatalogAllRestaurantsIntent {
  const CatalogAllRestaurantsIntent();
}

final class CatalogAllRestaurantsLoadRequested
    extends CatalogAllRestaurantsIntent {
  const CatalogAllRestaurantsLoadRequested();
}

final class CatalogAllRestaurantsRefreshRequested
    extends CatalogAllRestaurantsIntent {
  const CatalogAllRestaurantsRefreshRequested();
}

final class CatalogAllRestaurantsRetryRequested
    extends CatalogAllRestaurantsIntent {
  const CatalogAllRestaurantsRetryRequested();
}

final class CatalogAllRestaurantsBackRequested
    extends CatalogAllRestaurantsIntent {
  const CatalogAllRestaurantsBackRequested();
}

final class CatalogAllRestaurantsSearchRequested
    extends CatalogAllRestaurantsIntent {
  const CatalogAllRestaurantsSearchRequested();
}

final class CatalogAllRestaurantsRestaurantRequested
    extends CatalogAllRestaurantsIntent {
  const CatalogAllRestaurantsRestaurantRequested(this.restaurantId);

  final num restaurantId;
}

final class CatalogAllRestaurantsEffectConsumed
    extends CatalogAllRestaurantsIntent {
  const CatalogAllRestaurantsEffectConsumed(this.effectId);

  final int effectId;
}
