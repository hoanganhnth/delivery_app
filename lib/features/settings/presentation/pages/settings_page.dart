import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/settings_effect.dart';
import '../../application/settings_intent.dart';
import '../../application/settings_state.dart';
import '../../application/settings_view_model.dart';
import '../views/settings_view.dart';

/// Riverpod/platform adapter for the pure SettingsView.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<SettingsViewState>(settingsViewModelProvider, (previous, next) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(context, ref, envelope.id, envelope.effect));
        }
      }
    });

    final state = ref.watch(settingsViewModelProvider);
    return SettingsView(
      state: state,
      onIntent: (intent) => dispatchSettingsIntent(ref, intent),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    WidgetRef ref,
    int effectId,
    SettingsEffect effect,
  ) async {
    switch (effect) {
      case SettingsShowAbout():
        final strings = S.of(context);
        await showDialog<void>(
          context: context,
          builder: (dialogContext) => AboutDialog(
            applicationName: strings.settingsAboutApp,
            applicationVersion: strings.settingsAboutAppDesc,
            children: [
              const Text('Ứng dụng giao đồ ăn nhanh chóng và tiện lợi.'),
            ],
          ),
        );
      case SettingsOpenDebugTools():
        if (context.mounted) context.pushDebugTools();
    }

    await ref
        .read(settingsViewModelProvider.notifier)
        .dispatch(SettingsEffectConsumed(effectId));
  }
}
