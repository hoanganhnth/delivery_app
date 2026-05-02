import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/cart/presentation/widgets/checkout_empty_state.dart';
import 'package:delivery_app/features/cart/presentation/widgets/checkout_section_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/data/dtos/create_order_request_dto.dart';
import '../../../orders/data/dtos/checkout_preview_dto.dart';
import '../../../orders/presentation/providers/orders/create_order_async_notifiers.dart';
import '../../../user_address/presentation/providers/providers.dart';
import '../providers/providers.dart';
import '../providers/checkout_preview_provider.dart';
import '../widgets/widgets.dart';
import '../../domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/presentation/providers/payment_provider.dart';
import 'package:delivery_app/features/cart/data/dtos/payment_order_dto.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import '../../../promotion/presentation/widgets/voucher_bottom_sheet.dart';
import '../../../promotion/presentation/providers/checkout_calculation_notifier.dart';
import '../../../promotion/presentation/providers/selected_vouchers_notifier.dart';
import '../../../promotion/data/dtos/cart_context_request_dto.dart';
import 'payment_webview_screen.dart';

/// Checkout Screen với giao diện Amber Hearth
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cod;
  final TextEditingController _notesController = TextEditingController();
  bool _isLoadingPreview = true;
  bool _previewFailed = false;
  CheckoutPreviewResponse? _preview;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCheckoutPreview());
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
    final selectedAddress = addressState.selectedAddress ?? addressState.defaultAddress;

    setState(() {
      _isLoadingPreview = true;
      _previewFailed = false;
    });

    try {
      final request = CheckoutPreviewRequest(
        restaurantId: cart.currentRestaurantId! as int,
        deliveryLat: selectedAddress?.latitude,
        deliveryLng: selectedAddress?.longitude,
        items: cart.items
            .map((item) => CheckoutPreviewItemRequest(
                  menuItemId: item.menuItemId as int,
                  quantity: item.quantity,
                ))
            .toList(),
      );

      final preview = await ref
          .read(checkoutPreviewProvider.notifier)
          .loadPreview(request);

      if (!mounted) return;

      if (preview != null) {
        setState(() => _preview = preview);

        // Fetch promotions
        final userId = ref.read(profileProvider).user?.id;
        if (userId != null) {
          final req = CartContextRequestDto(
            shopId: cart.currentRestaurantId! as int,
            userId: userId,
            subTotal: preview.subtotal ?? 0,
            shippingFee: preview.shippingFee ?? 0,
          );
          ref.read(checkoutCalculationProvider.notifier).calculate(req);
        }

        // Hiển thị cảnh báo nếu có món hết hàng
        if (preview.unavailableItemIds != null &&
            preview.unavailableItemIds!.isNotEmpty) {
          _showUnavailableItemsDialog(preview.unavailableItemIds!);
        }
      }
    } catch (_) {
      if (mounted) setState(() => _previewFailed = true);
    } finally {
      if (mounted) setState(() => _isLoadingPreview = false);
    }
  }

  void _showUnavailableItemsDialog(List<int> unavailableIds) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24.w),
            SizedBox(width: 8.w),
            const Text('Có món hết hàng'),
          ],
        ),
        content: Text(
          '${unavailableIds.length} món trong giỏ hàng đã hết hàng hoặc không còn khả dụng. '
          'Vui lòng xoá những món này trước khi đặt hàng.',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Đã hiểu'),
          ),
        ],
      ),
    );
  }

  double _calculateLocalDiscount(List<int> selectedIds) {
    final calcState = ref.read(checkoutCalculationProvider).value;
    if (calcState == null) return 0.0;
    
    double totalDiscount = 0.0;
    for (var id in selectedIds) {
      final voucher = calcState.availableVouchers.where((v) => v.id == id).firstOrNull;
      if (voucher != null) {
        if (voucher.rewardType == 'FIXED') {
          totalDiscount += voucher.discountValue;
        } else if (voucher.rewardType == 'PERCENTAGE') {
          totalDiscount += (_preview?.subtotal ?? 0) * voucher.discountValue / 100.0;
        } else if (voucher.rewardType == 'FREESHIP') {
          totalDiscount += (_preview?.shippingFee ?? 0);
        }
      }
    }
    return totalDiscount;
  }

  // Amber Hearth design tokens
  @override
  Widget build(BuildContext context) {
    final cartAsyncValue = ref.watch(cartProvider);
    final createOrderState = ref.watch(createOrderProvider);
    final calculateState = ref.watch(checkoutCalculationProvider);
    final selectedVouchers = ref.watch(selectedVouchersProvider);
    final localDiscount = _calculateLocalDiscount(selectedVouchers);

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
          ToastUtils.showOrderPlacedError(context, message: error.toString());
        },
      );
    });

    return Scaffold(
      backgroundColor: ref.colors.background,
      appBar: GlassAppBar(
        titleText: 'Thanh toán',
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
                  'Error: ${error.toString()}',
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
                if (_isLoadingPreview)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 10.w),
                    color: Colors.amber.shade50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.amber.shade700),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Đang tính toán giá...',
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.amber.shade900),
                        ),
                      ],
                    ),
                  ),
                if (_previewFailed)
                  GestureDetector(
                    onTap: _loadCheckoutPreview,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.w),
                      color: Colors.red.shade50,
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              size: 18.w, color: Colors.red.shade700),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              'Không thể lấy giá từ server. Nhấn để thử lại.',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.red.shade900),
                            ),
                          ),
                          Icon(Icons.refresh,
                              size: 18.w, color: Colors.red.shade700),
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
                          title: 'Địa chỉ giao hàng',
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
                          title: 'Phương thức thanh toán',
                          icon: Icons.payment_outlined,
                        ),
                        SizedBox(height: 8.w),
                        CheckoutSectionCard(
                          child: PaymentMethodCard(
                            selectedPaymentMethod: _selectedPaymentMethod,
                            onPaymentMethodChanged: (method) {
                              setState(() {
                                _selectedPaymentMethod = method;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16.w),

                        // Order Items Summary
                        CheckoutSectionHeader(
                          title: 'Chi tiết đơn hàng',
                          icon: Icons.receipt_long_outlined,
                        ),
                        SizedBox(height: 8.w),
                        CheckoutSectionCard(
                          child: OrderSummaryCard(cart: cart),
                        ),
                        SizedBox(height: 16.w),

                        // Voucher Section
                        CheckoutSectionHeader(
                          title: 'Khuyến mãi / Voucher',
                          icon: Icons.local_offer_outlined,
                        ),
                        SizedBox(height: 8.w),
                        CheckoutSectionCard(
                          child: Consumer(
                            builder: (context, ref, child) {
                              final selectedVouchers = ref.watch(selectedVouchersProvider);
                              
                              String text = 'Chọn hoặc nhập mã';
                              Color textColor = Colors.grey.shade600;
                              
                              if (selectedVouchers.isNotEmpty) {
                                text = 'Đã chọn ${selectedVouchers.length} mã';
                                textColor = Colors.amber.shade700;
                              }
                              
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => const VoucherBottomSheet(),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12.w),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        text,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: selectedVouchers.isNotEmpty ? FontWeight.bold : FontWeight.normal,
                                          color: textColor,
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios, size: 14.w, color: Colors.grey),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16.w),

                        // Notes Section
                        CheckoutSectionHeader(
                          title: 'Ghi chú (không bắt buộc)',
                          icon: Icons.note_outlined,
                        ),
                        SizedBox(height: 8.w),
                        CheckoutSectionCard(
                          child: NotesCard(
                            notesController: _notesController,
                          ),
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
                  isLoading: _isLoadingPreview ||
                      calculateState.isLoading ||
                      createOrderState.isLoading ||
                      ref.watch(paymentProvider).isLoading,
                  buttonText: _isLoadingPreview
                      ? 'Đang tính giá...'
                      : (_selectedPaymentMethod == PaymentMethod.wallet
                          ? 'Thanh toán'
                          : 'Đặt hàng'),
                  onPlaceOrder:
                      _isLoadingPreview ? () {} : () => _placeOrder(cart, selectedVouchers),
                  serverSubtotal: _preview?.subtotal,
                  serverShippingFee: _preview?.shippingFee,
                  serverDiscount: (_preview?.discountAmount ?? 0) + localDiscount,
                  serverTotal: (_preview?.totalPrice ?? 0) - localDiscount,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _placeOrder(CartEntity cart, List<int> voucherIds) async {
    final addressState = ref.read(userAddressListProvider);
    final selectedAddress =
        addressState.selectedAddress ?? addressState.defaultAddress;

    if (selectedAddress == null || cart.currentRestaurantId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn địa chỉ giao hàng'),
          backgroundColor: const Color(0xFFBA1A1A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    // Sử dụng giá từ server preview nếu có, fallback giá local
    final items = _preview?.items != null
        ? _preview!.items!
            .map<OrderItemRequest>(
              (item) => OrderItemRequest(
                menuItemId: item.menuItemId!,
                menuItemName: item.menuItemName ?? '',
                quantity: item.quantity ?? 1,
                price: item.unitPrice ?? 0,
              ),
            )
            .toList()
        : cart.items
            .map<OrderItemRequest>(
              (item) => OrderItemRequest(
                menuItemId: item.menuItemId as int,
                menuItemName: item.menuItemName,
                quantity: item.quantity,
                price: item.price,
              ),
            )
            .toList();

    final request = CreateOrderRequestDto(
      restaurantId: cart.currentRestaurantId! as int,
      restaurantName: _preview?.restaurantName ?? cart.currentRestaurantName ?? '',
      restaurantAddress: 'server-validated', // Server sẽ lấy từ DB
      restaurantPhone: '0000000000', // Server sẽ lấy từ DB
      deliveryAddress: selectedAddress.fullAddress,
      deliveryLat: selectedAddress.latitude,
      deliveryLng: selectedAddress.longitude,
      customerName: selectedAddress.recipientName,
      customerPhone: selectedAddress.phoneNumber,
      paymentMethod:
          _selectedPaymentMethod == PaymentMethod.wallet ? 'ONLINE' : 'COD',
      notes: _notesController.text,
      voucherIds: voucherIds,
      items: items,
    );

    if (_selectedPaymentMethod == PaymentMethod.wallet) {
      // Xử lý luồng thanh toán ONLINE
      try {
        final user = ref.read(profileProvider).user;
        if (user == null) {
          ToastUtils.showOrderPlacedError(context,
              message: 'Lỗi: Không tìm thấy thông tin người dùng.');
          return;
        }

        // Dùng totalPrice từ server preview
        final amount = _preview?.totalPrice ?? cart.totalAmount;

        final paymentDto = CreatePaymentDto(
          entityId: user.id!,
          entityType: 'CUSTOMER',
          amount: amount,
          provider: 'VNPAY',
          purpose: 'ORDER_PAYMENT',
        );

        final paymentOrder =
            await ref.read(paymentProvider.notifier).createPayment(paymentDto);

        if (paymentOrder != null && paymentOrder.paymentUrl != null) {
          if (mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentWebViewScreen(
                  paymentUrl: paymentOrder.paymentUrl!,
                  paymentRef: paymentOrder.paymentRef,
                  cart: cart,
                  orderRequest: request,
                ),
              ),
            );
          }
        } else {
          if (mounted) {
            ToastUtils.showOrderPlacedError(context,
                message: 'Lỗi: Không lấy được URL thanh toán.');
          }
        }
      } catch (e) {
        if (mounted) {
          ToastUtils.showOrderPlacedError(context, message: e.toString());
        }
      }
    } else {
      // COD - Tạo đơn trực tiếp
      ref.read(createOrderProvider.notifier).createOrder(request);
    }
  }
}
