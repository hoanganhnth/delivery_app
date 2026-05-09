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

                // Discount badge (Mock data for UI)
                Positioned(
                  top: 8.w,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'GIẢM 30%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Favorite button
                Positioned(
                  top: 8.w,
                  right: 8.w,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      iconSize: 20,
                    ),
                  ),
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
                    style: TextStyle(color: ref.colors.textSecondary, fontSize: 14.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: ref.colors.textSecondary),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        restaurant.address,
                        style: TextStyle(color: ref.colors.textSecondary, fontSize: 12.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.orange[700]),
                    SizedBox(width: 2.w),
                    Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '(200+)',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time, size: 14, color: ref.colors.textSecondary),
                    SizedBox(width: 2.w),
                    Text(
                      '20-30 phút',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.delivery_dining,
                      size: 14,
                      color: ref.colors.textSecondary,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      s.restaurantsFreeDelivery,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
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
