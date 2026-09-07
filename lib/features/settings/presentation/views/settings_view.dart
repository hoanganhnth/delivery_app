import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:delivery_app/core/design_system/design_system.dart';

import '../../application/settings_intent.dart';
import '../../application/settings_state.dart';

/// Pure settings rendering. It receives immutable state and emits typed
/// intents; Riverpod and one-shot effects stay in the page adapter.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.state, required this.onIntent});

  final SettingsViewState state;
  final ValueChanged<SettingsIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                strings.settingsTitle,
                style: TextStyle(
                  color: scheme.onPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              centerTitle: true,
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [scheme.primary, scheme.primaryContainer],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
            sliver: SliverList.list(
              children: [
                AppSectionHeading(title: strings.settingsAppearance),
                const SizedBox(height: AppSpacing.xs),
                AppSurfaceCard(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    minVerticalPadding: 12,
                    leading: _IconTile(
                      icon: Icons.dark_mode_outlined,
                      color: scheme.primary,
                    ),
                    title: Text(
                      strings.settingsDarkMode,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(strings.settingsDarkModeDesc),
                    trailing: Switch.adaptive(
                      value: state.isDarkMode,
                      onChanged: state.isThemeUpdating
                          ? null
                          : (_) => onIntent(const SettingsThemeToggled()),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppSectionHeading(title: strings.settingsAbout),
                const SizedBox(height: AppSpacing.xs),
                AppSurfaceCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListTile(
                        minVerticalPadding: 12,
                        leading: _IconTile(
                          icon: Icons.info_outline,
                          color: scheme.primary,
                        ),
                        title: Text(
                          strings.settingsAboutApp,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(strings.settingsAboutAppDesc),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => onIntent(const SettingsAboutRequested()),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        minVerticalPadding: 12,
                        leading: _IconTile(
                          icon: Icons.headset_mic_outlined,
                          color: scheme.primary,
                        ),
                        title: const Text(
                          'Hỗ trợ & Trợ giúp',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: const Text('Hotline CSKH, câu hỏi thường gặp & liên hệ'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => onIntent(const SettingsSupportRequested()),
                      ),
                    ],
                  ),
                ),
                if (kDebugMode) ...[
                  const SizedBox(height: AppSpacing.lg),
                  const AppSectionHeading(title: 'Developer'),
                  const SizedBox(height: AppSpacing.xs),
                  AppSurfaceCard(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      minVerticalPadding: 12,
                      leading: _IconTile(
                        icon: Icons.bug_report_outlined,
                        color: scheme.primary,
                      ),
                      title: const Text(
                        'Debug tools',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: const Text(
                        'Xem log, API call và đổi backend URL',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () =>
                          onIntent(const SettingsDebugToolsRequested()),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(width: 44, height: 44, child: Icon(icon, color: color)),
    );
  }
}
