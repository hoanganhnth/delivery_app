import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/features/auth/presentation/widgets/biometric_settings_widget.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/profile_menu_tile.dart';

/// Profile Screen - Editorial style with Dark Nav
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          // Header with Avatar & Info
          ProfileHeader(colors: colors),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveSize.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account Section
                  ProfileMenuSection(
                    title: s.profileTitle,
                    colors: colors,
                    children: [
                      ProfileMenuTile(
                        icon: Icons.person_outline,
                        title: s.profileEditProfile,
                        subtitle: s.profileEditProfileDesc,
                        colors: colors,
                        onTap: () {},
                      ),
                      ProfileMenuDivider(colors: colors),
                      ProfileMenuTile(
                        icon: Icons.location_on_outlined,
                        title: s.profileMyAddresses,
                        subtitle: s.profileMyAddressesDesc,
                        colors: colors,
                        onTap: () => context.push('/address-list'),
                      ),
                      ProfileMenuDivider(colors: colors),
                      ProfileMenuTile(
                        icon: Icons.payment_outlined,
                        title: s.profilePaymentMethods,
                        subtitle: s.profilePaymentMethodsDesc,
                        colors: colors,
                        onTap: () {},
                      ),
                    ],
                  ),

                  // Security Section
                  ProfileMenuSection(
                    title: s.profileSecurity,
                    colors: colors,
                    children: [
                      ProfileMenuTile(
                        icon: Icons.lock_outline,
                        title: s.profileChangePassword,
                        subtitle: s.profileChangePasswordDesc,
                        colors: colors,
                        onTap: () {},
                      ),
                      ProfileMenuDivider(colors: colors),
                      // Biometric settings
                      const BiometricSettingsWidget(),
                    ],
                  ),

                  // Support Section
                  ProfileMenuSection(
                    title: s.profileSupport,
                    colors: colors,
                    children: [
                      ProfileMenuTile(
                        icon: Icons.support_agent_outlined,
                        title: s.profileCustomerSupport,
                        subtitle: s.profileCustomerSupportDesc,
                        colors: colors,
                        onTap: () => context.go('/support-chat'),
                      ),
                      ProfileMenuDivider(colors: colors),
                      ProfileMenuTile(
                        icon: Icons.help_outline,
                        title: s.profileHelpFAQ,
                        subtitle: s.profileHelpFAQDesc,
                        colors: colors,
                        onTap: () {},
                      ),
                      ProfileMenuDivider(colors: colors),
                      ProfileMenuTile(
                        icon: Icons.policy_outlined,
                        title: s.profileTermsPolicies,
                        subtitle: s.profileTermsPoliciesDesc,
                        colors: colors,
                        onTap: () {},
                      ),
                    ],
                  ),

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
                        s.profileLogout,
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
}

