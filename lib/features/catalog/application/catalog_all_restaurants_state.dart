import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:equatable/equatable.dart';

import 'catalog_all_restaurants_effect.dart';

final class CatalogAllRestaurantsViewState extends Equatable {
  const CatalogAllRestaurantsViewState({
    this.restaurants = const [],
    this.isLoading = false,
    this.errorMessage,
    this.effects = const <UiEffectEnvelope<CatalogAllRestaurantsEffect>>[],
  });

  final List<CatalogRestaurantViewData> restaurants;
  final bool isLoading;
  final String? errorMessage;
  final List<UiEffectEnvelope<CatalogAllRestaurantsEffect>> effects;

  bool get hasError => errorMessage != null;
  bool get isEmpty => !isLoading && !hasError && restaurants.isEmpty;

  CatalogAllRestaurantsViewState copyWith({
    List<CatalogRestaurantViewData>? restaurants,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    List<UiEffectEnvelope<CatalogAllRestaurantsEffect>>? effects,
  }) => CatalogAllRestaurantsViewState(
    restaurants: restaurants ?? this.restaurants,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    effects: effects ?? this.effects,
  );

  @override
  List<Object?> get props => [restaurants, isLoading, errorMessage, effects];
}
