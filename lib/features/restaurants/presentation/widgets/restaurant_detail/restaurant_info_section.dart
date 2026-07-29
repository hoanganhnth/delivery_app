import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';

/// Restaurant info section with address, hours, and promo
class RestaurantInfoSection extends ConsumerWidget {
  final RestaurantEntity restaurant;

  const RestaurantInfoSection({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Container(
        color: ref.colors.surface,
        child: Column(
          children: [
            // Restaurant info card
            Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ref.colors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  // Address row
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: ref.colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: ref.colors.primary,
                          size: 20.w,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          restaurant.address,
                          style: TextStyle(
                            color: ref.colors.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (restaurant.openingHour != null ||
                      restaurant.closingHour != null ||
                      restaurant.isOpen != null) ...[
                    SizedBox(height: 16.w),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: ref.colors.secondary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.access_time,
                            color: ref.colors.secondary,
                            size: 20.w,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          restaurant.openingHour != null &&
                                  restaurant.closingHour != null
                              ? '${restaurant.openingHour} - ${restaurant.closingHour}'
                              : 'Giờ mở cửa chưa được cập nhật',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (restaurant.isOpen != null) ...[
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.w,
                            ),
                            decoration: BoxDecoration(
                              color: restaurant.isOpen!
                                  ? const Color(0xFF22C55E)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              restaurant.isOpen!
                                  ? 'Đang mở cửa'
                                  : 'Đã đóng cửa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
