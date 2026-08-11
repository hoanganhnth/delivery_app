import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'cart_view_effect.dart';

final class CartLineViewData extends Equatable {
  const CartLineViewData({
    required this.menuItemId,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
    this.notes,
  });
  final num menuItemId;
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;
  final String? notes;
  @override
  List<Object?> get props => [
    menuItemId,
    name,
    price,
    quantity,
    imageUrl,
    notes,
  ];
}

final class CartViewState extends Equatable {
  const CartViewState({
    this.restaurantName,
    this.items = const [],
    this.isLoading = true,
    this.hasError = false,
    this.totalAmount = 0,
    this.effects = const [],
  });
  final String? restaurantName;
  final List<CartLineViewData> items;
  final bool isLoading;
  final bool hasError;
  final double totalAmount;
  final List<UiEffectEnvelope<CartViewEffect>> effects;
  bool get isEmpty => items.isEmpty;
  int get totalItems => items.fold(0, (total, item) => total + item.quantity);
  CartViewState copyWith({
    String? restaurantName,
    bool clearRestaurant = false,
    List<CartLineViewData>? items,
    bool? isLoading,
    bool? hasError,
    double? totalAmount,
    List<UiEffectEnvelope<CartViewEffect>>? effects,
  }) => CartViewState(
    restaurantName: clearRestaurant
        ? null
        : (restaurantName ?? this.restaurantName),
    items: items ?? this.items,
    isLoading: isLoading ?? this.isLoading,
    hasError: hasError ?? this.hasError,
    totalAmount: totalAmount ?? this.totalAmount,
    effects: effects ?? this.effects,
  );
  @override
  List<Object?> get props => [
    restaurantName,
    items,
    isLoading,
    hasError,
    totalAmount,
    effects,
  ];
}
