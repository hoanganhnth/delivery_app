import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../cart/domain/entities/cart_entity.dart';

/// Widget phần thanh toán ở cuối trang checkout
class CheckoutBottomSection extends ConsumerWidget {
  final CartEntity cart;
  final bool isLoading;
  final VoidCallback onPlaceOrder;
  final String buttonText;

  const CheckoutBottomSection({
    super.key,
    required this.cart,
    required this.isLoading,
    required this.onPlaceOrder,
    this.buttonText = 'Đặt hàng',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ref.colors.surface,
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: ref.colors.textPrimary,
                ),
              ),
              Text(
                '${cart.totalAmount.toStringAsFixed(0)}₫',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: ref.colors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onPlaceOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: ref.colors.primary,
                foregroundColor: ref.colors.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20.w,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
