import 'dart:async';

import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/features/cart/application/checkout_effect.dart';
import 'package:delivery_app/features/cart/application/checkout_intent.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/features/cart/application/checkout_view_model.dart';
import 'package:delivery_app/features/cart/presentation/views/checkout_view.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Adapter owning route, dialog and transient-feedback side effects.
class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref
            .read(checkoutViewModelProvider.notifier)
            .dispatch(const CheckoutLoadRequested()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CheckoutViewState>(checkoutViewModelProvider, (previous, next) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(envelope.id, envelope.effect));
        }
      }
    });
    return CheckoutView(
      state: ref.watch(checkoutViewModelProvider),
      onIntent: (intent) => unawaited(
        ref.read(checkoutViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(int effectId, CheckoutEffect effect) async {
    switch (effect) {
      case CheckoutNavigateBack():
        if (mounted && context.canPop()) {
          context.pop();
        } else if (mounted) {
          context.go(AppRoutes.home);
        }
      case CheckoutNavigateToAddresses():
        if (mounted) {
          await context.push('${AppRoutes.addressList}?context=checkout');
          if (mounted) {
            await ref
                .read(checkoutViewModelProvider.notifier)
                .dispatch(const CheckoutPreviewRetryRequested());
          }
        }
      case CheckoutShowMessage(:final message):
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      case CheckoutShowUnavailableItems(:final itemIds):
        if (mounted) await _showUnavailableItems(itemIds);
      case CheckoutPriceChanged(:final oldTotal, :final newTotal):
        if (mounted) {
          final accepted = await _showPriceChanged(oldTotal, newTotal);
          if (accepted == true && mounted) {
            await ref
                .read(checkoutViewModelProvider.notifier)
                .dispatch(const CheckoutPriceChangeAccepted());
          }
        }
      case CheckoutQuoteExpired():
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Báo giá đã hết hạn, giá mới đã được cập nhật.'),
            ),
          );
        }
      case CheckoutOrderPlaced(:final isSuccess, :final message):
        if (mounted) {
          if (isSuccess) {
            ToastUtils.showOrderPlacedSuccess(context);
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else {
            ToastUtils.showOrderPlacedError(context, message: message);
          }
        }
    }
    await ref
        .read(checkoutViewModelProvider.notifier)
        .dispatch(CheckoutEffectConsumed(effectId));
  }

  Future<void> _showUnavailableItems(List<int> itemIds) async {
    final strings = S.of(context);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialog) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(dialog).colorScheme.error,
            ),
            const SizedBox(width: 8),
            Text(strings.checkoutUnavailableItemsTitle),
          ],
        ),
        content: Text(strings.checkoutUnavailableItemsDesc(itemIds.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialog).pop(),
            child: Text(strings.checkoutUnderstood),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showPriceChanged(double oldTotal, double newTotal) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialog) => AlertDialog(
        title: const Text('Giá đơn hàng đã thay đổi'),
        content: Text(
          'Giá cũ: ${_formatVnd(oldTotal)}\n'
          'Giá mới: ${_formatVnd(newTotal)}\n\n'
          'Bạn có muốn tiếp tục đặt đơn với giá mới không?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialog).pop(false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialog).pop(true),
            child: const Text('Xác nhận giá mới'),
          ),
        ],
      ),
    );
  }

  String _formatVnd(double value) => '${value.toStringAsFixed(0)}đ';
}
