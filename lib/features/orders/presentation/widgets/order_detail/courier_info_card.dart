import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'courier_photo.dart';
import 'courier_action_button.dart';

/// Courier Info Card - Driver info với photo, rating, và action buttons
class CourierInfoCard extends ConsumerWidget {
  final String courierName;
  final String? courierPhoto;
  final double rating;
  final VoidCallback onCall;
  final VoidCallback onChat;
  
  const CourierInfoCard({
    super.key,
    required this.courierName,
    this.courierPhoto,
    required this.rating,
    required this.onCall,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    
    return Container(
      padding: EdgeInsets.all(ResponsiveSize.m),
      decoration: BoxDecoration(
        color: colors.cardBackground.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusXl),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Courier Photo
          CourierPhoto(colors: colors, courierPhoto: courierPhoto),
          SizedBox(width: ResponsiveSize.m),
          // Courier Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).yourCourier.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: colors.textSecondary,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  courierName,
                  style: TextStyle(
                    fontSize: ResponsiveSize.fontL,
                    fontWeight: FontWeight.w900,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: colors.primary,
                      size: 14.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: ResponsiveSize.fontS,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Action Buttons
          Row(
            children: [
              CourierActionButton(
                colors: colors,
                icon: Icons.chat_bubble_outline,
                onTap: onChat,
                isPrimary: false,
              ),
              SizedBox(width: ResponsiveSize.s),
              CourierActionButton(
                colors: colors,
                icon: Icons.call,
                onTap: onCall,
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
}


