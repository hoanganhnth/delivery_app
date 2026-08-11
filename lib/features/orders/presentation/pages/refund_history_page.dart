import 'dart:async';

import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/orders/application/refund_history_effect.dart';
import 'package:delivery_app/features/orders/application/refund_history_intent.dart';
import 'package:delivery_app/features/orders/application/refund_history_state.dart';
import 'package:delivery_app/features/orders/application/refund_history_view_model.dart';
import 'package:delivery_app/features/orders/presentation/views/refund_history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundHistoryPage extends ConsumerWidget {
  const RefundHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RefundHistoryViewState>(refundHistoryViewModelProvider, (
      previous,
      next,
    ) {
      final handledIds = {
        for (final envelope in previous?.effects ?? const []) envelope.id,
      };
      for (final envelope in next.effects) {
        if (!handledIds.contains(envelope.id)) {
          unawaited(_handleEffect(context, ref, envelope.id, envelope.effect));
        }
      }
    });
    return RefundHistoryView(
      state: ref.watch(refundHistoryViewModelProvider),
      onIntent: (intent) => unawaited(
        ref.read(refundHistoryViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    WidgetRef ref,
    int effectId,
    RefundHistoryEffect effect,
  ) async {
    switch (effect) {
      case RefundHistoryNavigateBack():
        if (context.mounted && context.canPop()) context.pop();
      case RefundHistoryNavigateToOrder(:final orderId):
        if (context.mounted) context.pushOrderDetail(orderId.toString());
    }
    if (context.mounted) {
      await ref
          .read(refundHistoryViewModelProvider.notifier)
          .dispatch(RefundHistoryEffectConsumed(effectId));
    }
  }
}
