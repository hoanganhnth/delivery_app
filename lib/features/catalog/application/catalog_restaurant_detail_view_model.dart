import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/cart/application/cart_commands.dart';
import 'package:delivery_app/features/cart/di/cart_commands_provider.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/application/cart_notifier.dart';
import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/features/restaurants/application/detail/restaurant_detail_notifier.dart';
import 'package:delivery_app/features/restaurants/application/detail/restaurant_detail_state.dart';
import 'package:delivery_app/features/flash_sale/di/flash_sale_providers.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_item_entity.dart';

import 'catalog_restaurant_detail_effect.dart';
import 'catalog_restaurant_detail_intent.dart';
import 'catalog_restaurant_detail_state.dart';

final catalogRestaurantDetailViewModelProvider = NotifierProvider.family<
  CatalogRestaurantDetailViewModel,
  CatalogRestaurantDetailViewState,
  num
>((restaurantId) => CatalogRestaurantDetailViewModel(restaurantId));

/// Transitional catalog detail orchestrator. It adapts the legacy restaurant,
/// cart and flash-sale providers while keeping all user actions out of the UI.
class CatalogRestaurantDetailViewModel
    extends Notifier<CatalogRestaurantDetailViewState> {
  CatalogRestaurantDetailViewModel(this._restaurantId);

  int _nextEffectId = 0;
  final num _restaurantId;
  RestaurantDetailState? _detail;
  CartEntity? _cart;
  Map<int, FlashSaleItemEntity> _flashSales = const {};
  final Map<num, MenuItemEntity> _menuItemsById = {};
  bool _cartCommandRunning = false;

  @override
  CatalogRestaurantDetailViewState build() {
    _detail = ref.read(restaurantDetailProvider);
    _cart = ref.read(cartProvider).value;
    _flashSales =
        ref
            .read(
              restaurantFlashSaleItemsProvider(_asPositiveInt(_restaurantId)),
            )
            .value ??
        const {};
    ref.listen<RestaurantDetailState>(restaurantDetailProvider, (_, next) {
      _detail = next;
      _publish();
    });
    ref.listen<AsyncValue<CartEntity>>(cartProvider, (_, next) {
      _cart = next.value;
      _publish();
    });
    ref.listen<AsyncValue<Map<int, FlashSaleItemEntity>>>(
      restaurantFlashSaleItemsProvider(_asPositiveInt(_restaurantId)),
      (_, next) {
        _flashSales = next.value ?? const {};
        _publish();
      },
    );
    return _compose();
  }

  Future<void> dispatch(CatalogRestaurantDetailIntent intent) async {
    switch (intent) {
      case CatalogRestaurantDetailLoadRequested():
        if (_restaurantId <= 0) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: 'Không tìm thấy nhà hàng',
          );
          return;
        }
        await ref
            .read(restaurantDetailProvider.notifier)
            .loadRestaurantDetail(_restaurantId);
      case CatalogRestaurantDetailBackRequested():
        _emit(const CatalogRestaurantDetailNavigateBack());
      case CatalogRestaurantDetailCartRequested():
        _emit(const CatalogRestaurantDetailNavigateToCart());
      case CatalogRestaurantDetailIncrementRequested(:final menuItemId):
        await _increment(menuItemId, replaceRestaurant: false);
      case CatalogRestaurantDetailDecrementRequested(:final menuItemId):
        await _decrement(menuItemId);
      case CatalogRestaurantDetailRestaurantChangeConfirmed(:final menuItemId):
        await _increment(menuItemId, replaceRestaurant: true);
      case CatalogRestaurantDetailEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _increment(
    num menuItemId, {
    required bool replaceRestaurant,
  }) async {
    if (_cartCommandRunning) {
      return;
    }
    final menuItem = _menuItemsById[menuItemId];
    final restaurant = _detail?.restaurant;
    if (menuItem == null || restaurant == null || !menuItem.canAddToCart) {
      return;
    }

    final currentCart = _cart;
    if (!replaceRestaurant &&
        currentCart != null &&
        !currentCart.canAddFromRestaurant(restaurant.id)) {
      _emit(CatalogRestaurantDetailConfirmRestaurantChange(menuItemId));
      return;
    }

    _cartCommandRunning = true;
    try {
      final commands = ref.read(cartCommandsProvider);
      if (replaceRestaurant) await commands.clearCart();
      final quantity = currentCart?.getItemQuantity(menuItemId) ?? 0;
      if (quantity > 0 && !replaceRestaurant) {
        await commands.updateItemQuantity(menuItemId, quantity + 1);
      } else {
        final flash = _flashSales[menuItemId.toInt()];
        await commands.addItem(
          menuItem.toCartItem(
            restaurant.name,
            flashSaleItemId: flash?.id,
            serverCatalogPrice: flash?.flashSalePrice,
          ),
        );
      }
    } catch (_) {
      _emit(
        const CatalogRestaurantDetailShowError(
          'Không thể cập nhật giỏ hàng. Vui lòng thử lại.',
        ),
      );
    } finally {
      _cartCommandRunning = false;
    }
  }

  Future<void> _decrement(num menuItemId) async {
    if (_cartCommandRunning) {
      return;
    }
    final quantity = _cart?.getItemQuantity(menuItemId) ?? 0;
    if (quantity <= 0) {
      return;
    }

    _cartCommandRunning = true;
    try {
      final CartCommands commands = ref.read(cartCommandsProvider);
      if (quantity == 1) {
        await commands.removeItem(menuItemId);
      } else {
        await commands.updateItemQuantity(menuItemId, quantity - 1);
      }
    } catch (_) {
      _emit(
        const CatalogRestaurantDetailShowError(
          'Không thể cập nhật giỏ hàng. Vui lòng thử lại.',
        ),
      );
    } finally {
      _cartCommandRunning = false;
    }
  }

  void _publish() {
    if (!ref.mounted) {
      return;
    }
    state = _compose(effects: state.effects);
  }

  CatalogRestaurantDetailViewState _compose({
    List<UiEffectEnvelope<CatalogRestaurantDetailEffect>> effects = const [],
  }) {
    final detail = _detail ?? const RestaurantDetailState();
    _menuItemsById
      ..clear()
      ..addEntries(
        detail.menuItems
            .where((item) => item.id != null)
            .map((item) => MapEntry(item.id!, item)),
      );
    final cart = _cart;
    return CatalogRestaurantDetailViewState(
      restaurant:
          detail.restaurant == null
              ? null
              : _restaurantData(detail.restaurant!),
      menuItems: detail.menuItems.map(_menuItemData).toList(growable: false),
      isLoading: detail.isLoading,
      errorMessage: detail.errorMessage,
      cartItemsCount: cart?.totalItems ?? 0,
      cartTotalAmount: cart?.totalAmount ?? 0,
      effects: effects,
    );
  }

  CatalogRestaurantDetailData _restaurantData(RestaurantEntity restaurant) {
    return CatalogRestaurantDetailData(
      id: restaurant.id,
      name: restaurant.name,
      address: restaurant.address,
      description: restaurant.description,
      imageUrl: restaurant.image,
      rating: restaurant.rating,
      reviewCount: restaurant.reviewCount,
      deliveryTimeMinutes: restaurant.deliveryTime,
      openingHour: restaurant.openingHour,
      closingHour: restaurant.closingHour,
      isOpen: restaurant.isOpen,
    );
  }

  CatalogMenuItemViewData _menuItemData(MenuItemEntity item) {
    final flash = item.id == null ? null : _flashSales[item.id!.toInt()];
    return CatalogMenuItemViewData(
      id: item.id,
      name: item.name,
      description: item.description,
      catalogPrice: item.price,
      availability: switch (item.status) {
        MenuItemStatus.available => CatalogMenuAvailability.available,
        MenuItemStatus.unavailable => CatalogMenuAvailability.unavailable,
        MenuItemStatus.soldOut => CatalogMenuAvailability.soldOut,
      },
      imageUrl: item.image,
      flashSaleItemId: flash?.id,
      flashSalePrice: flash?.flashSalePrice,
      quantity: item.id == null ? 0 : (_cart?.getItemQuantity(item.id!) ?? 0),
    );
  }

  int _asPositiveInt(num value) => value > 0 ? value.toInt() : 0;

  void _emit(CatalogRestaurantDetailEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
