import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/cart/presentation/widgets/checkout_empty_state.dart';
import 'package:delivery_app/features/cart/presentation/widgets/checkout_section_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/data/dtos/create_order_request_dto.dart';
import '../../../orders/data/dtos/checkout_preview_dto.dart';
import '../../../orders/presentation/providers/orders/create_order_async_notifiers.dart';
import '../../../user_address/presentation/providers/providers.dart';
import '../providers/providers.dart';
import '../providers/checkout_preview_provider.dart';
import '../widgets/widgets.dart';
import '../../domain/entities/cart_entity.dart';

/// Checkout Screen với giao diện Amber Hearth
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadCheckoutPreview();
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  /// Gọi server API checkout-preview để lấy giá canonical
  Future<void> _loadCheckoutPreview() async {
    final cart = ref.read(cartProvider).value;
    if (cart == null || cart.isEmpty) return;

    final addressState = ref.read(userAddressListProvider);
    final selectedAddress =
        addressState.selectedAddress ?? addressState.defaultAddress;
    final restaurantId = _positiveInt(cart.currentRestaurantId);
    final deliveryLat = selectedAddress?.latitude;
    final deliveryLng = selectedAddress?.longitude;
    final previewNotifier = ref.read(checkoutPreviewProvider.notifier);
    if (restaurantId == null ||
        !_isVietnamCoordinate(deliveryLat, deliveryLng) ||
        !_hasValidCartItems(cart)) {
      previewNotifier.reset();
      return;
    }

    try {
      final request = CheckoutPreviewRequest(
        restaurantId: restaurantId,
        deliveryLat: deliveryLat!,
        deliveryLng: deliveryLng!,
        items: cart.items
            .map(
              (item) => CheckoutPreviewItemRequest(
                menuItemId: _positiveInt(item.menuItemId)!,
                quantity: item.quantity,
              ),
            )
            .toList(),
      );

      await previewNotifier.loadPreview(request);
    } catch (_) {
      previewNotifier.reset();
      // Errors are handled by watching the provider state
    }
  }

  void _showUnavailableItemsDialog(List<int> unavailableIds) {
    final s = S.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24.w),
            SizedBox(width: 8.w),
            Text(s.checkoutUnavailableItemsTitle),
          ],
        ),
        content: Text(
          s.checkoutUnavailableItemsDesc(unavailableIds.length),
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(s.checkoutUnderstood),
          ),
        ],
      ),
    );
  }

  // Amber Hearth design tokens
  @override
  Widget build(BuildContext context) {
    final cartAsyncValue = ref.watch(cartProvider);
    final createOrderState = ref.watch(createOrderProvider);
    final previewState = ref.watch(checkoutPreviewProvider);
    final s = S.of(context);

    final previewData = previewState.value;

    // Listen to create order state for success/error
    ref.listen<AsyncValue<OrderEntity?>>(createOrderProvider, (prev, next) {
      next.whenOrNull(
        data: (order) {
          if (order != null) {
            ToastUtils.showOrderPlacedSuccess(context);
            ref.read(cartProvider.notifier).clearCart();
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        error: (error, stackTrace) {
          ToastUtils.showOrderPlacedError(context);
        },
      );
    });

    // Listen to preview state for promotions and warnings
    ref.listen<AsyncValue<CheckoutPreviewResponse?>>(checkoutPreviewProvider, (
      prev,
      next,
    ) {
      next.whenOrNull(
        data: (preview) {
          if (preview != null) {
            // Hiển thị cảnh báo nếu có món hết hàng
            if (preview.unavailableItemIds != null &&
                preview.unavailableItemIds!.isNotEmpty) {
              _showUnavailableItemsDialog(preview.unavailableItemIds!);
            }
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: ref.colors.background,
      appBar: GlassAppBar(
        titleText: s.checkoutTitle,
        leading: GlassActionButton(
          icon: Icons.close,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.home);
            }
          },
        ),
      ),
      body: cartAsyncValue.when(
        loading: () =>
            Center(child: CircularProgressIndicator(color: ref.colors.primary)),
        error: (error, stack) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: const Color(0xFFBA1A1A),
                  size: 64.w,
                ),
                SizedBox(height: 16.w),
                Text(
                  'Không thể tải thông tin thanh toán. Vui lòng thử lại.',
                  style: TextStyle(
                    color: const Color(0xFFBA1A1A),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        data: (cart) {
          if (cart.items.isEmpty) {
            return const CheckoutEmptyState();
          }

          return Form(
            child: Column(
              children: [
                // Banner trạng thái
                if (previewState.isLoading)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.w,
                    ),
                    color: Colors.amber.shade50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.amber.shade700,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          s.checkoutLoadingPrice,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (previewState.hasError)
                  GestureDetector(
                    onTap: _loadCheckoutPreview,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.w,
                      ),
                      color: Colors.red.shade50,
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 18.w,
                            color: Colors.red.shade700,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              s.checkoutErrorPrice,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.refresh,
                            size: 18.w,
                            color: Colors.red.shade700,
                          ),
                        ],
                      ),
                    ),
                  ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Restaurant Info Card
                        CheckoutSectionCard(
                          child: RestaurantInfoCard(cart: cart),
                        ),
                        SizedBox(height: 16.w),

                        // Delivery Address Section
                        CheckoutSectionHeader(
                          title: s.checkoutDeliveryAddress,
                          icon: Icons.location_on_outlined,
                        ),
                        SizedBox(height: 8.w),
                        CheckoutSectionCard(
                          child: SelectedAddressCard(
                            addressController: TextEditingController(),
                            onAddressSelected: (address) {
                              // Khi đổi địa chỉ → load lại preview để tính phí ship mới
                              _loadCheckoutPreview();
                            },
                          ),
                        ),
                        SizedBox(height: 16.w),

                        // Payment Method Section
                        CheckoutSectionHeader(
                          title: s.checkoutPaymentMethodTitle,
                          icon: Icons.payment_outlined,
                        ),
                        SizedBox(height: 8.w),
                        CheckoutSectionCard(child: const PaymentMethodCard()),
                        SizedBox(height: 16.w),

                        // Order Items Summary
                        CheckoutSectionHeader(
                          title: s.checkoutOrderDetailsTitle,
                          icon: Icons.receipt_long_outlined,
                        ),
                        SizedBox(height: 8.w),
                        CheckoutSectionCard(
                          child: OrderSummaryCard(
                            cart: cart,
                            preview: previewData,
                          ),
                        ),
                        SizedBox(height: 16.w),

                        // Notes Section
                        CheckoutSectionHeader(
                          title: s.checkoutNotesTitle,
                          icon: Icons.note_outlined,
                        ),
                        SizedBox(height: 8.w),
                        CheckoutSectionCard(
                          child: NotesCard(notesController: _notesController),
                        ),

                        // Bottom padding
                        SizedBox(height: 24.w),
                      ],
                    ),
                  ),
                ),

                // Bottom Checkout Section — hiển thị giá từ server
                CheckoutBottomSection(
                  cart: cart,
                  isLoading:
                      previewState.isLoading || createOrderState.isLoading,
                  buttonText: previewState.isLoading
                      ? s.checkoutLoadingPrice
                      : s.checkoutOrderBtn,
                  onPlaceOrder: previewData == null
                      ? null
                      : () => _placeOrder(cart),
                  serverSubtotal: previewData?.subtotal,
                  serverShippingFee: previewData?.shippingFee,
                  serverDiscount: previewData?.discountAmount,
                  serverTotal: previewData?.totalPrice,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _placeOrder(CartEntity cart) async {
    final s = S.of(context);
    final addressState = ref.read(userAddressListProvider);
    final selectedAddress =
        addressState.selectedAddress ?? addressState.defaultAddress;
    final restaurantId = _positiveInt(cart.currentRestaurantId);
    final deliveryLat = selectedAddress?.latitude;
    final deliveryLng = selectedAddress?.longitude;

    if (selectedAddress == null ||
        restaurantId == null ||
        !_isVietnamCoordinate(deliveryLat, deliveryLng) ||
        !_hasValidCartItems(cart)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(s.checkoutAddressRequired),
          backgroundColor: const Color(0xFFBA1A1A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    final preview = ref.read(checkoutPreviewProvider).value;
    final previewRequest = CheckoutPreviewRequest(
      restaurantId: restaurantId,
      deliveryLat: deliveryLat!,
      deliveryLng: deliveryLng!,
      items: cart.items
          .map(
            (item) => CheckoutPreviewItemRequest(
              menuItemId: _positiveInt(item.menuItemId)!,
              quantity: item.quantity,
            ),
          )
          .toList(growable: false),
    );
    try {
      preview?.validateFor(previewRequest);
    } on FormatException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giá đơn hàng chưa được xác nhận. Vui lòng thử lại.'),
        ),
      );
      return;
    }
    if (preview == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giá đơn hàng chưa được xác nhận. Vui lòng thử lại.'),
        ),
      );
      return;
    }

    final items = cart.items
        .map<OrderItemRequest>(
          (item) => OrderItemRequest(
            menuItemId: _positiveInt(item.menuItemId)!,
            quantity: item.quantity,
            notes: item.notes,
          ),
        )
        .toList(growable: false);

    final request = CreateOrderRequestDto(
      restaurantId: restaurantId,
      deliveryAddress: selectedAddress.fullAddress,
      deliveryLat: deliveryLat,
      deliveryLng: deliveryLng,
      customerName: selectedAddress.recipientName,
      customerPhone: selectedAddress.phoneNumber,
      paymentMethod: 'COD',
      notes: _notesController.text,
      items: items,
    );

    ref.read(createOrderProvider.notifier).createOrder(request);
  }

  static int? _positiveInt(num? value) {
    return value is int && value > 0 ? value : null;
  }

  static bool _hasValidCartItems(CartEntity cart) {
    return cart.items.isNotEmpty &&
        cart.items.every(
          (item) => _positiveInt(item.menuItemId) != null && item.quantity > 0,
        );
  }

  static bool _isVietnamCoordinate(double? latitude, double? longitude) {
    return latitude != null &&
        longitude != null &&
        latitude.isFinite &&
        longitude.isFinite &&
        latitude >= 8.0 &&
        latitude <= 24.0 &&
        longitude >= 102.0 &&
        longitude <= 110.0;
  }
}
