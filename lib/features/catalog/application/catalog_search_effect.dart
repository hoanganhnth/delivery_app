import 'package:equatable/equatable.dart';

sealed class CatalogSearchEffect extends Equatable {
  const CatalogSearchEffect();
}

final class CatalogSearchNavigateToRestaurant extends CatalogSearchEffect {
  const CatalogSearchNavigateToRestaurant(this.restaurantId);

  final String restaurantId;

  @override
  List<Object?> get props => [restaurantId];
}
