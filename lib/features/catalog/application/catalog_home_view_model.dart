import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/core/contracts/catalog_port_provider.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';

import 'catalog_home_effect.dart';
import 'catalog_home_intent.dart';
import 'catalog_home_state.dart';

final catalogHomeViewModelProvider =
    NotifierProvider<CatalogHomeViewModel, CatalogHomeViewState>(
      CatalogHomeViewModel.new,
    );

/// Transitional ViewModel for the catalog landing page.
///
/// It maps the legacy restaurant notifier into catalog presentation data. The
/// next catalog slice will replace this notifier seam with a catalog-owned
/// repository port without changing the view or its intent contract.
class CatalogHomeViewModel extends Notifier<CatalogHomeViewState> {
  int _nextEffectId = 0;
  bool _loading = false;

  @override
  CatalogHomeViewState build() => const CatalogHomeViewState();

  Future<void> dispatch(CatalogHomeIntent intent) async {
    switch (intent) {
      case CatalogHomeLoadRequested():
        if (_loading) return;
        _loading = true;
        state = state.copyWith(isLoading: true, clearError: true);
        final result = await ref.read(catalogBrowsePortProvider).loadFeatured();
        if (!ref.mounted) return;
        _loading = false;
        state = state.copyWith(
          restaurants: result.restaurants.map(_toViewData).toList(growable: false),
          isLoading: false,
          errorMessage: result.errorMessage,
          clearError: result.errorMessage == null,
        );
      case CatalogHomeSearchRequested():
        _emit(const CatalogHomeNavigateToSearch());
      case CatalogHomeAllRestaurantsRequested():
        _emit(const CatalogHomeNavigateToAllRestaurants());
      case CatalogHomeVouchersRequested():
        _emit(const CatalogHomeNavigateToVouchers());
      case CatalogHomeLivestreamRequested():
        _emit(const CatalogHomeNavigateToLivestream());
      case CatalogHomeAddressRequested():
        _emit(const CatalogHomeNavigateToAddresses());
      case CatalogHomeNotificationsRequested():
        _emit(const CatalogHomeNavigateToNotifications());
      case CatalogHomeCartRequested():
        _emit(const CatalogHomeNavigateToCart());
      case CatalogHomeRestaurantRequested(:final restaurantId):
        _emit(CatalogHomeNavigateToRestaurant(restaurantId));
      case CatalogHomeEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  CatalogRestaurantViewData _toViewData(CatalogRestaurantSnapshot restaurant) {
    return CatalogRestaurantViewData(
      id: restaurant.id,
      name: restaurant.name,
      imageUrl: restaurant.imageUrl,
      description: restaurant.description,
      address: restaurant.address,
      rating: restaurant.rating,
      reviewCount: restaurant.reviewCount,
      deliveryTimeMinutes: restaurant.deliveryTimeMinutes,
      category: restaurant.category,
      distanceKm: restaurant.distanceKm,
      deliveryFee: restaurant.deliveryFee,
    );
  }

  void _emit(CatalogHomeEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
