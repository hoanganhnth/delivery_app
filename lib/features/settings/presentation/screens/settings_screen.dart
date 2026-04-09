import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/theme/theme_provider.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';

/// Settings Screen - Editorial style với grouped sections
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _orderUpdates = true;
  bool _promotions = false;
  String _selectedLanguage = 'Tiếng Việt';

  @override
  Widget build(BuildContext context) {
    final colors = ref.colors;
    final isDarkMode = ref.watch(isDarkThemeProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          // Dark Nav AppBar
          SliverAppBar(
            expandedHeight: 120.h,
            pinned: true,
            backgroundColor: colors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Cài đặt',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveSize.fontXl,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colors.primaryDark,
                      colors.primary,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveSize.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notifications Section
                  _buildSectionTitle('Thông báo'),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    children: [
                      _buildSwitchTile(
                        icon: Icons.notifications_outlined,
                        title: 'Thông báo đẩy',
                        subtitle: 'Nhận thông báo từ ứng dụng',
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() => _notificationsEnabled = value);
                        },
                      ),
                      _buildDivider(),
                      _buildSwitchTile(
                        icon: Icons.delivery_dining_outlined,
                        title: 'Cập nhật đơn hàng',
                        subtitle: 'Trạng thái giao hàng real-time',
                        value: _orderUpdates,
                        onChanged: (value) {
                          setState(() => _orderUpdates = value);
                        },
                      ),
                      _buildDivider(),
                      _buildSwitchTile(
                        icon: Icons.local_offer_outlined,
                        title: 'Khuyến mãi',
                        subtitle: 'Ưu đãi và deal hấp dẫn',
                        value: _promotions,
                        onChanged: (value) {
                          setState(() => _promotions = value);
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Appearance Section
                  _buildSectionTitle('Giao diện'),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    children: [
                      _buildSwitchTile(
                        icon: Icons.dark_mode_outlined,
                        title: 'Chế độ tối',
                        subtitle: 'Bảo vệ mắt trong đêm',
                        value: isDarkMode,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                      ),
                      _buildDivider(),
                      _buildNavigationTile(
                        icon: Icons.language_outlined,
                        title: 'Ngôn ngữ',
                        subtitle: _selectedLanguage,
                        onTap: () => _showLanguageSheet(),
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Privacy Section
                  _buildSectionTitle('Quyền riêng tư'),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    children: [
                      _buildNavigationTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Chính sách bảo mật',
                        subtitle: 'Cách chúng tôi bảo vệ dữ liệu',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildNavigationTile(
                        icon: Icons.description_outlined,
                        title: 'Điều khoản sử dụng',
                        subtitle: 'Quy định và điều kiện',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildNavigationTile(
                        icon: Icons.cookie_outlined,
                        title: 'Cookie & Tracking',
                        subtitle: 'Quản lý preferences',
                        onTap: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // About Section
                  _buildSectionTitle('Thông tin'),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    children: [
                      _buildNavigationTile(
                        icon: Icons.info_outline,
                        title: 'Về ứng dụng',
                        subtitle: 'Phiên bản 1.0.0',
                        onTap: () => _showAboutDialog(),
                      ),
                      _buildDivider(),
                      _buildNavigationTile(
                        icon: Icons.star_outline,
                        title: 'Đánh giá ứng dụng',
                        subtitle: 'Chia sẻ trải nghiệm của bạn',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildNavigationTile(
                        icon: Icons.share_outlined,
                        title: 'Chia sẻ ứng dụng',
                        subtitle: 'Giới thiệu bạn bè',
                        onTap: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Danger Zone
                  _buildSectionTitle('Vùng nguy hiểm'),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    borderColor: colors.error.withValues(alpha: 0.3),
                    children: [
                      _buildNavigationTile(
                        icon: Icons.cleaning_services_outlined,
                        title: 'Xóa cache',
                        subtitle: 'Giải phóng bộ nhớ',
                        iconColor: colors.warning,
                        onTap: () => _showClearCacheDialog(),
                      ),
                      _buildDivider(),
                      _buildNavigationTile(
                        icon: Icons.delete_forever_outlined,
                        title: 'Xóa tài khoản',
                        subtitle: 'Xóa vĩnh viễn tất cả dữ liệu',
                        iconColor: colors.error,
                        textColor: colors.error,
                        onTap: () => _showDeleteAccountDialog(),
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.xxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: ResponsiveSize.fontL,
        fontWeight: FontWeight.bold,
        color: ref.colors.textPrimary,
      ),
    );
  }

  Widget _buildSettingsCard({
    required List<Widget> children,
    Color? borderColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ref.colors.cardBackground,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        border: borderColor != null
            ? Border.all(color: borderColor, width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: ref.colors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final colors = ref.colors;
    return Padding(
      padding: EdgeInsets.all(ResponsiveSize.m),
      child: Row(
        children: [
          _buildIconBox(icon, colors.primary),
          SizedBox(width: ResponsiveSize.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveSize.fontM,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: ResponsiveSize.fontS,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: colors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    final colors = ref.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveSize.m),
        child: Row(
          children: [
            _buildIconBox(icon, iconColor ?? colors.primary),
            SizedBox(width: ResponsiveSize.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontM,
                      fontWeight: FontWeight.w600,
                      color: textColor ?? colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontS,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.textSecondary,
              size: 24.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBox(IconData icon, Color color) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
      ),
      child: Icon(icon, color: color, size: 22.w),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.m),
      child: Divider(height: 1, color: ref.colors.divider),
    );
  }

  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ref.colors.cardBackground,
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
                  color: ref.colors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: ResponsiveSize.m),
            Text(
              'Chọn ngôn ngữ',
              style: TextStyle(
                fontSize: ResponsiveSize.fontXl,
                fontWeight: FontWeight.bold,
                color: ref.colors.textPrimary,
              ),
            ),
            SizedBox(height: ResponsiveSize.m),
            _buildLanguageOption('Tiếng Việt', '🇻🇳'),
            _buildLanguageOption('English', '🇺🇸'),
            _buildLanguageOption('日本語', '🇯🇵'),
            SizedBox(height: ResponsiveSize.m),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, String flag) {
    final isSelected = _selectedLanguage == language;
    return ListTile(
      leading: Text(flag, style: TextStyle(fontSize: 24.sp)),
      title: Text(
        language,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: ref.colors.textPrimary,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: ref.colors.primary)
          : null,
      onTap: () {
        setState(() => _selectedLanguage = language);
        Navigator.pop(context);
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AboutDialog(
        applicationName: 'Delivery App',
        applicationVersion: '1.0.0',
        applicationIcon: Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: ref.colors.primary,
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
            'Ứng dụng giao đồ ăn nhanh chóng và tiện lợi.',
            style: TextStyle(color: ref.colors.textSecondary),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa cache?'),
        content: const Text(
          'Điều này sẽ xóa tất cả dữ liệu cache. Bạn có thể cần đăng nhập lại.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xóa cache thành công')),
              );
            },
            child: Text(
              'Xóa',
              style: TextStyle(color: ref.colors.warning),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Xóa tài khoản?',
          style: TextStyle(color: ref.colors.error),
        ),
        content: const Text(
          'Hành động này không thể hoàn tác. Tất cả dữ liệu của bạn sẽ bị xóa vĩnh viễn.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement delete account
            },
            child: Text(
              'Xóa vĩnh viễn',
              style: TextStyle(color: ref.colors.error),
            ),
          ),
        ],
      ),
    );
  }
}
