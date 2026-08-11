import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';

import 'catalog_home_effect.dart';

/// Display-safe restaurant facts. DTOs and feature-domain entities stop at the
/// ViewModel boundary; the view receives only the fields it can render.
final class CatalogRestaurantViewData extends Equatable {
  const CatalogRestaurantViewData({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    this.address,
    this.rating,
    this.reviewCount,
    this.deliveryTimeMinutes,
    this.category,
    this.distanceKm,
    this.deliveryFee,
  });

  final num id;
  final String name;
  final String? imageUrl;
  final String? description;
  final String? address;
  final double? rating;
  final int? reviewCount;
  final num? deliveryTimeMinutes;
  final String? category;
  final double? distanceKm;
  final double? deliveryFee;

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    description,
    address,
    rating,
    reviewCount,
    deliveryTimeMinutes,
    category,
    distanceKm,
    deliveryFee,
  ];
}

final class CatalogHomeViewState extends Equatable {
  const CatalogHomeViewState({
    this.restaurants = const <CatalogRestaurantViewData>[],
    this.isLoading = false,
    this.errorMessage,
    this.effects = const <UiEffectEnvelope<CatalogHomeEffect>>[],
  });

  final List<CatalogRestaurantViewData> restaurants;
  final bool isLoading;
  final String? errorMessage;
  final List<UiEffectEnvelope<CatalogHomeEffect>> effects;

  bool get hasError => errorMessage != null;

  CatalogHomeViewState copyWith({
    List<CatalogRestaurantViewData>? restaurants,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    List<UiEffectEnvelope<CatalogHomeEffect>>? effects,
  }) {
    return CatalogHomeViewState(
      restaurants: restaurants ?? this.restaurants,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [restaurants, isLoading, errorMessage, effects];
}
