import 'package:equatable/equatable.dart';

sealed class CatalogHomeEffect extends Equatable {
  const CatalogHomeEffect();
}

final class CatalogHomeNavigateToSearch extends CatalogHomeEffect {
  const CatalogHomeNavigateToSearch();

  @override
  List<Object?> get props => const [];
}

final class CatalogHomeNavigateToAllRestaurants extends CatalogHomeEffect {
  const CatalogHomeNavigateToAllRestaurants();

  @override
  List<Object?> get props => const [];
}

final class CatalogHomeNavigateToVouchers extends CatalogHomeEffect {
  const CatalogHomeNavigateToVouchers();

  @override
  List<Object?> get props => const [];
}

final class CatalogHomeNavigateToLivestream extends CatalogHomeEffect {
  const CatalogHomeNavigateToLivestream();

  @override
  List<Object?> get props => const [];
}

final class CatalogHomeNavigateToAddresses extends CatalogHomeEffect {
  const CatalogHomeNavigateToAddresses();

  @override
  List<Object?> get props => const [];
}

final class CatalogHomeNavigateToNotifications extends CatalogHomeEffect {
  const CatalogHomeNavigateToNotifications();

  @override
  List<Object?> get props => const [];
}

final class CatalogHomeNavigateToCart extends CatalogHomeEffect {
  const CatalogHomeNavigateToCart();

  @override
  List<Object?> get props => const [];
}

final class CatalogHomeNavigateToRestaurant extends CatalogHomeEffect {
  const CatalogHomeNavigateToRestaurant(this.restaurantId);

  final num restaurantId;

  @override
  List<Object?> get props => [restaurantId];
}
