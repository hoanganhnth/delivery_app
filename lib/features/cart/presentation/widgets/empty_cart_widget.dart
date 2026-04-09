import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';

/// Widget displayed when cart is empty
class EmptyCartWidget extends ConsumerWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 120,
              color: ref.colors.textDisabled,
            ),
            SizedBox(height: 24.w),
            Text(
              S.of(context).yourCartIsEmpty,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: ref.colors.textPrimary,
              ),
            ),
            SizedBox(height: 12.w),
            Text(
              S.of(context).addSomeDeliciousItems,
              style: TextStyle(
                fontSize: 16.sp,
                color: ref.colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.w),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/restaurants'),
              icon: Icon(Icons.restaurant_menu),
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
