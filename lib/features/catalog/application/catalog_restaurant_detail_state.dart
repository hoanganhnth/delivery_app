import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';

import 'catalog_restaurant_detail_effect.dart';

enum CatalogMenuAvailability { available, unavailable, soldOut }

final class CatalogRestaurantDetailData extends Equatable {
  const CatalogRestaurantDetailData({
    required this.id,
    required this.name,
    required this.address,
    this.description,
    this.imageUrl,
    this.rating,
    this.reviewCount,
    this.deliveryTimeMinutes,
    this.distanceKm,
    this.openingHour,
    this.closingHour,
    this.isOpen,
  });

  final num id;
  final String name;
  final String address;
  final String? description;
  final String? imageUrl;
  final double? rating;
  final int? reviewCount;
  final int? deliveryTimeMinutes;
  final double? distanceKm;
  final String? openingHour;
  final String? closingHour;
  final bool? isOpen;

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    description,
    imageUrl,
    rating,
    reviewCount,
    deliveryTimeMinutes,
    distanceKm,
    openingHour,
    closingHour,
    isOpen,
  ];
}

final class CatalogMenuItemViewData extends Equatable {
  const CatalogMenuItemViewData({
    required this.id,
    required this.name,
    required this.description,
    required this.catalogPrice,
    required this.availability,
    this.imageUrl,
    this.flashSaleItemId,
    this.flashSalePrice,
    this.quantity = 0,
  });

  final num? id;
  final String name;
  final String description;
  final double catalogPrice;
  final CatalogMenuAvailability availability;
  final String? imageUrl;
  final int? flashSaleItemId;
  final double? flashSalePrice;
  final int quantity;

  bool get hasCanonicalIdentity => id != null && id! > 0;
  bool get isAvailable => availability == CatalogMenuAvailability.available;
  bool get canAdd => hasCanonicalIdentity && isAvailable;
  double get displayedPrice => flashSalePrice ?? catalogPrice;
  bool get hasFlashSale => flashSaleItemId != null && flashSalePrice != null;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    catalogPrice,
    availability,
    imageUrl,
    flashSaleItemId,
    flashSalePrice,
    quantity,
  ];
}

final class CatalogRestaurantDetailViewState extends Equatable {
  const CatalogRestaurantDetailViewState({
    this.restaurant,
    this.menuItems = const <CatalogMenuItemViewData>[],
    this.isLoading = false,
    this.errorMessage,
    this.cartItemsCount = 0,
    this.cartTotalAmount = 0,
    this.effects = const <UiEffectEnvelope<CatalogRestaurantDetailEffect>>[],
  });

  final CatalogRestaurantDetailData? restaurant;
  final List<CatalogMenuItemViewData> menuItems;
  final bool isLoading;
  final String? errorMessage;
  final int cartItemsCount;
  final double cartTotalAmount;
  final List<UiEffectEnvelope<CatalogRestaurantDetailEffect>> effects;

  bool get hasError => errorMessage != null;
  bool get hasRestaurant => restaurant != null;
  bool get isCartEmpty => cartItemsCount == 0;

  CatalogRestaurantDetailViewState copyWith({
    CatalogRestaurantDetailData? restaurant,
    bool clearRestaurant = false,
    List<CatalogMenuItemViewData>? menuItems,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    int? cartItemsCount,
    double? cartTotalAmount,
    List<UiEffectEnvelope<CatalogRestaurantDetailEffect>>? effects,
  }) {
    return CatalogRestaurantDetailViewState(
      restaurant: clearRestaurant ? null : (restaurant ?? this.restaurant),
      menuItems: menuItems ?? this.menuItems,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      cartItemsCount: cartItemsCount ?? this.cartItemsCount,
      cartTotalAmount: cartTotalAmount ?? this.cartTotalAmount,
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    restaurant,
    menuItems,
    isLoading,
    errorMessage,
    cartItemsCount,
    cartTotalAmount,
    effects,
  ];
}
