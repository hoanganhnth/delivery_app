import 'dart:async';

import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/orders/application/orders_list_effect.dart';
import 'package:delivery_app/features/orders/application/orders_list_intent.dart';
import 'package:delivery_app/features/orders/application/orders_list_state.dart';
import 'package:delivery_app/features/orders/application/orders_list_view_model.dart';
import 'package:delivery_app/features/orders/presentation/views/orders_list_view.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:delivery_app/core/design_system/components/preview_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page adapter for the orders-history pure view.
class OrdersListPage extends ConsumerWidget {
  const OrdersListPage({super.key, this.isTab = false});

  final bool isTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<OrdersListViewState>(ordersListViewModelProvider, (
      previous,
      next,
    ) {
      if (ModalRoute.of(context)?.isCurrent == false) return;
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(context, ref, envelope.id, envelope.effect));
        }
      }
    });
    return OrdersListView(
      showBackButton: !isTab,
      previewMode: true,
      onBack: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.main);
        }
      },
      onCart: () => context.go(AppRoutes.cart),
      onRefundHistory: () => context.push(AppRoutes.refundHistory),
      bottomNavigationBar: isTab
          ? null
          : PreviewBottomNavigation(
              currentIndex: 1,
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
      state: ref.watch(ordersListViewModelProvider),
      onIntent: (intent) => unawaited(
        ref.read(ordersListViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    WidgetRef ref,
    int effectId,
    OrdersListEffect effect,
  ) async {
    switch (effect) {
      case OrdersListNavigateBack():
        if (context.mounted && context.canPop()) {
          context.pop();
        }
      case OrdersListNavigateToRefundHistory():
        if (context.mounted) context.push(AppRoutes.refundHistory);
      case OrdersListNavigateToDetails(:final orderId):
        if (context.mounted) context.pushOrderDetail(orderId.toString());
      case OrdersListNavigateToCart():
        if (context.mounted) context.pushCart();
      case OrdersListConfirmCancel(:final order):
        if (context.mounted && await _confirmCancel(context)) {
          await ref
              .read(ordersListViewModelProvider.notifier)
              .dispatch(OrdersListCancelConfirmed(order.id));
        }
      case OrdersListShowMessage(:final message, :final isSuccess):
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: isSuccess ? Colors.green : null,
            ),
          );
        }
    }
    await ref
        .read(ordersListViewModelProvider.notifier)
        .dispatch(OrdersListEffectConsumed(effectId));
  }

  Future<bool> _confirmCancel(BuildContext context) async =>
      await showDialog<bool>(
        context: context,
        builder: (dialog) => AlertDialog(
          title: Text(S.of(dialog).cancelOrder),
          content: Text(S.of(dialog).cancelOrderConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialog, false),
              child: Text(S.of(dialog).cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialog, true),
              child: Text(S.of(dialog).confirm),
            ),
          ],
        ),
      ) ??
      false;
}
