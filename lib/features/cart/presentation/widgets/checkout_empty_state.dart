import 'package:delivery_app/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Empty state widget for checkout when cart is empty
class CheckoutEmptyState extends ConsumerWidget {  
  const CheckoutEmptyState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: ref.colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 64.w,
                color: ref.colors.primary,
              ),
            ),
            SizedBox(height: 24.w),
            Text(
              'Giỏ hàng trống',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: ref.colors.textPrimary,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              'Hãy thêm ít nhất một món hàng để tiếp tục.',
              style: TextStyle(
                fontSize: 14.sp,
                color: ref.colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.w),
            ElevatedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutes.home);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ref.colors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 32.w,
                  vertical: 16.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: ref.colors.primary.withValues(alpha: 0.3),
              ),
              child: Text(
                'Tiếp tục mua sắm',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
