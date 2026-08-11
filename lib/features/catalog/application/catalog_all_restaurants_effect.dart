import 'package:equatable/equatable.dart';

sealed class CatalogAllRestaurantsEffect extends Equatable {
  const CatalogAllRestaurantsEffect();
}

final class CatalogAllRestaurantsNavigateBack
    extends CatalogAllRestaurantsEffect {
  const CatalogAllRestaurantsNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class CatalogAllRestaurantsNavigateToSearch
    extends CatalogAllRestaurantsEffect {
  const CatalogAllRestaurantsNavigateToSearch();

  @override
  List<Object?> get props => const [];
}

final class CatalogAllRestaurantsNavigateToDetail
    extends CatalogAllRestaurantsEffect {
  const CatalogAllRestaurantsNavigateToDetail(this.restaurantId);

  final num restaurantId;

  @override
  List<Object?> get props => [restaurantId];
}
