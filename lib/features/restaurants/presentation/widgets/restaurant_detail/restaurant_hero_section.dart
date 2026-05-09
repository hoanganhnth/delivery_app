import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'dart:ui';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Restaurant hero section with image, gradient overlay, and info
class RestaurantHeroSection extends ConsumerWidget {
  final dynamic restaurant;
  
  const RestaurantHeroSection({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: 280.w,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: GlassBackButton(onPressed: () => context.pop()),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 4.w),
          child: GlassActionButton(
            icon: Icons.favorite_border,
            onPressed: () {
              // TODO: Add to favorites
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: GlassActionButton(
            icon: Icons.share_outlined,
            onPressed: () {
              // TODO: Share restaurant
            },
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Restaurant image
            AppImage(
              path: restaurant.image ?? '',
              fit: BoxFit.cover,
              errorWidget: Container(
                color: Colors.grey[200],
                child: Icon(
                  Icons.restaurant,
                  size: 80.w,
                  color: Colors.grey[400],
                ),
              ),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.7),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Restaurant info overlay
            Positioned(
              bottom: 20.w,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant name
                  Text(
                    restaurant.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  
                  if (restaurant.description != null) ...[
                    SizedBox(height: 6.w),
                    Text(
                      restaurant.description!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  SizedBox(height: 12.w),
                  
                  // Rating and delivery info
                  Row(
                    children: [
                      // Rating badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.w,
                        ),
                        decoration: BoxDecoration(
                          color: ref.colors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 14.w,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '4.8',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(width: 8.w),
                      
                      // Reviews
                      Text(
                        '(200+ đánh giá)',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12.sp,
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Delivery time badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14.w,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '20-30 min',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
