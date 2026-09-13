import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/design_system/components/preview_bottom_navigation.dart';
import 'package:delivery_app/core/widgets/feedback/toast/toast_extensions.dart';

import '../../application/profile_effect.dart';
import '../../application/profile_intent.dart';
import '../../application/profile_view_state.dart';
import '../../application/profile_view_model.dart';
import '../views/profile_view.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key, this.isTab = false});

  final bool isTab;

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
      previewMode: true,
      onBack: isTab
          ? null
          : () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.main);
              }
            },
      onCart: () => context.go(AppRoutes.cart),
      bottomNavigationBar: isTab
          ? null
          : PreviewBottomNavigation(
              currentIndex: 3,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go(AppRoutes.main);
                  case 1:
                    context.go(AppRoutes.orders);
                  case 2:
                    context.go(AppRoutes.cart);
                  case 3:
                    context.go(AppRoutes.profile);
                }
              },
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
      case ProfileNavigatePersonalInformation():
        if (context.mounted) context.pushNamed('personal-information');
      case ProfileNavigateAddresses():
        if (context.mounted) context.pushAddressList();
      case ProfileNavigateSettings():
        if (context.mounted) context.pushSettings();
      case ProfileNavigateVouchers():
        if (context.mounted) context.pushNamed('vouchers');
      case ProfileNavigateSupport():
        if (context.mounted) context.pushSupport();
      case ProfileNavigateLivestream():
        if (context.mounted) {
          context.pushNamed('livestreams');
        }
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
