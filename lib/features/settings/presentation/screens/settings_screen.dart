import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/theme/theme_provider.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../widgets/settings_switch_tile.dart';
import '../widgets/settings_navigation_tile.dart';
import '../widgets/settings_dialogs.dart';

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
    final s = S.of(context);

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
                s.settingsTitle,
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
                  _buildSectionTitle(s.settingsNotifications),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    children: [
                      SettingsSwitchTile(
                        icon: Icons.notifications_outlined,
                        title: s.settingsPushNotifications,
                        subtitle: s.settingsPushNotificationsDesc,
                        value: _notificationsEnabled,
                        onChanged: (value) => setState(() => _notificationsEnabled = value),
                        colors: colors,
                      ),
                      _buildDivider(),
                      SettingsSwitchTile(
                        icon: Icons.delivery_dining_outlined,
                        title: s.settingsOrderUpdates,
                        subtitle: s.settingsOrderUpdatesDesc,
                        value: _orderUpdates,
                        onChanged: (value) => setState(() => _orderUpdates = value),
                        colors: colors,
                      ),
                      _buildDivider(),
                      SettingsSwitchTile(
                        icon: Icons.local_offer_outlined,
                        title: s.settingsPromotions,
                        subtitle: s.settingsPromotionsDesc,
                        value: _promotions,
                        onChanged: (value) => setState(() => _promotions = value),
                        colors: colors,
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Appearance Section
                  _buildSectionTitle(s.settingsAppearance),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    children: [
                      SettingsSwitchTile(
                        icon: Icons.dark_mode_outlined,
                        title: s.settingsDarkMode,
                        subtitle: s.settingsDarkModeDesc,
                        value: isDarkMode,
                        onChanged: (_) => ref.read(themeProvider.notifier).toggleTheme(),
                        colors: colors,
                      ),
                      _buildDivider(),
                      SettingsNavigationTile(
                        icon: Icons.language_outlined,
                        title: s.settingsLanguage,
                        subtitle: _selectedLanguage,
                        onTap: () => SettingsDialogs.showLanguageSheet(
                          context,
                          colors,
                          _selectedLanguage,
                          (lang) => setState(() => _selectedLanguage = lang),
                        ),
                        colors: colors,
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Privacy Section
                  _buildSectionTitle(s.settingsPrivacy),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    children: [
                      SettingsNavigationTile(
                        icon: Icons.privacy_tip_outlined,
                        title: s.settingsPrivacyPolicy,
                        subtitle: s.settingsPrivacyPolicyDesc,
                        onTap: () {},
                        colors: colors,
                      ),
                      _buildDivider(),
                      SettingsNavigationTile(
                        icon: Icons.description_outlined,
                        title: s.settingsTermsOfUse,
                        subtitle: s.settingsTermsOfUseDesc,
                        onTap: () {},
                        colors: colors,
                      ),
                      _buildDivider(),
                      SettingsNavigationTile(
                        icon: Icons.cookie_outlined,
                        title: s.settingsCookieTracking,
                        subtitle: s.settingsCookieTrackingDesc,
                        onTap: () {},
                        colors: colors,
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // About Section
                  _buildSectionTitle(s.settingsAbout),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    children: [
                      SettingsNavigationTile(
                        icon: Icons.info_outline,
                        title: s.settingsAboutApp,
                        subtitle: s.settingsAboutAppDesc,
                        onTap: () => SettingsDialogs.showAboutDialog(context, colors),
                        colors: colors,
                      ),
                      _buildDivider(),
                      SettingsNavigationTile(
                        icon: Icons.star_outline,
                        title: s.settingsRateApp,
                        subtitle: s.settingsRateAppDesc,
                        onTap: () {},
                        colors: colors,
                      ),
                      _buildDivider(),
                      SettingsNavigationTile(
                        icon: Icons.share_outlined,
                        title: s.settingsShareApp,
                        subtitle: s.settingsShareAppDesc,
                        onTap: () {},
                        colors: colors,
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveSize.l),

                  // Danger Zone
                  _buildSectionTitle(s.settingsDangerZone),
                  SizedBox(height: ResponsiveSize.s),
                  _buildSettingsCard(
                    borderColor: colors.error.withValues(alpha: 0.3),
                    children: [
                      SettingsNavigationTile(
                        icon: Icons.cleaning_services_outlined,
                        title: s.settingsClearCache,
                        subtitle: s.settingsClearCacheDesc,
                        iconColor: colors.warning,
                        onTap: () => SettingsDialogs.showClearCacheDialog(context, colors),
                        colors: colors,
                      ),
                      _buildDivider(),
                      SettingsNavigationTile(
                        icon: Icons.delete_forever_outlined,
                        title: s.settingsDeleteAccount,
                        subtitle: s.settingsDeleteAccountDesc,
                        iconColor: colors.error,
                        textColor: colors.error,
                        onTap: () => SettingsDialogs.showDeleteAccountDialog(context, colors),
                        colors: colors,
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

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.m),
      child: Divider(height: 1, color: ref.colors.divider),
    );
  }
}

