import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/generated/l10n.dart';
import '../../domain/entities/notification_entity.dart';
import '../providers/notification_providers.dart';
import 'widgets/notification_empty_state.dart';
import 'widgets/notification_list_item.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  List<NotificationEntity> _notifications = [];
  int _unreadCount = 0;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final repository = ref.read(notificationRepositoryProvider);

    // Fetch unread count
    final countResult = await repository.getUnreadCount();
    countResult.fold(
      (failure) {},
      (count) => setState(() => _unreadCount = count),
    );

    // Fetch all notifications (userId will come from X-User-Id header via gateway)
    final result = await repository.getUnreadNotifications();
    result.fold(
      (failure) {
        // Try getUserNotifications as fallback with userId 0 (gateway fills the header)
        _fetchAllNotifications();
      },
      (notifications) {
        setState(() {
          _notifications = notifications;
          _loading = false;
        });
      },
    );
  }

  Future<void> _fetchAllNotifications() async {
    final repository = ref.read(notificationRepositoryProvider);
    // userId=0 is a placeholder; the gateway attaches the real userId via X-User-Id header
    final result = await repository.getUserNotifications(0);
    result.fold(
      (failure) {
        setState(() {
          _error = failure.message;
          _loading = false;
        });
      },
      (notifications) {
        setState(() {
          _notifications = notifications;
          _loading = false;
        });
      },
    );
  }

  Future<void> _markAsRead(int id, int index) async {
    final repository = ref.read(notificationRepositoryProvider);
    final result = await repository.markAsRead(id);
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (updated) {
        setState(() {
          _notifications[index] = _notifications[index].copyWith(isRead: true);
          _unreadCount = (_unreadCount - 1).clamp(0, _unreadCount);
        });
      },
    );
  }

  Future<void> _markAllAsRead() async {
    final repository = ref.read(notificationRepositoryProvider);
    final result = await repository.markAllAsRead();
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (_) {
        setState(() {
          _notifications = _notifications
              .map((n) => n.copyWith(isRead: true))
              .toList();
          _unreadCount = 0;
        });
      },
    );
  }

  Future<void> _deleteNotification(int id, int index) async {
    final repository = ref.read(notificationRepositoryProvider);
    final result = await repository.deleteNotification(id);
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (_) {
        setState(() {
          if (!_notifications[index].isRead) {
            _unreadCount = (_unreadCount - 1).clamp(0, _unreadCount);
          }
          _notifications.removeAt(index);
        });
      },
    );
  }

  Color _getColorForType(String type) {
    switch (type.toUpperCase()) {
      case 'ORDER':
        return Colors.blue;
      case 'DELIVERY':
        return Colors.green;
      case 'PROMO':
      case 'PROMOTION':
        return Colors.orange;
      case 'SYSTEM':
        return Colors.purple;
      case 'PAYMENT':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              s.notificationTitle,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            if (_unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          if (_unreadCount > 0)
            TextButton.icon(
              onPressed: _markAllAsRead,
              icon: Icon(Icons.done_all, size: 18, color: theme.colorScheme.primary),
              label: Text(
                s.notificationMarkAllRead,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
                      const SizedBox(height: 12),
                      Text(
                        _error!,
                        style: TextStyle(color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _loadNotifications,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: Text(s.supportRetry),
                      ),
                    ],
                  ),
                )
              : _notifications.isEmpty
                  ? const NotificationEmptyState()
                  : RefreshIndicator(
                      onRefresh: _loadNotifications,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          final notification = _notifications[index];
                          final color = _getColorForType(notification.type);

                          return NotificationListItem(
                            notification: notification,
                            isDark: isDark,
                            color: color,
                            onTap: () {
                              if (!notification.isRead) {
                                _markAsRead(notification.id, index);
                              }
                            },
                            onDismissed: () => _deleteNotification(notification.id, index),
                          );
                        },
                      ),
                    ),
    );
  }
}

