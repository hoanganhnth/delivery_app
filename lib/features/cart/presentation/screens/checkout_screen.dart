import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/cart/presentation/widgets/checkout_empty_state.dart';
import 'package:delivery_app/features/cart/presentation/widgets/checkout_section_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/data/dtos/create_order_request_dto.dart';
import '../../../orders/presentation/providers/orders/create_order_async_notifiers.dart';
import '../../../user_address/presentation/providers/providers.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../../domain/entities/cart_entity.dart';
import 'package:delivery_app/features/cart/presentation/providers/payment_provider.dart';
import 'package:delivery_app/features/cart/data/dtos/payment_order_dto.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
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

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  // Amber Hearth design tokens
  @override
  Widget build(BuildContext context) {
    final cartAsyncValue = ref.watch(cartProvider);
    final createOrderState = ref.watch(createOrderProvider);

    // Listen to create order state for success/error
    ref.listen<AsyncValue<OrderEntity?>>(createOrderProvider, (prev, next) {
      next.whenOrNull(
        data: (order) {
          if (order != null) {
            // Thành công - hiển thị thông báo và navigate
            ToastUtils.showOrderPlacedSuccess(context);

            // Clear cart và navigate về home
            ref.read(cartProvider.notifier).clearCart();
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        error: (error, stackTrace) {
          // Lỗi - hiển thị thông báo lỗi
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
                            onAddressSelected: (address) {},
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

                // Bottom Checkout Section
                CheckoutBottomSection(
                  cart: cart,
                  isLoading: createOrderState.isLoading || ref.watch(paymentProvider).isLoading,
                  buttonText: _selectedPaymentMethod == PaymentMethod.wallet ? 'Thanh toán' : 'Đặt hàng',
                  onPlaceOrder: () => _placeOrder(cart),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _placeOrder(CartEntity cart) async {
    final addressState = ref.read(userAddressListProvider);
    final selectedAddress = addressState.selectedAddress ?? addressState.defaultAddress;

    if (selectedAddress != null && cart.currentRestaurantId != null) {
      final request = CreateOrderRequestDto(
        restaurantId: cart.currentRestaurantId! as int,
        restaurantName: cart.currentRestaurantName ?? '',
        restaurantAddress: 'tesst thoi', // TODO: Get from restaurant data
        restaurantPhone: '0099999999', // TODO: Get from restaurant data
        deliveryAddress: selectedAddress.fullAddress,
        deliveryLat: selectedAddress.latitude,
        deliveryLng: selectedAddress.longitude,
        customerName: selectedAddress.recipientName,
        customerPhone: selectedAddress.phoneNumber,
        paymentMethod: _selectedPaymentMethod == PaymentMethod.wallet ? 'ONLINE' : 'COD',
        notes: _notesController.text,
        items: cart.items
            .map<OrderItemRequest>(
              (item) => OrderItemRequest(
                menuItemId: item.menuItemId as int,
                menuItemName: item.menuItemName,
                quantity: item.quantity,
                price: item.price,
              ),
            )
            .toList(),
      );

      if (_selectedPaymentMethod == PaymentMethod.wallet) {
        // Xử lý luồng thanh toán ONLINE
        try {
          final user = ref.read(profileProvider).user;
          if (user == null) {
            ToastUtils.showOrderPlacedError(context, message: 'Lỗi: Không tìm thấy thông tin người dùng.');
            return;
          }

          final paymentDto = CreatePaymentDto(
            entityId: user.id!,
            entityType: 'CUSTOMER',
            amount: cart.totalAmount,
            provider: 'VNPAY', // Cố định VNPay cho luồng này (hoặc có thể FAKE)
            purpose: 'ORDER_PAYMENT',
          );

          final paymentOrder = await ref.read(paymentProvider.notifier).createPayment(paymentDto);
          
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
             if (mounted) ToastUtils.showOrderPlacedError(context, message: 'Lỗi: Không lấy được URL thanh toán.');
          }
        } catch (e) {
          if (mounted) ToastUtils.showOrderPlacedError(context, message: e.toString());
        }
      } else {
        // COD - Tạo đơn trực tiếp
        ref.read(createOrderProvider.notifier).createOrder(request);
      }
    } else {
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
    }
  }
}
