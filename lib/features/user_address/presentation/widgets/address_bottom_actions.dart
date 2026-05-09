import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';

class AddressBottomActions extends StatelessWidget {
  final AppColors colors;
  final bool isEditing;
  final bool isDefault;
  final bool isSubmitting;
  final ValueChanged<bool>? onDefaultChanged;
  final VoidCallback onSave;

  const AddressBottomActions({
    super.key,
    required this.colors,
    required this.isEditing,
    required this.isDefault,
    required this.isSubmitting,
    this.onDefaultChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Container(
      padding: EdgeInsets.all(ResponsiveSize.m),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Set default switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đặt làm địa chỉ mặc định',
                  style: TextStyle(
                    fontSize: ResponsiveSize.fontM,
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch.adaptive(
                  value: isDefault,
                  onChanged: onDefaultChanged,
                  activeColor: colors.primary,
                ),
              ],
            ),
            SizedBox(height: ResponsiveSize.m),
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        isEditing ? s.addressSave : s.addressAdd,
                        style: TextStyle(
                          fontSize: ResponsiveSize.fontL,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
