import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/widgets/feedback/toast/toast_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/login/login_effect.dart';
import '../../application/login/login_intent.dart';
import '../../application/login/login_state.dart';
import '../../application/login/login_view_model.dart';
import '../views/login_view.dart';

/// Riverpod/navigation adapter for the pure login view.
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginViewState>(loginViewModelProvider, (previous, next) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(context, ref, envelope.id, envelope.effect));
        }
      }
    });

    final state = ref.watch(loginViewModelProvider);
    return LoginView(
      state: state,
      onBack: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.goToMain();
        }
      },
      onIntent: (intent) =>
          unawaited(ref.read(loginViewModelProvider.notifier).dispatch(intent)),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    WidgetRef ref,
    int effectId,
    LoginEffect effect,
  ) async {
    switch (effect) {
      case LoginAuthenticationSucceeded():
        if (context.mounted) {
          context.showSuccessToast(S.of(context).loginSuccess);
          context.goToMain();
        }
      case LoginNavigateToRegister():
        if (context.mounted) context.pushRegister();
      case LoginNavigateToForgotPassword():
        if (context.mounted) context.pushForgotPassword();
      case LoginShowError(:final message):
        if (context.mounted) context.showErrorToast(message);
    }

    await ref
        .read(loginViewModelProvider.notifier)
        .dispatch(LoginEffectConsumed(effectId));
  }
}
