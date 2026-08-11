import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: scheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            strings.notificationEmptyTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            strings.notificationEmptyDesc,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: scheme.outline),
          ),
        ],
      ),
    );
  }
}
