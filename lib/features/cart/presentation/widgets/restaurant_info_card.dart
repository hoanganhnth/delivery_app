import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../domain/entities/cart_entity.dart';

/// Widget hiển thị thông tin nhà hàng trong checkout
class RestaurantInfoCard extends ConsumerWidget {
  final CartEntity cart;

  const RestaurantInfoCard({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: ref.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.restaurant,
                color: ref.colors.primary,
                size: 24,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.currentRestaurantName ?? 'Nhà hàng',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ref.colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    '${cart.items.length} món • ${cart.totalItems} sản phẩm',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ref.colors.textSecondary,
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
}