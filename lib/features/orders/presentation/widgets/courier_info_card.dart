import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

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
          _buildCourierPhoto(colors),
          SizedBox(width: ResponsiveSize.m),
          // Courier Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR COURIER',
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
              _buildActionButton(
                colors,
                Icons.chat_bubble_outline,
                onChat,
                isPrimary: false,
              ),
              SizedBox(width: ResponsiveSize.s),
              _buildActionButton(
                colors,
                Icons.call,
                onCall,
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildCourierPhoto(AppColors colors) {
    return Stack(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
            color: colors.primary.withValues(alpha: 0.1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
            child: courierPhoto != null && courierPhoto!.isNotEmpty
                ? Image.network(
                    courierPhoto!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, __, ___) => _buildPlaceholder(colors),
                  )
                : _buildPlaceholder(colors),
          ),
        ),
        // Verified badge
        Positioned(
          bottom: -2,
          right: -2,
          child: Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.verified,
              color: Colors.white,
              size: 10.w,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPlaceholder(AppColors colors) {
    return Center(
      child: Icon(
        Icons.person,
        color: colors.primary,
        size: 28.w,
      ),
    );
  }
  
  Widget _buildActionButton(
    AppColors colors,
    IconData icon,
    VoidCallback onTap, {
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: isPrimary ? colors.primary : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isPrimary
                  ? colors.primary.withValues(alpha: 0.3)
                  : colors.shadow.withValues(alpha: 0.1),
              blurRadius: isPrimary ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isPrimary ? Colors.white : colors.primary,
          size: 20.w,
        ),
      ),
    );
  }
}
