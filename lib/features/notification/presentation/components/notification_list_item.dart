import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/notification_state.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDismissed,
  });

  final NotificationItemViewData item;
  final VoidCallback onTap;
  final Future<bool> Function() onDismissed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final toneColor = _toneColor(context, item.tone);
    final surfaceColor = item.isRead
        ? scheme.surface
        : Color.alphaBlend(toneColor.withValues(alpha: 0.08), scheme.surface);

    return Dismissible(
      key: Key('notification_${item.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: scheme.error,
          borderRadius: BorderRadius.zero,
        ),
        child: Icon(Icons.delete_outline, color: scheme.onError),
      ),
      confirmDismiss: (_) => onDismissed(),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.zero,
          border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.zero,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: toneColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Icon(_icon(item.tone), color: toneColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: item.isRead
                                    ? FontWeight.w500
                                    : FontWeight.w700,
                                color: scheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!item.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: toneColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.message,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _formatTimeAgo(context, item.createdAt),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: scheme.outline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _toneColor(BuildContext context, NotificationTone tone) {
    final scheme = Theme.of(context).colorScheme;
    final semantic = context.semanticColors;
    return switch (tone) {
      NotificationTone.order => semantic.info,
      NotificationTone.delivery => semantic.success,
      NotificationTone.promotion => semantic.warning,
      NotificationTone.system => scheme.tertiary,
      NotificationTone.payment => scheme.secondary,
      NotificationTone.neutral => scheme.outline,
    };
  }

  IconData _icon(NotificationTone tone) {
    return switch (tone) {
      NotificationTone.order => Icons.shopping_bag_outlined,
      NotificationTone.delivery => Icons.delivery_dining,
      NotificationTone.promotion => Icons.local_offer_outlined,
      NotificationTone.system => Icons.settings_outlined,
      NotificationTone.payment => Icons.payment_outlined,
      NotificationTone.neutral => Icons.notifications_outlined,
    };
  }

  String _formatTimeAgo(BuildContext context, DateTime dateTime) {
    final strings = S.of(context);
    final difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 1) return strings.notificationTimeJustNow;
    if (difference.inMinutes < 60) {
      return strings.notificationTimeMinutes(difference.inMinutes);
    }
    if (difference.inHours < 24) {
      return strings.notificationTimeHours(difference.inHours);
    }
    if (difference.inDays < 7) {
      return strings.notificationTimeDays(difference.inDays);
    }
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
