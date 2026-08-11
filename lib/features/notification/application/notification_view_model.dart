import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/notification/di/notification_providers.dart';
import 'package:delivery_app/features/notification/domain/entities/notification_entity.dart';
import 'package:delivery_app/features/profile/application/profile_notifier.dart';

import 'notification_effect.dart';
import 'notification_intent.dart';
import 'notification_state.dart';

final notificationViewModelProvider =
    NotifierProvider<NotificationViewModel, NotificationViewState>(
      NotificationViewModel.new,
    );

/// Owns notification use cases and all optimistic UI state transitions.
///
/// Profile and repository providers are temporary transition seams while those
/// legacy providers move into feature DI. No presentation view accesses them.
class NotificationViewModel extends Notifier<NotificationViewState> {
  int _nextEffectId = 0;
  Future<void>? _activeLoad;
  final Set<int> _activeNotificationIds = <int>{};
  bool _isMarkingAllRead = false;

  @override
  NotificationViewState build() => const NotificationViewState();

  /// Dispatches a typed user/system intent. Deletion returns whether the row
  /// may be dismissed; all other intents return `false` by convention.
  Future<bool> dispatch(NotificationIntent intent) async {
    switch (intent) {
      case NotificationLoadRequested() || NotificationRefreshRequested():
        await _load();
      case NotificationReadRequested(:final notificationId):
        await _markAsRead(notificationId);
      case NotificationMarkAllReadRequested():
        await _markAllAsRead();
      case NotificationDeleteRequested(:final notificationId):
        return _delete(notificationId);
      case NotificationEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
    return false;
  }

  Future<void> _load() {
    final activeLoad = _activeLoad;
    if (activeLoad != null) return activeLoad;

    late final Future<void> load;
    load = _loadInbox().whenComplete(() {
      if (identical(_activeLoad, load)) _activeLoad = null;
    });
    _activeLoad = load;
    return load;
  }

  Future<void> _loadInbox() async {
    state = state.copyWith(
      isLoading: true,
      clearLoadError: true,
      clearErrorMessage: true,
    );

    var profile = ref.read(profileProvider);
    if (profile.user == null) {
      await ref.read(profileProvider.notifier).getUserProfile();
      if (!ref.mounted) return;
      profile = ref.read(profileProvider);
    }

    final userId = profile.user?.authId;
    if (userId == null) {
      state = state.copyWith(
        isLoading: false,
        loadError: NotificationLoadError.accountUnavailable,
        errorMessage: profile.errorMessage,
      );
      return;
    }

    final repository = ref.read(notificationRepositoryProvider);
    final unreadResult = await repository.getUnreadCount();
    if (!ref.mounted) return;

    final result = await repository.getUserNotifications(userId);
    if (!ref.mounted) return;
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          loadError: NotificationLoadError.remote,
          errorMessage: failure.message,
        );
      },
      (notifications) {
        final unreadCount = unreadResult.fold(
          (_) => state.unreadCount,
          (count) => count,
        );
        state = state.copyWith(
          items: notifications.map(_toViewData).toList(growable: false),
          unreadCount: unreadCount,
          isLoading: false,
          clearLoadError: true,
          clearErrorMessage: true,
        );
      },
    );
  }

  Future<void> _markAsRead(int notificationId) async {
    if (_activeNotificationIds.contains(notificationId)) return;
    final itemIndex = state.items.indexWhere(
      (item) => item.id == notificationId,
    );
    if (itemIndex < 0 || state.items[itemIndex].isRead) return;

    _activeNotificationIds.add(notificationId);
    final result = await ref
        .read(notificationRepositoryProvider)
        .markAsRead(notificationId);
    _activeNotificationIds.remove(notificationId);
    if (!ref.mounted) return;

    result.fold((failure) => _emit(NotificationShowMessage(failure.message)), (
      updated,
    ) {
      final latestIndex = state.items.indexWhere(
        (item) => item.id == notificationId,
      );
      if (latestIndex < 0) return;
      final items = [...state.items];
      items[latestIndex] = _toViewData(updated);
      final previouslyRead = state.items[latestIndex].isRead;
      state = state.copyWith(
        items: List<NotificationItemViewData>.unmodifiable(items),
        unreadCount: previouslyRead
            ? state.unreadCount
            : (state.unreadCount - 1).clamp(0, state.unreadCount),
      );
    });
  }

  Future<void> _markAllAsRead() async {
    if (_isMarkingAllRead || !state.canMarkAllRead) return;
    _isMarkingAllRead = true;
    final result = await ref
        .read(notificationRepositoryProvider)
        .markAllAsRead();
    _isMarkingAllRead = false;
    if (!ref.mounted) return;

    result.fold((failure) => _emit(NotificationShowMessage(failure.message)), (
      _,
    ) {
      state = state.copyWith(
        items: state.items
            .map((item) => item.copyWith(isRead: true))
            .toList(growable: false),
        unreadCount: 0,
      );
    });
  }

  Future<bool> _delete(int notificationId) async {
    if (_activeNotificationIds.contains(notificationId)) return false;
    final itemIndex = state.items.indexWhere(
      (item) => item.id == notificationId,
    );
    if (itemIndex < 0) return false;

    _activeNotificationIds.add(notificationId);
    final result = await ref
        .read(notificationRepositoryProvider)
        .deleteNotification(notificationId);
    _activeNotificationIds.remove(notificationId);
    if (!ref.mounted) return false;

    return result.fold(
      (failure) {
        _emit(NotificationShowMessage(failure.message));
        return false;
      },
      (_) {
        final latestIndex = state.items.indexWhere(
          (item) => item.id == notificationId,
        );
        if (latestIndex < 0) return true;
        final removed = state.items[latestIndex];
        final items = [...state.items]..removeAt(latestIndex);
        state = state.copyWith(
          items: List<NotificationItemViewData>.unmodifiable(items),
          unreadCount: removed.isRead
              ? state.unreadCount
              : (state.unreadCount - 1).clamp(0, state.unreadCount),
        );
        return true;
      },
    );
  }

  NotificationItemViewData _toViewData(NotificationEntity notification) {
    return NotificationItemViewData(
      id: notification.id,
      title: notification.title,
      message: notification.message,
      tone: switch (notification.type.toUpperCase()) {
        'ORDER' => NotificationTone.order,
        'DELIVERY' => NotificationTone.delivery,
        'PROMO' || 'PROMOTION' => NotificationTone.promotion,
        'SYSTEM' => NotificationTone.system,
        'PAYMENT' => NotificationTone.payment,
        _ => NotificationTone.neutral,
      },
      isRead: notification.isRead,
      createdAt: notification.createdAt,
    );
  }

  void _emit(NotificationEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
