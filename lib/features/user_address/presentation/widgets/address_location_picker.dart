import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:delivery_app/core/services/location/_riverpod/location_service_provider.dart';

class AddressLocationPicker extends ConsumerStatefulWidget {
  final AppColors colors;
  final Function(double lat, double lng, String addressLine, String city) onLocationSelected;

  const AddressLocationPicker({
    super.key,
    required this.colors,
    required this.onLocationSelected,
  });

  @override
  ConsumerState<AddressLocationPicker> createState() => _AddressLocationPickerState();
}

class _AddressLocationPickerState extends ConsumerState<AddressLocationPicker> {
  bool _isLoadingLocation = false;

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);
    
    try {
      final locationService = ref.read(locationServiceProvider);
      final position = await locationService.getCurrentPosition();
      
      if (position != null) {
        final address = await locationService.getAddressFromCoordinates(
          position.latitude,
          position.longitude,
        );
        
        widget.onLocationSelected(
          position.latitude,
          position.longitude,
          address,
          '',
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể lấy vị trí hiện tại: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingLocation = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final colors = widget.colors;
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        border: Border.all(
          color: colors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoadingLocation ? null : _getCurrentLocation,
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          child: Padding(
            padding: EdgeInsets.all(ResponsiveSize.m),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: _isLoadingLocation
                      ? SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                          ),
                        )
                      : Icon(
                          Icons.my_location,
                          color: colors.primary,
                          size: 24.w,
                        ),
                ),
                SizedBox(width: ResponsiveSize.m),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isLoadingLocation 
                            ? s.addressGettingLocation 
                            : s.addressGetCurrentLocation,
                        style: TextStyle(
                          fontSize: ResponsiveSize.fontM,
                          fontWeight: FontWeight.w600,
                          color: colors.primary,
                        ),
                      ),
                      if (!_isLoadingLocation) ...[
                        SizedBox(height: 4.h),
                        Text(
                          s.addressAutoFillLocation,
                          style: TextStyle(
                            fontSize: ResponsiveSize.fontS,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!_isLoadingLocation)
                  Icon(
                    Icons.chevron_right,
                    color: colors.primary,
                    size: 24.w,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
