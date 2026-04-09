import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

/// GPS Location Card - Hiển thị vị trí GPS và button "Lấy vị trí"
class GPSLocationCard extends ConsumerWidget {
  final double? latitude;
  final double? longitude;
  final bool isLoading;
  final VoidCallback onGetLocation;

  const GPSLocationCard({
    super.key,
    this.latitude,
    this.longitude,
    this.isLoading = false,
    required this.onGetLocation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;

    return Container(
      padding: EdgeInsets.all(ResponsiveSize.m),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        border: Border.all(color: colors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.my_location,
                color: colors.primary,
                size: 20.w,
              ),
              SizedBox(width: ResponsiveSize.s),
              Text(
                'Vị trí GPS',
                style: TextStyle(
                  fontSize: ResponsiveSize.fontM,
                  fontWeight: FontWeight.w600,
                  color: colors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveSize.s),
          if (latitude != null && longitude != null) ...[
            Text(
              'Lat: ${latitude!.toStringAsFixed(6)}, Lng: ${longitude!.toStringAsFixed(6)}',
              style: TextStyle(
                fontSize: ResponsiveSize.fontS,
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: ResponsiveSize.s),
          ],
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isLoading ? null : onGetLocation,
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.primary,
                side: BorderSide(color: colors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
                ),
                padding: EdgeInsets.symmetric(vertical: ResponsiveSize.s),
              ),
              icon: isLoading
                  ? SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(colors.primary),
                      ),
                    )
                  : Icon(Icons.gps_fixed, size: 18.w),
              label: Text(
                isLoading ? 'Đang lấy vị trí...' : 'Lấy vị trí hiện tại',
                style: TextStyle(
                  fontSize: ResponsiveSize.fontM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
