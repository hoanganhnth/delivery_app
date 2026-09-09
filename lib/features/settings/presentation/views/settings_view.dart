import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:delivery_app/core/design_system/design_system.dart';

import '../../application/settings_intent.dart';
import '../../application/settings_state.dart';
import '../components/settings_preview_components.dart';

/// Pure settings rendering. It receives immutable state and emits typed
/// intents; Riverpod and one-shot effects stay in the page adapter.
class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    required this.state,
    required this.onIntent,
    this.previewMode = false,
    this.bottomNavigationBar,
    this.onBack,
    this.onCart,
  });

  final SettingsViewState state;
  final ValueChanged<SettingsIntent> onIntent;
  final bool previewMode;
  final Widget? bottomNavigationBar;
  final VoidCallback? onBack;
  final VoidCallback? onCart;

  @override
  Widget build(BuildContext context) {
    if (previewMode) {
      return Scaffold(
        backgroundColor: PreviewUi.canvas(context),
        appBar: SettingsPreviewHeader(
          onBack: onBack ?? () => Navigator.of(context).maybePop(),
          onCart: onCart ?? () => Navigator.of(context).maybePop(),
        ),
        body: SettingsPreviewBody(state: state, onIntent: onIntent),
        bottomNavigationBar: bottomNavigationBar,
      );
    }
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(strings.settingsTitle),
        centerTitle: true,
        toolbarHeight: 52,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 8, bottom: 40),
            sliver: SliverList.list(
              children: [
                _SectionHeading(title: strings.settingsAppearance),
                const SizedBox(height: AppSpacing.xs),
                Material(
                  color: scheme.surface,
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
                _SectionHeading(title: strings.settingsAbout),
                const SizedBox(height: AppSpacing.xs),
                Material(
                  color: scheme.surface,
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
                        subtitle: const Text(
                          'Hotline CSKH, câu hỏi thường gặp & liên hệ',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => onIntent(const SettingsSupportRequested()),
                      ),
                    ],
                  ),
                ),
                if (kDebugMode) ...[
                  const SizedBox(height: AppSpacing.lg),
                  const _SectionHeading(title: 'Developer'),
                  const SizedBox(height: AppSpacing.xs),
                  Material(
                    color: scheme.surface,
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
    return SizedBox(width: 24, height: 44, child: Icon(icon, color: color));
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Text(title, style: Theme.of(context).textTheme.titleSmall),
  );
}
