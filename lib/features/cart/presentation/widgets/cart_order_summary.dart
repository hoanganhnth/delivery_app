import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Order summary card showing subtotal, delivery fee, and total
class CartOrderSummary extends ConsumerWidget {
  final double subtotal;
  final double deliveryFee;
  
  const CartOrderSummary({
    super.key,
    required this.subtotal,
    this.deliveryFee = 15000.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = subtotal + deliveryFee;

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ref.colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tổng đơn hàng',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: ref.colors.textPrimary,
            ),
          ),
          SizedBox(height: 16.w),
          
          // Subtotal row
          _SummaryRow(
            label: 'Tạm tính',
            value: '${subtotal.toStringAsFixed(0)}đ',
          ),
          SizedBox(height: 12.w),
          
          // Delivery fee row
          _SummaryRow(
            label: 'Phí giao hàng',
            value: '${deliveryFee.toStringAsFixed(0)}đ',
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: Divider(
              color: Colors.grey[200],
              thickness: 1,
            ),
          ),
          
          // Total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cộng',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: ref.colors.textPrimary,
                ),
              ),
              Text(
                '${total.toStringAsFixed(0)}đ',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: ref.colors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends ConsumerWidget {
  final String label;
  final String value;

  const _SummaryRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: ref.colors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: ref.colors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
