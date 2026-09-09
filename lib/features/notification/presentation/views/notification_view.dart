import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/notification_intent.dart';
import '../../application/notification_state.dart';
import '../components/notification_empty_state.dart';
import '../components/notification_list_item.dart';

/// Pure notification inbox rendering. It exposes only typed intents; data
/// loading, persistence and one-shot feedback belong to its page adapter and
/// ViewModel.
class NotificationView extends StatelessWidget {
  const NotificationView({
    super.key,
    required this.state,
    required this.onIntent,
    this.onBack,
    this.onCart,
  });

  final NotificationViewState state;
  final Future<bool> Function(NotificationIntent intent) onIntent;
  final VoidCallback? onBack;
  final VoidCallback? onCart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);

    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      appBar: PreviewPageHeader(
        title: strings.notificationTitle,
        onBack: onBack,
        onCart: onCart,
        actions: [
          if (state.unreadCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: PreviewUi.accent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    child: Text(
                      '${state.unreadCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (state.canMarkAllRead)
            IconButton(
              onPressed: () =>
                  onIntent(const NotificationMarkAllReadRequested()),
              icon: Icon(Icons.done_all, size: 18, color: scheme.primary),
              tooltip: strings.notificationMarkAllRead,
            ),
        ],
      ),
      body: _body(context, strings),
    );
  }

  Widget _body(BuildContext context, S strings) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: PreviewUi.accent),
      );
    }
    if (state.hasLoadError) {
      return _NotificationLoadError(
        message: state.loadError == NotificationLoadError.accountUnavailable
            ? strings.notificationAccountUnavailable
            : state.errorMessage ?? strings.notificationAccountUnavailable,
        onRetry: () => onIntent(const NotificationLoadRequested()),
      );
    }
    if (state.items.isEmpty) return const NotificationEmptyState();
    return RefreshIndicator(
      onRefresh: () async {
        await onIntent(const NotificationRefreshRequested());
      },
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items[index];
          return NotificationListItem(
            item: item,
            onTap: () => onIntent(NotificationReadRequested(item.id)),
            onDismissed: () => onIntent(NotificationDeleteRequested(item.id)),
          );
        },
      ),
    );
  }
}

class _NotificationLoadError extends StatelessWidget {
  const _NotificationLoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: scheme.error),
            const SizedBox(height: 12),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(S.of(context).supportRetry),
              style: FilledButton.styleFrom(
                backgroundColor: PreviewUi.accent,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
