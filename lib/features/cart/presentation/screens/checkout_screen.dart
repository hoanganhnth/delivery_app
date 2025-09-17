import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../orders/domain/entities/order_entity.dart';
import '../../../orders/data/dtos/create_order_request_dto.dart';
import '../../../orders/data/dtos/order_item_dto.dart';
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
  
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;
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
                          _buildSectionHeader(context, 'Thông tin khách hàng', Icons.person),
                          const SizedBox(height: 8),
                          _buildCustomerInfoCard(context),
                          const SizedBox(height: 16),
                          
                          // Delivery Address Section
                          _buildSectionHeader(context, 'Địa chỉ giao hàng', Icons.location_on),
                          const SizedBox(height: 8),
                          _buildDeliveryAddressCard(context),
                          const SizedBox(height: 16),
                          
                          // Payment Method Section
                          _buildSectionHeader(context, 'Phương thức thanh toán', Icons.payment),
                          const SizedBox(height: 8),
                          _buildPaymentMethodCard(context),
                          const SizedBox(height: 16),
                          
                          // Order Items Summary
                          _buildSectionHeader(context, 'Chi tiết đơn hàng', Icons.receipt_long),
                          const SizedBox(height: 8),
                          _buildOrderSummaryCard(context, cartState),
                          const SizedBox(height: 16),
                          
                          // Notes Section
                          _buildSectionHeader(context, 'Ghi chú (không bắt buộc)', Icons.note),
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

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
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
                hintText: 'Nhập địa chỉ chi tiết: số nhà, đường, phường, quận...',
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
                  const SnackBar(content: Text('Tính năng chọn vị trí trên bản đồ sẽ được cập nhật sớm')),
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
              PaymentMethod.cash,
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

  Widget _buildPaymentOption(BuildContext context, PaymentMethod method, String title, String subtitle, IconData icon) {
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

  Widget _buildOrderSummaryCard(BuildContext context, dynamic cartState) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...cartState.cart.items.map((item) => Padding(
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
            )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tạm tính',
                  style: TextStyle(color: context.colors.textSecondary),
                ),
                Text(
                  '${cartState.cart.subtotal.toStringAsFixed(0)}₫',
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
                  '${cartState.cart.deliveryFee.toStringAsFixed(0)}₫',
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
            hintText: 'Ghi chú đặc biệt cho đơn hàng (ví dụ: không cay, giao tận tay...)',
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

    // Store context before any async gaps
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final cartState = ref.read(cartNotifierProvider);
      final createOrderNotifier = ref.read(createOrderProvider.notifier);
      
      // Convert cart items to order item DTOs
      final orderItems = cartState.cart.items
          .map((item) => OrderItemDto(
                id: null, // ID sẽ được tạo bởi server
                menuItemId: item.menuItemId.toInt(),
                menuItemName: item.menuItemName,
                price: item.price,
                quantity: item.quantity,
              ))
          .toList();

      // Calculate total amount
      final totalAmount = cartState.cart.items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

      // Create order request DTO
      final createOrderRequest = CreateOrderRequestDto(
        customerName: _nameController.text.trim(),
        customerPhone: _phoneController.text.trim(),
        deliveryAddress: _addressController.text.trim(),
        paymentMethod: _selectedPaymentMethod.value,
        totalAmount: totalAmount,
        items: orderItems,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      
      // Create order
      final createdOrder = await createOrderNotifier.createOrder(createOrderRequest);

      if (mounted) {
        if (createdOrder != null) {
          scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text('Đặt hàng thành công!'),
              backgroundColor: Colors.green,
            ),
          );

          // Clear cart and navigate
          ref.read(cartNotifierProvider.notifier).clearCart();
          navigator.popUntil((route) => route.isFirst);
        } else {
          // Check for error in AsyncValue
          final asyncState = ref.read(createOrderProvider);
          asyncState.whenOrNull(
            error: (error, stackTrace) {
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  content: Text('Lỗi: ${error.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
        }
      }
    } catch (e) {
      // Use the scaffoldMessenger that was stored before async gap
      if (mounted) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Lỗi không mong muốn: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
