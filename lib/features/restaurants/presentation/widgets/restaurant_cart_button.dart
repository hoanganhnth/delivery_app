import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Floating cart button for restaurant detail screen
class RestaurantCartButton extends StatelessWidget {
  final bool isCartEmpty;
  final int cartItemsCount;
  final double cartTotalAmount;  
  const RestaurantCartButton({
    super.key,
    required this.isCartEmpty,
    required this.cartItemsCount,
    required this.cartTotalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom > 0
            ? MediaQuery.of(context).padding.bottom
            : 16.w,
        left: 16.w,
        right: 16.w,
        top: 12.w,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: isCartEmpty ? null : () => context.push('/cart'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isCartEmpty ? Colors.grey[300] : context.colors.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[300],
            disabledForegroundColor: Colors.grey[500],
            padding: EdgeInsets.symmetric(vertical: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: isCartEmpty ? 0 : 4,
            shadowColor: context.colors.primary.withValues(alpha: 0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 20.w,
              ),
              SizedBox(width: 8.w),
              Text(
                isCartEmpty
                    ? 'Chưa có món trong giỏ'
                    : 'Xem giỏ hàng ($cartItemsCount)',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (!isCartEmpty) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${cartTotalAmount.toStringAsFixed(0)}đ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
