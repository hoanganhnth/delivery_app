import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../providers/cart_state.dart';

/// Widget tóm tắt đơn hàng trong checkout
class OrderSummaryCard extends StatelessWidget {
  final CartState cartState;

  const OrderSummaryCard({
    super.key,
    required this.cartState,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Order items
            ...cartState.cart.items.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 8.w),
                child: Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: BoxDecoration(
                        color: context.colors.textSecondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
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
            
            // Subtotal
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
            SizedBox(height: 8.w),
            
            // Delivery fee
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
            
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng cộng',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  '${cartState.cart.totalAmount.toStringAsFixed(0)}₫',
                  style: TextStyle(
                    fontSize: 16.sp,
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
}
