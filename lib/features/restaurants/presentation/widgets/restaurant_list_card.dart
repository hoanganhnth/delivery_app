import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:delivery_app/generated/l10n.dart';

class RestaurantListCard extends ConsumerWidget {
  final RestaurantEntity restaurant;

  const RestaurantListCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);

    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant image
          Container(
            height: 160.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: restaurant.image != null
                  ? DecorationImage(
                      image: NetworkImage(restaurant.image!),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) {},
                    )
                  : null,
              color: restaurant.image == null ? Colors.grey[300] : null,
            ),
            child: Stack(
              children: [
                if (restaurant.image == null)
                  const Center(
                    child: Icon(Icons.restaurant, size: 60, color: Colors.grey),
                  ),
              ],
            ),
          ),

          // Restaurant info
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 4.w),
                if (restaurant.description != null)
                  Text(
                    restaurant.description!,
                    style: TextStyle(
                      color: ref.colors.textSecondary,
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: ref.colors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        restaurant.address,
                        style: TextStyle(
                          color: ref.colors.textSecondary,
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.w),
                if (restaurant.rating != null ||
                    restaurant.deliveryTime != null ||
                    restaurant.deliveryFee != null)
                  Row(
                    children: [
                      if (restaurant.rating != null) ...[
                        Icon(Icons.star, size: 14, color: Colors.orange[700]),
                        SizedBox(width: 2.w),
                        Text(
                          restaurant.rating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (restaurant.reviewCount != null) ...[
                          SizedBox(width: 4.w),
                          Text(
                            '(${restaurant.reviewCount})',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ],
                      const Spacer(),
                      if (restaurant.deliveryTime != null) ...[
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: ref.colors.textSecondary,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '${restaurant.deliveryTime} phút',
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                      if (restaurant.deliveryFee != null) ...[
                        SizedBox(width: 12.w),
                        Icon(
                          Icons.delivery_dining,
                          size: 14,
                          color: ref.colors.textSecondary,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          restaurant.deliveryFee == 0
                              ? s.restaurantsFreeDelivery
                              : '${restaurant.deliveryFee!.toStringAsFixed(0)}đ',
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
