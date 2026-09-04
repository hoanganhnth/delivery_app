import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_effect.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_intent.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_state.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_view_model.dart';
import 'package:delivery_app/features/cart/presentation/views/order_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderConfirmationPage extends ConsumerWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<OrderConfirmationViewState>(orderConfirmationViewModelProvider, (
      previous,
      next,
    ) {
      final handledIds = {
        for (final envelope in previous?.effects ?? const []) envelope.id,
      };
      for (final envelope in next.effects) {
        if (!handledIds.contains(envelope.id)) {
          _handleEffect(context, ref, envelope.id, envelope.effect);
        }
      }
    });
    return OrderConfirmationView(
      state: ref.watch(orderConfirmationViewModelProvider),
      onIntent: (intent) => ref
          .read(orderConfirmationViewModelProvider.notifier)
          .dispatch(intent),
      onHome: () => Navigator.of(context).popUntil((r) => r.isFirst),
    );
  }

  void _handleEffect(
    BuildContext context,
    WidgetRef ref,
    int effectId,
    OrderConfirmationEffect effect,
  ) {
    switch (effect) {
      case OrderConfirmationNavigateToOrders():
        if (context.mounted) context.pushOrders();
    }
    if (context.mounted) {
      ref
          .read(orderConfirmationViewModelProvider.notifier)
          .dispatch(OrderConfirmationEffectConsumed(effectId));
    }
  }
}
