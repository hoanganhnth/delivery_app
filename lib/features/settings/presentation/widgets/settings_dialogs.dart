import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';

class SettingsDialogs {
  static void showLanguageSheet(
    BuildContext context,
    AppColors colors,
    String selectedLanguage,
    ValueChanged<String> onLanguageSelected,
  ) {
    final s = S.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveSize.radiusXl),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(ResponsiveSize.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: ResponsiveSize.m),
            Text(
              s.settingsLanguageTitle,
              style: TextStyle(
                fontSize: ResponsiveSize.fontXl,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: ResponsiveSize.m),
            _buildLanguageOption(context, colors, 'Tiếng Việt', '🇻🇳', selectedLanguage, onLanguageSelected),
            _buildLanguageOption(context, colors, 'English', '🇺🇸', selectedLanguage, onLanguageSelected),
            _buildLanguageOption(context, colors, '日本語', '🇯🇵', selectedLanguage, onLanguageSelected),
            SizedBox(height: ResponsiveSize.m),
          ],
        ),
      ),
    );
  }

  static Widget _buildLanguageOption(
    BuildContext context,
    AppColors colors,
    String language,
    String flag,
    String selectedLanguage,
    ValueChanged<String> onLanguageSelected,
  ) {
    final isSelected = selectedLanguage == language;
    return ListTile(
      leading: Text(flag, style: TextStyle(fontSize: 24.sp)),
      title: Text(
        language,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: colors.textPrimary,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: colors.primary)
          : null,
      onTap: () {
        onLanguageSelected(language);
        Navigator.pop(context);
      },
    );
  }

  static void showAboutDialog(BuildContext context, AppColors colors) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (context) => AboutDialog(
        applicationName: s.settingsAboutApp,
        applicationVersion: s.settingsAboutAppDesc,
        applicationIcon: Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
          ),
          child: Icon(
            Icons.delivery_dining,
            color: Colors.white,
            size: 32.w,
          ),
        ),
        children: [
          Text(
            'Ứng dụng giao đồ ăn nhanh chóng và tiện lợi.', // Keep or update to localized
            style: TextStyle(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  static void showClearCacheDialog(BuildContext context, AppColors colors) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.settingsClearCache),
        content: Text(s.settingsClearCacheDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'), // Could be localized
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa cache thành công')), // Could be localized
              );
            },
            child: Text(
              'Xóa', // Could be localized
              style: TextStyle(color: colors.warning),
            ),
          ),
        ],
      ),
    );
  }

  static void showDeleteAccountDialog(BuildContext context, AppColors colors) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          s.settingsDeleteAccount,
          style: TextStyle(color: colors.error),
        ),
        content: Text(s.settingsDeleteAccountDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'), // Could be localized
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement delete account
            },
            child: Text(
              'Xóa vĩnh viễn', // Could be localized
              style: TextStyle(color: colors.error),
            ),
          ),
        ],
      ),
    );
  }
}
