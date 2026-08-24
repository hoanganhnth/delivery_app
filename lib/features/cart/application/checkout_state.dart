import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:equatable/equatable.dart';

import 'checkout_effect.dart';

final class CheckoutLineViewData extends Equatable {
  const CheckoutLineViewData({
    required this.menuItemId,
    required this.name,
    required this.quantity,
    required this.lineTotal,
  });

  final int menuItemId;
  final String name;
  final int quantity;
  final double lineTotal;

  @override
  List<Object?> get props => [menuItemId, name, quantity, lineTotal];
}

final class CheckoutAddressViewData extends Equatable {
  const CheckoutAddressViewData({
    required this.id,
    required this.label,
    required this.recipientName,
    required this.phoneNumber,
    required this.fullAddress,
    required this.isDefault,
  });

  final int id;
  final String label;
  final String recipientName;
  final String phoneNumber;
  final String fullAddress;
  final bool isDefault;

  @override
  List<Object?> get props => [
    id,
    label,
    recipientName,
    phoneNumber,
    fullAddress,
    isDefault,
  ];
}

final class CheckoutVoucherViewData extends Equatable {
  const CheckoutVoucherViewData({
    required this.id,
    required this.code,
    required this.name,
    required this.displayBenefit,
    required this.layer,
    this.minimumOrderValue,
  });

  final int id;
  final String code;
  final String name;
  final String displayBenefit;
  final String layer;
  final double? minimumOrderValue;

  @override
  List<Object?> get props => [
    id,
    code,
    name,
    displayBenefit,
    minimumOrderValue,
    layer,
  ];
}

final class CheckoutPriceViewData extends Equatable {
  const CheckoutPriceViewData({
    required this.subtotal,
    required this.shippingFee,
    required this.discountAmount,
    required this.total,
    this.itemDiscount,
    this.shippingDiscount,
    this.customerShippingFee,
    this.platformSubsidy,
    this.appliedVouchers = const <CheckoutAppliedVoucherViewData>[],
  });

  final double subtotal;
  final double shippingFee;
  final double discountAmount;
  final double total;
  final double? itemDiscount;
  final double? shippingDiscount;
  final double? customerShippingFee;
  final double? platformSubsidy;
  final List<CheckoutAppliedVoucherViewData> appliedVouchers;

  @override
  List<Object?> get props => [
    subtotal,
    shippingFee,
    discountAmount,
    total,
    itemDiscount,
    shippingDiscount,
    customerShippingFee,
    platformSubsidy,
    appliedVouchers,
  ];
}

final class CheckoutAppliedVoucherViewData extends Equatable {
  const CheckoutAppliedVoucherViewData({
    required this.code,
    required this.layer,
    required this.discountAmount,
  });

  final String code;
  final String layer;
  final double discountAmount;

  @override
  List<Object?> get props => [code, layer, discountAmount];
}

final class CheckoutViewState extends Equatable {
  const CheckoutViewState({
    this.restaurantName,
    this.itemCount = 0,
    this.lines = const <CheckoutLineViewData>[],
    this.isCartLoading = true,
    this.hasCartError = false,
    this.selectedAddress,
    this.isPreviewLoading = false,
    this.hasPreviewError = false,
    this.price,
    this.isVoucherAvailable = false,
    this.isVoucherStackingAvailable = false,
    this.isVoucherLoading = false,
    this.hasVoucherError = false,
    this.vouchers = const <CheckoutVoucherViewData>[],
    this.selectedVoucherId,
    this.selectedVoucherIds = const <int>[],
    this.selectionMode = 'AUTO',
    this.notes = '',
    this.isPlacingOrder = false,
    this.effects = const <UiEffectEnvelope<CheckoutEffect>>[],
  });

  final String? restaurantName;
  final int itemCount;
  final List<CheckoutLineViewData> lines;
  final bool isCartLoading;
  final bool hasCartError;
  final CheckoutAddressViewData? selectedAddress;
  final bool isPreviewLoading;
  final bool hasPreviewError;
  final CheckoutPriceViewData? price;
  final bool isVoucherAvailable;
  final bool isVoucherStackingAvailable;
  final bool isVoucherLoading;
  final bool hasVoucherError;
  final List<CheckoutVoucherViewData> vouchers;
  final int? selectedVoucherId;
  final List<int> selectedVoucherIds;
  final String selectionMode;
  final String notes;
  final bool isPlacingOrder;
  final List<UiEffectEnvelope<CheckoutEffect>> effects;

  bool get isEmpty => !isCartLoading && !hasCartError && lines.isEmpty;
  bool get canPlaceOrder =>
      price != null &&
      !isPreviewLoading &&
      !isPlacingOrder &&
      !hasCartError &&
      (selectionMode != 'MANUAL' || selectedVoucherIds.isNotEmpty) &&
      !isEmpty;

  CheckoutViewState copyWith({
    String? restaurantName,
    bool clearRestaurantName = false,
    int? itemCount,
    List<CheckoutLineViewData>? lines,
    bool? isCartLoading,
    bool? hasCartError,
    CheckoutAddressViewData? selectedAddress,
    bool clearSelectedAddress = false,
    bool? isPreviewLoading,
    bool? hasPreviewError,
    CheckoutPriceViewData? price,
    bool clearPrice = false,
    bool? isVoucherAvailable,
    bool? isVoucherStackingAvailable,
    bool? isVoucherLoading,
    bool? hasVoucherError,
    List<CheckoutVoucherViewData>? vouchers,
    int? selectedVoucherId,
    bool clearSelectedVoucher = false,
    List<int>? selectedVoucherIds,
    String? selectionMode,
    String? notes,
    bool? isPlacingOrder,
    List<UiEffectEnvelope<CheckoutEffect>>? effects,
  }) {
    return CheckoutViewState(
      restaurantName: clearRestaurantName
          ? null
          : (restaurantName ?? this.restaurantName),
      itemCount: itemCount ?? this.itemCount,
      lines: lines ?? this.lines,
      isCartLoading: isCartLoading ?? this.isCartLoading,
      hasCartError: hasCartError ?? this.hasCartError,
      selectedAddress: clearSelectedAddress
          ? null
          : (selectedAddress ?? this.selectedAddress),
      isPreviewLoading: isPreviewLoading ?? this.isPreviewLoading,
      hasPreviewError: hasPreviewError ?? this.hasPreviewError,
      price: clearPrice ? null : (price ?? this.price),
      isVoucherAvailable: isVoucherAvailable ?? this.isVoucherAvailable,
      isVoucherStackingAvailable:
          isVoucherStackingAvailable ?? this.isVoucherStackingAvailable,
      isVoucherLoading: isVoucherLoading ?? this.isVoucherLoading,
      hasVoucherError: hasVoucherError ?? this.hasVoucherError,
      vouchers: vouchers ?? this.vouchers,
      selectedVoucherId: clearSelectedVoucher
          ? null
          : (selectedVoucherId ?? this.selectedVoucherId),
      selectedVoucherIds: selectedVoucherIds ?? this.selectedVoucherIds,
      selectionMode: selectionMode ?? this.selectionMode,
      notes: notes ?? this.notes,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    restaurantName,
    itemCount,
    lines,
    isCartLoading,
    hasCartError,
    selectedAddress,
    isPreviewLoading,
    hasPreviewError,
    price,
    isVoucherAvailable,
    isVoucherStackingAvailable,
    isVoucherLoading,
    hasVoucherError,
    vouchers,
    selectedVoucherId,
    selectedVoucherIds,
    selectionMode,
    notes,
    isPlacingOrder,
    effects,
  ];
}
