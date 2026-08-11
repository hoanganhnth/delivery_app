import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/services/push/customer_push_wake_coordinator.dart';

import '../../application/notification_effect.dart';
import '../../application/notification_intent.dart';
import '../../application/notification_state.dart';
import '../../application/notification_view_model.dart';
import '../views/notification_view.dart';

/// Riverpod and transient-feedback adapter for [NotificationView].
class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref
            .read(notificationViewModelProvider.notifier)
            .dispatch(const NotificationLoadRequested()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<NotificationViewState>(notificationViewModelProvider, (
      previous,
      next,
    ) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(envelope.id, envelope.effect));
        }
      }
    });
    ref.listen<int>(notificationWakeEpochProvider, (previous, next) {
      if (previous != null && next > previous) {
        unawaited(
          ref
              .read(notificationViewModelProvider.notifier)
              .dispatch(const NotificationLoadRequested()),
        );
      }
    });

    return NotificationView(
      state: ref.watch(notificationViewModelProvider),
      onIntent: (intent) =>
          ref.read(notificationViewModelProvider.notifier).dispatch(intent),
    );
  }

  Future<void> _handleEffect(int effectId, NotificationEffect effect) async {
    switch (effect) {
      case NotificationShowMessage(:final message):
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
    }
    await ref
        .read(notificationViewModelProvider.notifier)
        .dispatch(NotificationEffectConsumed(effectId));
  }
}
