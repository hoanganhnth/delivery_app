import 'package:delivery_app/features/restaurants/domain/entities/restaurant_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class FeaturedRestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurant;
  
  const FeaturedRestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant image
          Container(
            height: 100.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: NetworkImage(restaurant.image ?? ''),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {},
              ),
            ),
            child: restaurant.image == null 
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const Center(
                    child: Icon(Icons.restaurant, size: 40, color: Colors.grey),
                  ),
                )
              : null,
          ),
          
          // Restaurant info
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    children: [
                      Icon(Icons.star, size: 12, color: Colors.orange[700]),
                      SizedBox(width: 2.w),
                      Text('4.5', style: TextStyle(fontSize: 10.sp)),
                      SizedBox(width: 8.w),
                      Text('20-30 phút', style: TextStyle(fontSize: 10.sp)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
