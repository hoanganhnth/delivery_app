sealed class CatalogSearchIntent {
  const CatalogSearchIntent();
}

final class CatalogSearchQueryChanged extends CatalogSearchIntent {
  const CatalogSearchQueryChanged(this.value);

  final String value;
}

final class CatalogSearchCleared extends CatalogSearchIntent {
  const CatalogSearchCleared();
}

enum CatalogSearchTab { dishes, restaurants }

final class CatalogSearchTabSelected extends CatalogSearchIntent {
  const CatalogSearchTabSelected(this.tab);

  final CatalogSearchTab tab;
}

final class CatalogSearchDishSelected extends CatalogSearchIntent {
  const CatalogSearchDishSelected(this.restaurantId);

  final String restaurantId;
}

final class CatalogSearchRestaurantSelected extends CatalogSearchIntent {
  const CatalogSearchRestaurantSelected(this.restaurantId);

  final String restaurantId;
}

final class CatalogSearchEffectConsumed extends CatalogSearchIntent {
  const CatalogSearchEffectConsumed(this.effectId);

  final int effectId;
}
