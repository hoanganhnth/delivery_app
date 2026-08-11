import 'package:equatable/equatable.dart';

sealed class CatalogRestaurantDetailEffect extends Equatable {
  const CatalogRestaurantDetailEffect();
}

final class CatalogRestaurantDetailNavigateBack
    extends CatalogRestaurantDetailEffect {
  const CatalogRestaurantDetailNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class CatalogRestaurantDetailNavigateToCart
    extends CatalogRestaurantDetailEffect {
  const CatalogRestaurantDetailNavigateToCart();

  @override
  List<Object?> get props => const [];
}

final class CatalogRestaurantDetailConfirmRestaurantChange
    extends CatalogRestaurantDetailEffect {
  const CatalogRestaurantDetailConfirmRestaurantChange(this.menuItemId);

  final num menuItemId;

  @override
  List<Object?> get props => [menuItemId];
}

final class CatalogRestaurantDetailShowError
    extends CatalogRestaurantDetailEffect {
  const CatalogRestaurantDetailShowError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
