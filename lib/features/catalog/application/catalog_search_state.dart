import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';

import 'catalog_search_effect.dart';
import 'catalog_search_intent.dart';

final class CatalogDishSearchViewData extends Equatable {
  const CatalogDishSearchViewData({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.restaurantId,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? description;
  final double? price;
  final String? restaurantId;
  final String? imageUrl;

  bool get canOpenRestaurant =>
      restaurantId != null && restaurantId!.trim().isNotEmpty;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    restaurantId,
    imageUrl,
  ];
}

final class CatalogRestaurantSearchViewData extends Equatable {
  const CatalogRestaurantSearchViewData({
    required this.id,
    required this.name,
    this.cuisine,
    this.rating,
    this.distanceKm,
    this.deliveryTimeMinutes,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? cuisine;
  final double? rating;
  final double? distanceKm;
  final num? deliveryTimeMinutes;
  final String? imageUrl;

  @override
  List<Object?> get props => [
    id,
    name,
    cuisine,
    rating,
    distanceKm,
    deliveryTimeMinutes,
    imageUrl,
  ];
}

final class CatalogSearchViewState extends Equatable {
  const CatalogSearchViewState({
    this.query = '',
    this.tab = CatalogSearchTab.dishes,
    this.sort = CatalogSearchSort.recommended,
    this.dishes = const <CatalogDishSearchViewData>[],
    this.restaurants = const <CatalogRestaurantSearchViewData>[],
    this.isSearching = false,
    this.hasDishError = false,
    this.hasRestaurantError = false,
    this.effects = const <UiEffectEnvelope<CatalogSearchEffect>>[],
  });

  final String query;
  final CatalogSearchTab tab;
  final CatalogSearchSort sort;
  final List<CatalogDishSearchViewData> dishes;
  final List<CatalogRestaurantSearchViewData> restaurants;
  final bool isSearching;
  final bool hasDishError;
  final bool hasRestaurantError;
  final List<UiEffectEnvelope<CatalogSearchEffect>> effects;

  bool get isQueryEmpty => query.isEmpty;
  bool get hasVisibleError => switch (tab) {
    CatalogSearchTab.dishes => hasDishError,
    CatalogSearchTab.restaurants => hasRestaurantError,
  };

  CatalogSearchViewState copyWith({
    String? query,
    bool clearQuery = false,
    CatalogSearchTab? tab,
    CatalogSearchSort? sort,
    List<CatalogDishSearchViewData>? dishes,
    List<CatalogRestaurantSearchViewData>? restaurants,
    bool? isSearching,
    bool? hasDishError,
    bool? hasRestaurantError,
    List<UiEffectEnvelope<CatalogSearchEffect>>? effects,
  }) {
    return CatalogSearchViewState(
      query: clearQuery ? '' : (query ?? this.query),
      tab: tab ?? this.tab,
      sort: sort ?? this.sort,
      dishes: dishes ?? this.dishes,
      restaurants: restaurants ?? this.restaurants,
      isSearching: isSearching ?? this.isSearching,
      hasDishError: hasDishError ?? this.hasDishError,
      hasRestaurantError: hasRestaurantError ?? this.hasRestaurantError,
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    query,
    tab,
    sort,
    dishes,
    restaurants,
    isSearching,
    hasDishError,
    hasRestaurantError,
    effects,
  ];
}
