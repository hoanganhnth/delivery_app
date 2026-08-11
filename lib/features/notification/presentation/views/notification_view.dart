import 'package:flutter/material.dart';
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
  });

  final NotificationViewState state;
  final Future<bool> Function(NotificationIntent intent) onIntent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                strings.notificationTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (state.unreadCount > 0) ...[
              const SizedBox(width: 8),
              _UnreadBadge(count: state.unreadCount),
            ],
          ],
        ),
        actions: [
          if (state.canMarkAllRead)
            TextButton.icon(
              onPressed: () =>
                  onIntent(const NotificationMarkAllReadRequested()),
              icon: Icon(Icons.done_all, size: 18, color: scheme.primary),
              label: Text(
                strings.notificationMarkAllRead,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: _body(context, strings),
    );
  }

  Widget _body(BuildContext context, S strings) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
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
        padding: const EdgeInsets.symmetric(vertical: 8),
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

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.error,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: scheme.onError,
          fontWeight: FontWeight.w700,
        ),
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
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(S.of(context).supportRetry),
            ),
          ],
        ),
      ),
    );
  }
}
