sealed class CatalogSearchIntent {
  const CatalogSearchIntent();
}

final class CatalogSearchLoadRequested extends CatalogSearchIntent {
  const CatalogSearchLoadRequested();
}

final class CatalogSearchQueryChanged extends CatalogSearchIntent {
  const CatalogSearchQueryChanged(this.value);

  final String value;
}

final class CatalogSearchCleared extends CatalogSearchIntent {
  const CatalogSearchCleared();
}

enum CatalogSearchTab { dishes, restaurants }

enum CatalogSearchSort { recommended, nearby, rating }

final class CatalogSearchTabSelected extends CatalogSearchIntent {
  const CatalogSearchTabSelected(this.tab);

  final CatalogSearchTab tab;
}

final class CatalogSearchSortSelected extends CatalogSearchIntent {
  const CatalogSearchSortSelected(this.sort);

  final CatalogSearchSort sort;
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
