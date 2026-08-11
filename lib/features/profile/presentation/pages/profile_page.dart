import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/widgets/feedback/toast/toast_extensions.dart';

import '../../application/profile_effect.dart';
import '../../application/profile_intent.dart';
import '../../application/profile_view_state.dart';
import '../../application/profile_view_model.dart';
import '../views/profile_view.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ProfileViewState>(profileViewModelProvider, (previous, next) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(context, ref, envelope.id, envelope.effect));
        }
      }
    });

    final state = ref.watch(profileViewModelProvider);
    return ProfileView(
      state: state,
      onIntent: (intent) => unawaited(
        ref.read(profileViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    WidgetRef ref,
    int effectId,
    ProfileEffect effect,
  ) async {
    switch (effect) {
      case ProfileNavigateOrders():
        if (context.mounted) context.pushOrders();
      case ProfileNavigateAddresses():
        if (context.mounted) context.pushAddressList();
      case ProfileNavigateSettings():
        if (context.mounted) context.pushSettings();
      case ProfileNavigateLogin():
        if (context.mounted) context.goToLogin();
      case ProfileShowError(:final message):
        if (context.mounted) context.showErrorToast(message);
    }
    await ref
        .read(profileViewModelProvider.notifier)
        .dispatch(ProfileEffectConsumed(effectId));
  }
}
