import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/widgets/feedback/toast/toast_extensions.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/register/register_effect.dart';
import '../../application/register/register_intent.dart';
import '../../application/register/register_state.dart';
import '../../application/register/register_view_model.dart';
import '../views/register_view.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RegisterViewState>(registerViewModelProvider, (previous, next) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(context, ref, envelope.id, envelope.effect));
        }
      }
    });

    final state = ref.watch(registerViewModelProvider);
    return RegisterView(
      state: state,
      onIntent: (intent) => unawaited(
        ref.read(registerViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    WidgetRef ref,
    int effectId,
    RegisterEffect effect,
  ) async {
    switch (effect) {
      case RegisterSucceeded():
        if (context.mounted) {
          context.showSuccessToast(S.of(context).registerSuccess);
          await Navigator.of(context).maybePop();
        }
      case RegisterNavigateBack():
        if (context.mounted) await Navigator.of(context).maybePop();
      case RegisterShowError(:final message):
        if (context.mounted) context.showErrorToast(message);
    }

    await ref
        .read(registerViewModelProvider.notifier)
        .dispatch(RegisterEffectConsumed(effectId));
  }
}
