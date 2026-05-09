import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

class CourierPhoto extends StatelessWidget {
  final AppColors colors;
  final String? courierPhoto;

  const CourierPhoto({super.key, required this.colors, this.courierPhoto});

  @override
  Widget build(BuildContext context) {
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
                    errorBuilder: (context, __, ___) => CourierPhotoPlaceholder(colors: colors),
                  )
                : CourierPhotoPlaceholder(colors: colors),
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
}

class CourierPhotoPlaceholder extends StatelessWidget {
  final AppColors colors;

  const CourierPhotoPlaceholder({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        color: colors.primary,
        size: 28.w,
      ),
    );
  }
}
