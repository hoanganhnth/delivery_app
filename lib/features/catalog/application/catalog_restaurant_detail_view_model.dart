import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/contracts/catalog_contract.dart';
import 'package:delivery_app/core/contracts/catalog_port_provider.dart';
import 'package:delivery_app/core/contracts/cart_contract.dart';
import 'package:delivery_app/core/contracts/cart_port_provider.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/flash_sale/di/flash_sale_providers.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_item_entity.dart';

import 'catalog_restaurant_detail_effect.dart';
import 'catalog_restaurant_detail_intent.dart';
import 'catalog_restaurant_detail_state.dart';

final catalogRestaurantDetailViewModelProvider =
    NotifierProvider.family<
      CatalogRestaurantDetailViewModel,
      CatalogRestaurantDetailViewState,
      num
    >((restaurantId) => CatalogRestaurantDetailViewModel(restaurantId));

/// Catalog detail orchestrator. Restaurant data enters through the neutral
/// browse port; cart and gated flash-sale ports remain separate seams.
class CatalogRestaurantDetailViewModel
    extends Notifier<CatalogRestaurantDetailViewState> {
  CatalogRestaurantDetailViewModel(this._restaurantId);

  int _nextEffectId = 0;
  final num _restaurantId;
  CatalogDetailResult? _detail;
  CartSnapshot? _cart;
  Map<int, FlashSaleItemEntity> _flashSales = const {};
  final Map<num, CatalogMenuSnapshot> _menuItemsById = {};
  bool _cartCommandRunning = false;
  bool _loading = false;

  @override
  CatalogRestaurantDetailViewState build() {
    final reader = ref.read(cartReaderPortProvider);
    _cart = reader.current;
    _flashSales =
        ref
            .read(
              restaurantFlashSaleItemsProvider(_asPositiveInt(_restaurantId)),
            )
            .value ??
        const {};
    final cartSubscription = reader.changes.listen((next) {
      if (!ref.mounted) return;
      _cart = next;
      _publish();
    });
    ref.onDispose(cartSubscription.cancel);
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
        if (_loading) return;
        _loading = true;
        state = state.copyWith(isLoading: true, clearError: true);
        final detail = await ref
            .read(catalogBrowsePortProvider)
            .loadDetail(_restaurantId.toInt());
        if (!ref.mounted) return;
        _loading = false;
        _detail = detail;
        _publish();
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
        currentCart.isNotEmpty &&
        currentCart.restaurantId != restaurant.id.toInt()) {
      _emit(CatalogRestaurantDetailConfirmRestaurantChange(menuItemId));
      return;
    }

    _cartCommandRunning = true;
    try {
      final commands = ref.read(cartCommandsPortProvider);
      if (replaceRestaurant) await commands.clear();
      final quantity = _quantityFor(menuItemId);
      if (quantity > 0 && !replaceRestaurant) {
        await commands.setQuantity(menuItemId.toInt(), quantity + 1);
      } else {
        final flash = _flashSales[menuItemId.toInt()];
        await commands.addLine(
          CartLineInput(
            menuItemId: menuItem.id!.toInt(),
            restaurantId: menuItem.restaurantId!.toInt(),
            restaurantName: restaurant.name,
            name: menuItem.name,
            unitPrice: flash?.flashSalePrice ?? menuItem.price,
            quantity: 1,
            imageUrl: menuItem.image,
            flashSaleItemId: flash?.id,
          ),
        );
      }
      _cart = ref.read(cartReaderPortProvider).current;
      _publish();
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
    final quantity = _quantityFor(menuItemId);
    if (quantity <= 0) {
      return;
    }

    _cartCommandRunning = true;
    try {
      final commands = ref.read(cartCommandsPortProvider);
      if (quantity == 1) {
        await commands.removeLine(menuItemId.toInt());
      } else {
        await commands.setQuantity(menuItemId.toInt(), quantity - 1);
      }
      _cart = ref.read(cartReaderPortProvider).current;
      _publish();
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
    final detail = _detail ?? const CatalogDetailResult();
    _menuItemsById
      ..clear()
      ..addEntries(
        detail.menuItems
            .where((item) => item.id != null)
            .map((item) => MapEntry(item.id!, item)),
      );
    final cart = _cart;
    return CatalogRestaurantDetailViewState(
      restaurant: detail.restaurant == null
          ? null
          : _restaurantData(detail.restaurant!),
      menuItems: detail.menuItems.map(_menuItemData).toList(growable: false),
      isLoading: _loading,
      errorMessage: detail.errorMessage,
      cartItemsCount: cart?.totalItems ?? 0,
      cartTotalAmount: cart?.totalAmount ?? 0,
      effects: effects,
    );
  }

  CatalogRestaurantDetailData _restaurantData(
    CatalogRestaurantSnapshot restaurant,
  ) {
    return CatalogRestaurantDetailData(
      id: restaurant.id,
      name: restaurant.name,
      address: restaurant.address ?? '',
      description: restaurant.description,
      imageUrl: restaurant.imageUrl,
      rating: restaurant.rating,
      reviewCount: restaurant.reviewCount,
      deliveryTimeMinutes: restaurant.deliveryTimeMinutes?.toInt(),
      openingHour: restaurant.openingHour,
      closingHour: restaurant.closingHour,
      isOpen: restaurant.isOpen,
    );
  }

  CatalogMenuItemViewData _menuItemData(CatalogMenuSnapshot item) {
    final flash = item.id == null ? null : _flashSales[item.id!.toInt()];
    return CatalogMenuItemViewData(
      id: item.id,
      name: item.name,
      description: item.description,
      catalogPrice: item.price,
      availability: switch (item.status) {
        CatalogMenuStatus.available => CatalogMenuAvailability.available,
        CatalogMenuStatus.unavailable => CatalogMenuAvailability.unavailable,
        CatalogMenuStatus.soldOut => CatalogMenuAvailability.soldOut,
      },
      imageUrl: item.imageUrl,
      flashSaleItemId: flash?.id,
      flashSalePrice: flash?.flashSalePrice,
      quantity: item.id == null ? 0 : _quantityFor(item.id!),
    );
  }

  int _asPositiveInt(num value) => value > 0 ? value.toInt() : 0;

  int _quantityFor(num menuItemId) =>
      _cart?.lines
          .where((line) => line.menuItemId == menuItemId.toInt())
          .fold<int>(0, (sum, line) => sum + line.quantity) ??
      0;

  void _emit(CatalogRestaurantDetailEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
