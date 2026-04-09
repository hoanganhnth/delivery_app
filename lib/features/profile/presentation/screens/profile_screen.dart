import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/features/auth/presentation/widgets/biometric_settings_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/profile/presentation/providers/providers.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Profile Screen - Editorial style with Dark Nav
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final colors = ref.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          // Dark Nav AppBar với gradient
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: colors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colors.primaryDark,
                      colors.primary,
                      colors.primaryLight.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar với border và shadow
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 48.r,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          child: profileState.hasUser
                              ? Text(
                                  profileState.user!.email
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 48.r,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(height: ResponsiveSize.m),
                      // Tên người dùng
                      if (profileState.hasUser) ...[
                        Text(
                          profileState.user!.fullName ?? 'User',
                          style: TextStyle(
                            fontSize: ResponsiveSize.fontXl,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: ResponsiveSize.xs),
                        Text(
                          profileState.user!.email,
                          style: TextStyle(
                            fontSize: ResponsiveSize.fontM,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
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
                  // Quick Actions
                  _buildSectionTitle(context, ref, 'Tài khoản'),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    context, ref,
                    children: [
                      _buildSettingsTile(
                        context,
                        ref,
                        icon: Icons.person_outline,
                        title: 'Chỉnh sửa hồ sơ',
                        subtitle: 'Cập nhật thông tin cá nhân',
                        onTap: () {},
                      ),
                      _buildDivider(context, ref),
                      _buildSettingsTile(
                        context,
                        ref,
                        icon: Icons.location_on_outlined,
                        title: 'Địa chỉ của tôi',
                        subtitle: 'Quản lý địa chỉ giao hàng',
                        onTap: () => context.push('/address-list'),
                      ),
                      _buildDivider(context, ref),
                      _buildSettingsTile(
                        context,
                        ref,
                        icon: Icons.payment_outlined,
                        title: 'Phương thức thanh toán',
                        subtitle: 'Thêm hoặc xóa thẻ',
                        onTap: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Security Section
                  _buildSectionTitle(context, ref, 'Bảo mật'),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    context, ref,
                    children: [
                      _buildSettingsTile(
                        context,
                        ref,
                        icon: Icons.lock_outline,
                        title: 'Đổi mật khẩu',
                        subtitle: 'Cập nhật mật khẩu định kỳ',
                        onTap: () {},
                      ),
                      _buildDivider(context, ref),
                      // Biometric settings
                      const BiometricSettingsWidget(),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Support Section
                  _buildSectionTitle(context, ref, 'Hỗ trợ'),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    context, ref,
                    children: [
                      _buildSettingsTile(
                        context,
                        ref,
                        icon: Icons.support_agent_outlined,
                        title: 'Hỗ trợ khách hàng',
                        subtitle: 'Chat với CSKH 24/7',
                        onTap: () => context.go('/support-chat'),
                      ),
                      _buildDivider(context, ref),
                      _buildSettingsTile(
                        context,
                        ref,
                        icon: Icons.help_outline,
                        title: 'Trợ giúp & FAQ',
                        subtitle: 'Câu hỏi thường gặp',
                        onTap: () {},
                      ),
                      _buildDivider(context, ref),
                      _buildSettingsTile(
                        context,
                        ref,
                        icon: Icons.policy_outlined,
                        title: 'Điều khoản & Chính sách',
                        subtitle: 'Quy định sử dụng',
                        onTap: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final authNotifier = ref.read(authProvider.notifier);
                        await authNotifier.logout();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveSize.m,
                        ),
                        side: BorderSide(color: colors.error),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ResponsiveSize.radiusL),
                        ),
                      ),
                      icon: Icon(Icons.logout, color: colors.error),
                      label: Text(
                        'Đăng xuất',
                        style: TextStyle(
                          color: colors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: ResponsiveSize.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, WidgetRef ref, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: ResponsiveSize.fontL,
        fontWeight: FontWeight.bold,
        color: ref.colors.textPrimary,
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, WidgetRef ref,
      {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: ref.colors.cardBackground,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
        boxShadow: [
          BoxShadow(
            color: ref.colors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    final colors = ref.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveSize.m),
        child: Row(
          children: [
            // Icon với background
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
              ),
              child: Icon(
                icon,
                color: colors.primary,
                size: 22.w,
              ),
            ),
            SizedBox(width: ResponsiveSize.m),
            // Title & Subtitle
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
            // Trailing
            trailing ??
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

  Widget _buildDivider(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.m),
      child: Divider(
        height: 1,
        color: ref.colors.divider,
      ),
    );
  }
}
