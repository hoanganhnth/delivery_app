import 'dart:async';

import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/orders/application/order_detail_effect.dart';
import 'package:delivery_app/features/orders/application/order_detail_intent.dart';
import 'package:delivery_app/features/orders/application/order_detail_state.dart';
import 'package:delivery_app/features/orders/application/order_detail_view_model.dart';
import 'package:delivery_app/features/orders/presentation/pages/order_tracking_page.dart';
import 'package:delivery_app/features/orders/presentation/views/order_detail_view.dart';
import 'package:delivery_app/features/orders/presentation/pages/order_detail_cancel_sheet.dart';
import 'package:delivery_app/features/orders/presentation/pages/order_detail_rating_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod/navigation adapter for the otherwise pure Order Detail view.
class OrderDetailPage extends ConsumerWidget {
  const OrderDetailPage({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = orderDetailViewModelProvider(orderId);
    ref.listen<OrderDetailViewState>(provider, (previous, next) {
      final handledIds = {
        for (final envelope in previous?.effects ?? const []) envelope.id,
      };
      for (final envelope in next.effects) {
        if (!handledIds.contains(envelope.id)) {
          unawaited(
            _handleEffect(context, ref, provider, envelope.id, envelope.effect),
          );
        }
      }
    });
    return OrderDetailView(
      orderId: orderId,
      state: ref.watch(provider),
      tracking: OrderTrackingPage(orderId: orderId, trackingRealtime: true),
      onIntent: (intent) =>
          unawaited(ref.read(provider.notifier).dispatch(intent)),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    WidgetRef ref,
    NotifierProvider<OrderDetailViewModel, OrderDetailViewState> provider,
    int effectId,
    OrderDetailEffect effect,
  ) async {
    switch (effect) {
      case OrderDetailNavigateBack():
        if (context.mounted && context.canPop()) context.pop();
      case OrderDetailNavigateToCart():
        if (context.mounted) context.pushCart();
      case OrderDetailConfirmCancellation():
        final reason = context.mounted
            ? await CancelOrderBottomSheet.show(context)
            : null;
        if (reason != null && context.mounted) {
          await ref
              .read(provider.notifier)
              .dispatch(OrderDetailCancelConfirmed(reason));
        }
      case OrderDetailOpenRestaurantRating(:final restaurantName):
        if (context.mounted) {
          await showModalBottomSheet<bool>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => RestaurantRatingBottomSheet(
              restaurantName: restaurantName,
              onSubmit: (rating, comment) => ref
                  .read(provider.notifier)
                  .dispatch(
                    OrderDetailRatingSubmitted(
                      rating: rating,
                      comment: comment,
                    ),
                  ),
            ),
          );
        }
      case OrderDetailShowMessage(:final message, :final isSuccess):
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: isSuccess ? Colors.green : null,
            ),
          );
        }
    }
    if (context.mounted) {
      await ref
          .read(provider.notifier)
          .dispatch(OrderDetailEffectConsumed(effectId));
    }
  }
}
