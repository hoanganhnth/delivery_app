import 'package:delivery_app/core/presentation/widgets/toast/toast_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/data/dtos/create_order_request_dto.dart';
import '../../../orders/presentation/providers/orders/order_providers.dart';
import '../../../user_address/domain/entities/user_address_entity.dart';
import '../providers/cart_providers.dart';
import '../widgets/widgets.dart';

/// Checkout Screen với giao diện đẹp và tạo order
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  PaymentMethod _selectedPaymentMethod = PaymentMethod.cod;
  bool _isLoading = false;
  UserAddressEntity? _selectedAddress;

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartNotifierProvider);

    // Listen cho state changes của createOrder để xử lý navigation và thông báo
    ref.listen<AsyncValue<OrderEntity?>>(createOrderProvider, (prev, next) {
      next.whenOrNull(
        data: (order) {
          if (order != null) {
            // Thành công - hiển thị thông báo và navigate
            ToastUtils.showOrderPlacedSuccess(context);

            // Clear cart và navigate về home
            ref.read(cartNotifierProvider.notifier).clearCart();
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
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Text(
          'Thanh toán',
          style: TextStyle(
            color: context.colors.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
        elevation: 0,
      ),
      body: cartState.isEmpty
          ? const Center(child: Text('Giỏ hàng trống'))
          : Form(
              key: _formKey,
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
                            addressController: _addressController,
                            onAddressSelected: (address) {
                              setState(() {
                                _selectedAddress = address;
                              });
                            },
                          ),
                          SizedBox(height: 16.w),

                          // Payment Method Section
                          CheckoutSectionHeader(
                            title: 'Phương thức thanh toán',
                            icon: Icons.payment,
                          ),
                          SizedBox(height: 8.w),
                          PaymentMethodCard(
                            selectedPaymentMethod: _selectedPaymentMethod,
                            onPaymentMethodChanged: (method) {
                              setState(() {
                                _selectedPaymentMethod = method;
                              });
                            },
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
                          NotesCard(notesController: _notesController),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Checkout Section
                  CheckoutBottomSection(
                    cartState: cartState,
                    isLoading: _isLoading,
                    onPlaceOrder: () => _placeOrder(context),
                  ),
                ],
              ),
            ),
    );
  }

  void _placeOrder(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Kiểm tra địa chỉ giao hàng
    if (_selectedAddress == null) {
      ToastUtils.showOrderPlacedError(context, 
        message: 'Vui lòng chọn địa chỉ giao hàng');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final cartState = ref.read(cartNotifierProvider);
      final createOrderNotifier = ref.read(createOrderProvider.notifier);

      // Convert cart items to order item requests
      final orderItems = cartState.cart.items
          .map(
            (item) => OrderItemRequest(
              menuItemId: item.menuItemId.toInt(),
              menuItemName: item.menuItemName,
              price: item.price,
              quantity: item.quantity,
            ),
          )
          .toList();

      // Create order request DTO với đầy đủ thông tin restaurant và address
      final createOrderRequest = CreateOrderRequestDto(
        restaurantId:
            cartState.cart.currentRestaurantId?.toInt() ??
            1, // Default restaurant ID
        restaurantName: cartState.cart.currentRestaurantName ?? 'Nhà hàng',
        restaurantAddress: 'Địa chỉ nhà hàng', // TODO: Lấy từ restaurant data
        restaurantPhone: '0901234567', // TODO: Lấy từ restaurant data
        deliveryAddress: _addressController.text.trim(),
        deliveryLat: _selectedAddress!.latitude ?? 21.0135,
        deliveryLng: _selectedAddress!.longitude ?? 105.8155,
        customerName: _selectedAddress!.recipientName,
        customerPhone: _selectedAddress!.phoneNumber,
        paymentMethod: _selectedPaymentMethod.value,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        pickupLat: 21.0270, // TODO: Get from restaurant
        pickupLng: 105.8085, // TODO: Get from restaurant
        items: orderItems,
      );

      // Create order - state changes sẽ được xử lý bởi listener ở build method
      await createOrderNotifier.createOrder(createOrderRequest);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
