import 'package:delivery_app/core/presentation/widgets/toast/toast_utils.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_provider.dart' hide Theme;
import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/data/dtos/create_order_request_dto.dart';
import '../../../orders/presentation/providers/orders/create_order_async_notifiers.dart';
import '../../../user_address/presentation/providers/user_address_notifiers.dart';
import '../providers/cart_notifier.dart';
import '../widgets/widgets.dart';

/// Checkout Screen với giao diện đẹp và tạo order
class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final themeColors = ref.watch(themeColorsProvider);
    final textTheme = Theme.of(context).textTheme;
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

    final cart = cartState.cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        backgroundColor: themeColors.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.home);
            }
          },
          icon: Icon(
            Icons.close,
            color: textTheme.bodyLarge?.color,
          ),
        ),
      ),
      backgroundColor: themeColors.background,
      body: cart.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_cart.png',
                    width: 150.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Giỏ hàng của bạn đang trống',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hãy thêm ít nhất một món hàng để tiếp tục.',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go(AppRoutes.home);
                      }
                    },
                    child: const Text('Tiếp tục mua sắm'),
                  ),
                ],
              ),
            )
          : Form(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Restaurant Info Card
                          RestaurantInfoCard(cartState: cartState),
                          SizedBox(height: 16.w),

                          // Delivery Address Section
                          SelectedAddressCard(
                            addressController: TextEditingController(),
                            onAddressSelected: (address) {},
                          ),
                          SizedBox(height: 16.w),

                          // Payment Method Section
                          CheckoutSectionHeader(
                            title: 'Phương thức thanh toán',
                            icon: Icons.payment,
                          ),
                          SizedBox(height: 8.w),
                          PaymentMethodCard(
                            selectedPaymentMethod: PaymentMethod.cod,
                            onPaymentMethodChanged: (method) {},
                          ),
                          SizedBox(height: 16.w),

                          // Order Items Summary
                          CheckoutSectionHeader(
                            title: 'Chi tiết đơn hàng',
                            icon: Icons.receipt_long,
                          ),
                          SizedBox(height: 8.w),
                          OrderSummaryCard(cartState: cartState),
                          SizedBox(height: 16.w),

                          // Notes Section
                          CheckoutSectionHeader(
                            title: 'Ghi chú (không bắt buộc)',
                            icon: Icons.note,
                          ),
                          SizedBox(height: 8.w),
                          NotesCard(notesController: TextEditingController()),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Checkout Section
                  CheckoutBottomSection(
                    cartState: cartState,
                    isLoading: createOrderState.isLoading,
                    onPlaceOrder: () {
                      final addressState = ref.read(userAddressListProvider);
                      final selectedAddress = addressState.defaultAddress;
                      
                      if (selectedAddress != null && cart.currentRestaurantId != null) {
                        final request = CreateOrderRequestDto(
                          restaurantId: cart.currentRestaurantId! as int,
                          restaurantName: cart.currentRestaurantName ?? '',
                          restaurantAddress: '', // TODO: Get from restaurant data
                          restaurantPhone: '', // TODO: Get from restaurant data
                          deliveryAddress: selectedAddress.fullAddress,
                          deliveryLat: selectedAddress.latitude,
                          deliveryLng: selectedAddress.longitude,
                          customerName: selectedAddress.recipientName,
                          customerPhone: selectedAddress.phoneNumber,
                          paymentMethod: 'COD',
                          notes: '',
                          items: cart.items.map((item) => OrderItemRequest(
                            menuItemId: item.menuItemId as int,
                            menuItemName: item.menuItemName,
                            quantity: item.quantity,
                            price: item.price,
                          )).toList(),
                        );
                        ref.read(createOrderProvider.notifier).createOrder(request);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vui lòng chọn địa chỉ giao hàng')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
