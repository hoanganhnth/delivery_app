import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
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
                        icon: Icons.location_on_outlined,
                        title: s.profileMyAddresses,
                        subtitle: s.profileMyAddressesDesc,
                        colors: colors,
                        onTap: () => context.push('/address-list'),
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
                          borderRadius: BorderRadius.circular(
                            ResponsiveSize.radiusL,
                          ),
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
