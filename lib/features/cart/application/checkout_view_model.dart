import 'dart:async';

import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/cart/application/checkout_effect.dart';
import 'package:delivery_app/features/cart/application/checkout_intent.dart';
import 'package:delivery_app/features/cart/application/checkout_order_builder.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/features/cart/application/checkout_voucher.dart';
import 'package:delivery_app/features/cart/di/cart_commands_provider.dart';
import 'package:delivery_app/features/cart/di/checkout_providers.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/application/cart_notifier.dart';
import 'package:delivery_app/core/contracts/session_port_provider.dart';
import 'package:delivery_app/features/orders/data/dtos/checkout_preview_dto.dart';
import 'package:delivery_app/features/orders/di/order_providers.dart';
import 'package:delivery_app/features/orders/application/state/orders/orders_list_notifier.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';
import 'package:delivery_app/features/user_address/application/address_store_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:delivery_app/core/error/failures.dart';

final checkoutViewModelProvider =
    NotifierProvider<CheckoutViewModel, CheckoutViewState>(
      CheckoutViewModel.new,
    );

/// Single application owner of the checkout transaction.
///
/// Cart and selected-address providers are temporary read-only projections
/// while their bounded contexts finish migration. Preview confirmation remains
/// server-owned and is discarded whenever an input changes.
class CheckoutViewModel extends Notifier<CheckoutViewState> {
  int _nextEffectId = 0;
  int _previewEpoch = 0;
  int _voucherEpoch = 0;
  AsyncValue<CartEntity>? _cartValue;
  UserAddressEntity? _address;
  CheckoutPreviewResponse? _confirmedPreview;
  String? _confirmedPreviewKey;
  String? _activePreviewKey;
  List<CheckoutVoucher> _vouchers = const [];
  int? _selectedVoucherId;
  List<int> _selectedVoucherIds = const <int>[];
  String _selectionMode = 'AUTO';
  String _notes = '';
  bool _isPreviewLoading = false;
  bool _hasPreviewError = false;
  bool _isVoucherLoading = false;
  bool _hasVoucherError = false;
  bool _stackingCapabilityEnabled = false;
  bool _isPlacingOrder = false;
  String? _pendingIdempotencyKey;

  @override
  CheckoutViewState build() {
    _cartValue = ref.read(cartProvider);
    _address = _selectedAddress(ref.read(userAddressListProvider));

    ref.listen<AsyncValue<CartEntity>>(cartProvider, (_, next) {
      final changed =
          _cartSignature(_cartValue?.value) != _cartSignature(next.value);
      _cartValue = next;
      if (changed) _invalidatePreview();
      _publish();
      if (changed) {
        unawaited(_refreshPreview());
        unawaited(_loadVouchers(force: true));
      }
    });
    ref.listen<UserAddressListState>(userAddressListProvider, (_, next) {
      final selected = _selectedAddress(next);
      if (selected != _address) {
        _address = selected;
        _invalidatePreview();
        _publish();
        unawaited(_refreshPreview());
      }
    });
    return _compose();
  }

  Future<void> dispatch(CheckoutIntent intent) async {
    switch (intent) {
      case CheckoutLoadRequested():
        await _loadAddressesForCurrentSession();
        await _loadStackingCapability();
        await Future.wait([_refreshPreview(), _loadVouchers()]);
      case CheckoutPreviewRetryRequested():
        await _refreshPreview(force: true);
      case CheckoutAddressSelectionRequested():
        _emit(const CheckoutNavigateToAddresses());
      case CheckoutVoucherChanged(:final voucherId):
        await _changeVoucher(voucherId);
      case CheckoutVoucherSelectionChanged(:final voucherIds):
        await _changeVoucherSelection(voucherIds);
      case CheckoutVoucherModeChanged(:final mode):
        await _changeVoucherMode(mode);
      case CheckoutVoucherCodeSubmitted(:final code):
        await _collectVoucher(code);
      case CheckoutVoucherRetryRequested():
        await _loadVouchers(force: true);
      case CheckoutNotesChanged(:final notes):
        _notes = notes;
        _pendingIdempotencyKey = null;
        _publish();
      case CheckoutPlaceOrderRequested():
        await _placeOrder();
      case CheckoutPriceChangeAccepted():
        await _placeOrder(forceNewKey: true);
      case CheckoutBackRequested():
        _emit(const CheckoutNavigateBack());
      case CheckoutEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _refreshPreview({bool force = false}) async {
    final cart = _cartValue?.value;
    CheckoutPreviewRequest request;
    try {
      if (cart == null || cart.isEmpty) {
        _clearPreview();
        _publish();
        return;
      }
      request = CheckoutOrderBuilder.buildPreviewRequest(
        cart: cart,
        address: _address,
        selectedVoucherId: _selectedVoucherId,
        selectedVoucherIds: _stackingEnabled ? _selectedVoucherIds : null,
        selectionMode: _stackingEnabled ? _selectionMode : null,
      );
    } on CheckoutOrderBuildException {
      _clearPreview();
      _publish();
      return;
    }

    final key = _previewKey(request);
    if (!force &&
        (key == _activePreviewKey ||
            (key == _confirmedPreviewKey && _confirmedPreview != null))) {
      return;
    }

    final epoch = ++_previewEpoch;
    _activePreviewKey = key;
    _confirmedPreview = null;
    _confirmedPreviewKey = null;
    _isPreviewLoading = true;
    _hasPreviewError = false;
    _publish();
    try {
      final preview = await ref
          .read(checkoutPreviewGatewayProvider)
          .preview(request);
      if (!ref.mounted || epoch != _previewEpoch) return;
      final unavailable = preview.unavailableItemIds ?? const <int>[];
      if (unavailable.isNotEmpty) {
        _isPreviewLoading = false;
        _activePreviewKey = null;
        _publish();
        _emit(
          CheckoutShowUnavailableItems(List<int>.unmodifiable(unavailable)),
        );
        return;
      }
      _confirmedPreview = preview.validateFor(request);
      _confirmedPreviewKey = key;
      _activePreviewKey = null;
      _isPreviewLoading = false;
      _hasPreviewError = false;
      _publish();
    } catch (_) {
      if (!ref.mounted || epoch != _previewEpoch) return;
      _activePreviewKey = null;
      _confirmedPreview = null;
      _confirmedPreviewKey = null;
      _isPreviewLoading = false;
      _hasPreviewError = true;
      _publish();
    }
  }

  Future<void> _loadAddressesForCurrentSession() async {
    final profileId = ref.read(sessionPortProvider).current.profileId;
    if (profileId == null || profileId <= 0) return;

    final notifier = ref.read(userAddressListProvider.notifier);
    final loaded = await notifier.loadAddresses(profileId);
    if (!ref.mounted) return;

    if (loaded) notifier.autoSelectDefaultAddress();
    final selected = _selectedAddress(ref.read(userAddressListProvider));
    if (selected == _address) return;

    _address = selected;
    _invalidatePreview();
    _publish();
  }

  Future<void> _loadVouchers({bool force = false}) async {
    if (!_isVoucherAvailable) {
      final wasSelected =
          _selectedVoucherIds.isNotEmpty || _selectedVoucherId != null;
      _vouchers = const [];
      _selectedVoucherId = null;
      _selectedVoucherIds = const <int>[];
      _isVoucherLoading = false;
      _hasVoucherError = false;
      if (wasSelected) _invalidatePreview();
      _publish();
      if (wasSelected) await _refreshPreview();
      return;
    }
    if (_isVoucherLoading || (!force && _vouchers.isNotEmpty)) return;
    final epoch = ++_voucherEpoch;
    _isVoucherLoading = true;
    _hasVoucherError = false;
    _publish();
    try {
      final restaurantId = _cartValue?.value?.currentRestaurantId?.toInt();
      final wallet = await ref.read(checkoutVoucherGatewayProvider).getWallet();
      if (!ref.mounted || epoch != _voucherEpoch) return;
      _vouchers = restaurantId == null
          ? const []
          : List<CheckoutVoucher>.unmodifiable(
              wallet.where(
                (voucher) => voucher.appliesToRestaurant(restaurantId),
              ),
            );
      final validIds = _selectedVoucherIds
          .where((id) => _vouchers.any((voucher) => voucher.id == id))
          .toList(growable: false);
      final didClearSelection = validIds.length != _selectedVoucherIds.length;
      if (didClearSelection) {
        _selectedVoucherIds = validIds;
        _selectedVoucherId = validIds.isEmpty ? null : validIds.first;
        _invalidatePreview();
      }
      _isVoucherLoading = false;
      _hasVoucherError = false;
      _publish();
      if (didClearSelection) await _refreshPreview();
    } catch (_) {
      if (!ref.mounted || epoch != _voucherEpoch) return;
      _isVoucherLoading = false;
      _hasVoucherError = true;
      _publish();
    }
  }

  Future<void> _loadStackingCapability() async {
    if (!RuntimeConfig.voucherStackingEnabled) {
      _stackingCapabilityEnabled = false;
      return;
    }
    try {
      final capability = await ref
          .read(checkoutVoucherGatewayProvider)
          .getCapability();
      if (ref.mounted) {
        _stackingCapabilityEnabled =
            capability.enabled &&
            capability.maxVouchers >= 3 &&
            capability.layers.contains('SHOP_DISCOUNT') &&
            capability.layers.contains('PLATFORM_DISCOUNT') &&
            capability.layers.contains('FREESHIP');
      }
    } catch (_) {
      _stackingCapabilityEnabled = false;
    }
  }

  Future<void> _changeVoucher(int? voucherId) async {
    final next = voucherId != null && voucherId > 0 ? voucherId : null;
    final nextIds = next == null ? const <int>[] : <int>[next];
    if (next == _selectedVoucherId &&
        nextIds.length == _selectedVoucherIds.length) {
      return;
    }
    _selectedVoucherId = next;
    _selectedVoucherIds = nextIds;
    _selectionMode = 'MANUAL';
    _invalidatePreview();
    _publish();
    await _refreshPreview();
  }

  Future<void> _changeVoucherSelection(List<int> voucherIds) async {
    if (!_stackingEnabled) {
      await _changeVoucher(voucherIds.isEmpty ? null : voucherIds.first);
      return;
    }
    final selected = <int>[];
    final layers = <String>{};
    for (final id in voucherIds) {
      if (selected.length >= 3 || selected.contains(id)) continue;
      CheckoutVoucher? voucher;
      for (final candidate in _vouchers) {
        if (candidate.id == id) {
          voucher = candidate;
          break;
        }
      }
      if (voucher == null || !layers.add(voucher.layer)) continue;
      selected.add(id);
    }
    _selectedVoucherIds = List<int>.unmodifiable(selected);
    _selectedVoucherId = selected.isEmpty ? null : selected.first;
    _selectionMode = 'MANUAL';
    _invalidatePreview();
    _publish();
    await _refreshPreview();
  }

  Future<void> _changeVoucherMode(String mode) async {
    if (!_stackingEnabled) return;
    final next = mode.toUpperCase() == 'MANUAL' ? 'MANUAL' : 'AUTO';
    if (next == _selectionMode) return;
    _selectionMode = next;
    if (next == 'AUTO') {
      _selectedVoucherIds = const <int>[];
      _selectedVoucherId = null;
    }
    _invalidatePreview();
    _publish();
    await _refreshPreview();
  }

  Future<void> _collectVoucher(String code) async {
    try {
      await ref.read(checkoutVoucherGatewayProvider).collect(code);
      await _loadVouchers(force: true);
      _invalidatePreview();
      _publish();
      await _refreshPreview(force: true);
      _emit(const CheckoutShowMessage('Đã lưu voucher vào ví.'));
    } catch (_) {
      _emit(
        const CheckoutShowMessage('Mã voucher không hợp lệ hoặc đã được lưu.'),
      );
    }
  }

  Future<void> _placeOrder({bool forceNewKey = false}) async {
    if (_isPlacingOrder) return;
    final cart = _cartValue?.value;
    try {
      if (cart == null) {
        throw const CheckoutOrderBuildException(
          CheckoutOrderBuildFailure.invalidInput,
        );
      }
      if (forceNewKey || _pendingIdempotencyKey == null) {
        _pendingIdempotencyKey = const Uuid().v4();
      }
      final request = CheckoutOrderBuilder.buildOrderRequest(
        cart: cart,
        address: _address,
        preview: _confirmedPreview,
        notes: _notes.trim().isEmpty ? null : _notes.trim(),
        selectedVoucherId: _selectedVoucherId,
        selectedVoucherIds: _stackingEnabled ? _selectedVoucherIds : null,
        selectionMode: _stackingEnabled ? _selectionMode : null,
        idempotencyKey: _pendingIdempotencyKey,
      );
      _isPlacingOrder = true;
      _publish();
      final result = await ref.read(createOrderUseCaseProvider).call(request);
      if (!ref.mounted) return;
      await result.fold(
        (failure) async {
          _isPlacingOrder = false;
          if (failure is ConflictFailure && failure.code == 'PRICE_CHANGED') {
            final rawQuote = failure.details?['quote'];
            if (rawQuote is Map) {
              try {
                final previewRequest = CheckoutOrderBuilder.buildPreviewRequest(
                  cart: cart,
                  address: _address,
                  selectedVoucherId: _selectedVoucherId,
                  selectedVoucherIds: _stackingEnabled
                      ? _selectedVoucherIds
                      : null,
                  selectionMode: _stackingEnabled ? _selectionMode : null,
                );
                final changed = CheckoutPreviewResponse.fromJson(
                  Map<String, dynamic>.from(rawQuote),
                ).validateFor(previewRequest);
                final oldTotal = _confirmedPreview?.totalPrice ?? 0;
                _confirmedPreview = changed;
                _confirmedPreviewKey = _previewKey(previewRequest);
                _activePreviewKey = null;
                _pendingIdempotencyKey = null;
                _publish();
                _emit(
                  CheckoutPriceChanged(
                    oldTotal: oldTotal,
                    newTotal: changed.totalPrice ?? 0,
                  ),
                );
                return;
              } on FormatException {
                // Fall through to the generic safe error below.
              }
            }
          }
          if (failure is ConflictFailure && failure.code == 'QUOTE_EXPIRED') {
            _pendingIdempotencyKey = null;
            _clearPreview();
            _publish();
            _emit(const CheckoutQuoteExpired());
            unawaited(_refreshPreview(force: true));
            return;
          }
          _publish();
          _emit(
            CheckoutOrderPlaced(isSuccess: false, message: failure.message),
          );
        },
        (order) async {
          _isPlacingOrder = false;
          try {
            await ref.read(cartCommandsProvider).clearCart();
          } catch (_) {
            // The order is already accepted. Keep success UX and leave the
            // persisted cart available for the next startup price sync.
          }
          if (!ref.mounted) return;
          ref.invalidate(ordersListProvider);
          _publish();
          _emit(const CheckoutOrderPlaced(isSuccess: true));
        },
      );
    } on CheckoutOrderBuildException catch (error) {
      _emit(
        CheckoutShowMessage(
          error.failure == CheckoutOrderBuildFailure.invalidInput
              ? 'Vui lòng chọn địa chỉ giao hàng hợp lệ.'
              : 'Giá đơn hàng chưa được xác nhận. Vui lòng thử lại.',
        ),
      );
    } catch (_) {
      if (!ref.mounted) return;
      _isPlacingOrder = false;
      _publish();
      _emit(const CheckoutOrderPlaced(isSuccess: false));
    }
  }

  UserAddressEntity? _selectedAddress(UserAddressListState addresses) =>
      addresses.selectedAddress ?? addresses.defaultAddress;

  bool get _isVoucherAvailable {
    final cart = _cartValue?.value;
    return (_stackingEnabled || RuntimeConfig.voucherCheckoutEnabled) &&
        cart != null &&
        cart.currentRestaurantId != null &&
        cart.currentRestaurantId! > 0 &&
        !cart.items.any((item) => item.flashSaleItemId != null);
  }

  void _invalidatePreview() {
    _previewEpoch++;
    _pendingIdempotencyKey = null;
    _clearPreview();
  }

  void _clearPreview() {
    _confirmedPreview = null;
    _confirmedPreviewKey = null;
    _activePreviewKey = null;
    _isPreviewLoading = false;
    _hasPreviewError = false;
  }

  void _publish() {
    if (!ref.mounted) return;
    state = _compose(effects: state.effects);
  }

  CheckoutViewState _compose({
    List<UiEffectEnvelope<CheckoutEffect>> effects = const [],
  }) {
    final cartState = _cartValue;
    final cart = cartState?.value;
    final preview = _confirmedPreview;
    final rawLines = preview?.items == null
        ? (cart?.items ?? const [])
              .where((item) => item.menuItemId is int)
              .map(
                (item) => CheckoutLineViewData(
                  menuItemId: item.menuItemId.toInt(),
                  name: item.menuItemName,
                  quantity: item.quantity,
                  lineTotal: item.totalPrice,
                ),
              )
              .toList(growable: false)
        : preview!.items!
              .where(
                (item) =>
                    item.menuItemId != null &&
                    item.menuItemName != null &&
                    item.quantity != null &&
                    item.lineTotal != null,
              )
              .map(
                (item) => CheckoutLineViewData(
                  menuItemId: item.menuItemId!,
                  name: item.menuItemName!,
                  quantity: item.quantity!,
                  lineTotal: item.lineTotal!,
                ),
              )
              .toList(growable: false);
    final address = _address;
    return CheckoutViewState(
      restaurantName: cart?.currentRestaurantName,
      itemCount: cart?.totalItems ?? 0,
      lines: List<CheckoutLineViewData>.unmodifiable(rawLines),
      isCartLoading: cartState?.isLoading ?? true,
      hasCartError: cartState?.hasError ?? false,
      selectedAddress: address?.id == null
          ? null
          : CheckoutAddressViewData(
              id: address!.id!,
              label: address.label,
              recipientName: address.recipientName,
              phoneNumber: address.phoneNumber,
              fullAddress: address.fullAddress,
              isDefault: address.isDefault,
            ),
      isPreviewLoading: _isPreviewLoading,
      hasPreviewError: _hasPreviewError,
      price: preview == null
          ? null
          : CheckoutPriceViewData(
              subtotal: preview.subtotal!,
              shippingFee: preview.shippingFee!,
              discountAmount: preview.discountAmount!,
              total: preview.totalPrice!,
              itemDiscount: preview.itemDiscount,
              shippingDiscount: preview.shippingDiscount,
              customerShippingFee: preview.customerShippingFee,
              platformSubsidy: preview.platformSubsidy,
              appliedVouchers: (preview.appliedVouchers ?? const [])
                  .where(
                    (item) =>
                        item.code != null &&
                        item.layer != null &&
                        item.discountAmount != null,
                  )
                  .map(
                    (item) => CheckoutAppliedVoucherViewData(
                      code: item.code!,
                      layer: item.layer!,
                      discountAmount: item.discountAmount!,
                    ),
                  )
                  .toList(growable: false),
            ),
      isVoucherAvailable: _isVoucherAvailable,
      isVoucherStackingAvailable: _stackingEnabled,
      isVoucherLoading: _isVoucherLoading,
      hasVoucherError: _hasVoucherError,
      vouchers: _vouchers
          .map(
            (voucher) => CheckoutVoucherViewData(
              id: voucher.id,
              code: voucher.code,
              name: voucher.name,
              displayBenefit: voucher.displayBenefit,
              layer: voucher.layer,
              minimumOrderValue: voucher.minOrderValue,
            ),
          )
          .toList(growable: false),
      selectedVoucherId: _selectedVoucherId,
      selectedVoucherIds: List<int>.unmodifiable(_selectedVoucherIds),
      selectionMode: _selectionMode,
      notes: _notes,
      isPlacingOrder: _isPlacingOrder,
      effects: effects,
    );
  }

  bool get _stackingEnabled =>
      RuntimeConfig.voucherStackingEnabled && _stackingCapabilityEnabled;

  String _previewKey(CheckoutPreviewRequest request) => [
    request.restaurantId,
    request.deliveryLat,
    request.deliveryLng,
    request.voucherId,
    request.selectionMode,
    ...(request.selectedVoucherIds ?? const <int>[]).toList()..sort(),
    for (final item in request.items)
      '${item.menuItemId}:${item.quantity}:${item.flashSaleItemId ?? ''}',
  ].join('|');

  String? _cartSignature(CartEntity? cart) {
    if (cart == null) return null;
    return [
      cart.currentRestaurantId,
      for (final item in cart.items)
        '${item.menuItemId}:${item.quantity}:${item.flashSaleItemId ?? ''}:${item.notes ?? ''}',
    ].join('|');
  }

  void _emit(CheckoutEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
