import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/profile_intent.dart';
import '../../application/profile_view_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.state, required this.onIntent});

  final ProfileViewState state;
  final ValueChanged<ProfileIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);
    final data = state.data;
    final displayName = data.displayName?.trim().isNotEmpty == true
        ? data.displayName!
        : strings.profileTitle;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => onIntent(const ProfileRefreshRequested()),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
              flexibleSpace: FlexibleSpaceBar(
                background: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [scheme.primary, scheme.primaryContainer],
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: scheme.onPrimary.withValues(
                            alpha: 0.18,
                          ),
                          child: Text(
                            data.initial ?? '?',
                            style: TextStyle(
                              color: scheme.onPrimary,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          displayName,
                          style: TextStyle(
                            color: scheme.onPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (data.email?.isNotEmpty == true) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            data.email!,
                            style: TextStyle(
                              color: scheme.onPrimary.withValues(alpha: 0.82),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
              sliver: SliverList.list(
                children: [
                  AppSectionHeading(title: strings.profileTitle),
                  const SizedBox(height: AppSpacing.xs),
                  AppSurfaceCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        _ProfileAction(
                          icon: Icons.receipt_long_outlined,
                          title: strings.orderHistory,
                          subtitle: strings.orders,
                          onTap: () => onIntent(const ProfileOrdersRequested()),
                        ),
                        const Divider(height: 1),
                        _ProfileAction(
                          icon: Icons.location_on_outlined,
                          title: strings.profileMyAddresses,
                          subtitle: strings.profileMyAddressesDesc,
                          onTap: () =>
                              onIntent(const ProfileAddressesRequested()),
                        ),
                        const Divider(height: 1),
                        _ProfileAction(
                          icon: Icons.settings_outlined,
                          title: strings.settings,
                          subtitle: strings.settingsTitle,
                          onTap: () =>
                              onIntent(const ProfileSettingsRequested()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  OutlinedButton.icon(
                    onPressed: state.isLoggingOut
                        ? null
                        : () => onIntent(const ProfileLogoutRequested()),
                    icon: state.isLoggingOut
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.logout),
                    label: Text(strings.profileLogout),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: scheme.error,
                      side: BorderSide(color: scheme.error),
                      minimumSize: const Size.fromHeight(52),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      minVerticalPadding: 12,
      leading: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.12),
          borderRadius: AppRadii.control,
        ),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: scheme.primary),
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
