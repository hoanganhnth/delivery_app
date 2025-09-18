import 'package:delivery_app/core/presentation/widgets/toast/toast_utils.dart';
import 'package:delivery_app/features/cart/presentation/providers/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/data/dtos/create_order_request_dto.dart';
import '../../../orders/presentation/providers/order_providers.dart';
import '../providers/cart_providers.dart';

/// Checkout Screen với giao diện đẹp và tạo order
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  PaymentMethod _selectedPaymentMethod = PaymentMethod.cod;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Restaurant Info Card
                          _buildRestaurantCard(context, cartState),
                          const SizedBox(height: 16),

                          // Customer Info Section
                          _buildSectionHeader(
                            context,
                            'Thông tin khách hàng',
                            Icons.person,
                          ),
                          const SizedBox(height: 8),
                          _buildCustomerInfoCard(context),
                          const SizedBox(height: 16),

                          // Delivery Address Section
                          _buildSectionHeader(
                            context,
                            'Địa chỉ giao hàng',
                            Icons.location_on,
                          ),
                          const SizedBox(height: 8),
                          _buildDeliveryAddressCard(context),
                          const SizedBox(height: 16),

                          // Payment Method Section
                          _buildSectionHeader(
                            context,
                            'Phương thức thanh toán',
                            Icons.payment,
                          ),
                          const SizedBox(height: 8),
                          _buildPaymentMethodCard(context),
                          const SizedBox(height: 16),

                          // Order Items Summary
                          _buildSectionHeader(
                            context,
                            'Chi tiết đơn hàng',
                            Icons.receipt_long,
                          ),
                          const SizedBox(height: 8),
                          _buildOrderSummaryCard(context, cartState),
                          const SizedBox(height: 16),

                          // Notes Section
                          _buildSectionHeader(
                            context,
                            'Ghi chú (không bắt buộc)',
                            Icons.note,
                          ),
                          const SizedBox(height: 8),
                          _buildNotesCard(context),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Checkout Section
                  _buildCheckoutBottom(context, cartState),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: context.colors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.colors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantCard(BuildContext context, dynamic cartState) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.restaurant,
                color: context.colors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartState.cart.currentRestaurantName ?? 'Nhà hàng',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${cartState.cart.items.length} món • ${cartState.cart.totalItems} sản phẩm',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Họ và tên',
                hintText: 'Nhập họ và tên của bạn',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập họ và tên';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                hintText: 'Nhập số điện thoại của bạn',
                prefixIcon: const Icon(Icons.phone_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập số điện thoại';
                }
                if (value.length < 10) {
                  return 'Số điện thoại không hợp lệ';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddressCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _addressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Địa chỉ giao hàng',
                hintText:
                    'Nhập địa chỉ chi tiết: số nhà, đường, phường, quận...',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Icon(Icons.location_on_outlined),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập địa chỉ giao hàng';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                // TODO: Open map to select location
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Tính năng chọn vị trí trên bản đồ sẽ được cập nhật sớm',
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, color: context.colors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Chọn vị trí trên bản đồ',
                      style: TextStyle(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPaymentOption(
              context,
              PaymentMethod.cod,
              'Tiền mặt (COD)',
              'Thanh toán khi nhận hàng',
              Icons.payments,
            ),
            const Divider(),
            _buildPaymentOption(
              context,
              PaymentMethod.wallet,
              'Thanh toán online',
              'Thẻ tín dụng, ví điện tử...',
              Icons.credit_card,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    PaymentMethod method,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return RadioListTile<PaymentMethod>(
      value: method,
      groupValue: _selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          _selectedPaymentMethod = value!;
        });
      },
      title: Row(
        children: [
          Icon(icon, color: context.colors.primary),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildOrderSummaryCard(BuildContext context, CartState cartState) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...cartState.cart.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: context.colors.textSecondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${item.quantity}x ${item.menuItemName}',
                        style: TextStyle(color: context.colors.textPrimary),
                      ),
                    ),
                    Text(
                      '${(item.price * item.quantity).toStringAsFixed(0)}₫',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tạm tính',
                  style: TextStyle(color: context.colors.textSecondary),
                ),
                Text(
                  '${cartState.cart.totalAmount.toStringAsFixed(0)}₫',
                  style: TextStyle(color: context.colors.textPrimary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phí giao hàng',
                  style: TextStyle(color: context.colors.textSecondary),
                ),
                Text(
                  '${0}₫',
                  style: TextStyle(color: context.colors.textPrimary),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng cộng',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  '${cartState.cart.totalAmount.toStringAsFixed(0)}₫',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          controller: _notesController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText:
                'Ghi chú đặc biệt cho đơn hàng (ví dụ: không cay, giao tận tay...)',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutBottom(BuildContext context, dynamic cartState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng thanh toán',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: context.colors.textPrimary,
                ),
              ),
              Text(
                '${cartState.cart.totalAmount.toStringAsFixed(0)}₫',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : () => _placeOrder(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Đặt hàng',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
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

      // Create order request DTO với đầy đủ thông tin restaurant
      final createOrderRequest = CreateOrderRequestDto(
        restaurantId:
            cartState.cart.currentRestaurantId?.toInt() ??
            1, // Default restaurant ID
        restaurantName: cartState.cart.currentRestaurantName ?? 'Nhà hàng',
        restaurantAddress: 'Địa chỉ nhà hàng', // TODO: Lấy từ restaurant data
        restaurantPhone: '0901234567', // TODO: Lấy từ restaurant data
        deliveryAddress: _addressController.text.trim(),
        deliveryLat: 21.0135, // TODO: Implement location picker
        deliveryLng: 105.8155, // TODO: Implement location picker
        customerName: _nameController.text.trim(),
        customerPhone: _phoneController.text.trim(),
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
