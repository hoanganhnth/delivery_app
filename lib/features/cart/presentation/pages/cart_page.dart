import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/generated/l10n.dart';
import '../../application/cart_view_effect.dart';
import '../../application/cart_view_intent.dart';
import '../../application/cart_view_state.dart';
import '../../application/cart_view_model.dart';
import '../views/cart_view.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});
  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(
          ref
              .read(cartViewModelProvider.notifier)
              .dispatch(const CartPriceSyncRequested()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CartViewState>(cartViewModelProvider, (previous, next) {
      final ids = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!ids.contains(envelope.id)) {
          unawaited(_effect(envelope.id, envelope.effect));
        }
      }
    });
    return CartView(
      state: ref.watch(cartViewModelProvider),
      onIntent: (intent) =>
          unawaited(ref.read(cartViewModelProvider.notifier).dispatch(intent)),
    );
  }

  Future<void> _effect(int id, CartViewEffect effect) async {
    switch (effect) {
      case CartNavigateBack():
        if (mounted && context.canPop()) {
          context.pop();
        }
      case CartNavigateRestaurants():
        if (mounted) {
          context.pushToRestaurants();
        }
      case CartNavigateCheckout():
        if (mounted) {
          context.pushCheckout();
        }
      case CartConfirmClear():
        if (mounted && await _confirmClear()) {
          await ref
              .read(cartViewModelProvider.notifier)
              .dispatch(const CartClearConfirmed());
        }
      case CartShowMessage(:final message):
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
    }
    await ref
        .read(cartViewModelProvider.notifier)
        .dispatch(CartEffectConsumed(id));
  }

  Future<bool> _confirmClear() async =>
      await showDialog<bool>(
        context: context,
        builder: (dialog) => AlertDialog(
          title: Text(S.of(dialog).clearCartTitle),
          content: Text(S.of(dialog).clearCartMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialog, false),
              child: Text(S.of(dialog).cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialog, true),
              child: Text(S.of(dialog).clear),
            ),
          ],
        ),
      ) ??
      false;
}
