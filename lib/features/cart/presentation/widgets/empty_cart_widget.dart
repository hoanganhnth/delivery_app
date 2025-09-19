import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';

/// Widget displayed when cart is empty
class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 120,
              color: context.colors.textDisabled,
            ),
            SizedBox(height: 24.w),
            Text(
              S.of(context).yourCartIsEmpty,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
            ),
            SizedBox(height: 12.w),
            Text(
              S.of(context).addSomeDeliciousItems,
              style: TextStyle(
                fontSize: 16.sp,
                color: context.colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.w),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/restaurants'),
              icon: const Icon(Icons.restaurant_menu),
              label: Text(S.of(context).browseRestaurants),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
