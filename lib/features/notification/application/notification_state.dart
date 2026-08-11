import 'package:equatable/equatable.dart';
import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';

import 'notification_effect.dart';

/// Presentation-safe semantic treatment of a notification. The view resolves
/// it to theme colors and icons; application code never exposes Flutter types.
enum NotificationTone { order, delivery, promotion, system, payment, neutral }

enum NotificationLoadError { accountUnavailable, remote }

final class NotificationItemViewData extends Equatable {
  const NotificationItemViewData({
    required this.id,
    required this.title,
    required this.message,
    required this.tone,
    required this.isRead,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String message;
  final NotificationTone tone;
  final bool isRead;
  final DateTime createdAt;

  NotificationItemViewData copyWith({bool? isRead}) {
    return NotificationItemViewData(
      id: id,
      title: title,
      message: message,
      tone: tone,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, message, tone, isRead, createdAt];
}

final class NotificationViewState extends Equatable {
  const NotificationViewState({
    this.items = const <NotificationItemViewData>[],
    this.unreadCount = 0,
    this.isLoading = true,
    this.loadError,
    this.errorMessage,
    this.effects = const <UiEffectEnvelope<NotificationEffect>>[],
  });

  final List<NotificationItemViewData> items;
  final int unreadCount;
  final bool isLoading;
  final NotificationLoadError? loadError;
  final String? errorMessage;
  final List<UiEffectEnvelope<NotificationEffect>> effects;

  bool get hasLoadError => loadError != null;
  bool get canMarkAllRead => unreadCount > 0 && !isLoading;

  NotificationViewState copyWith({
    List<NotificationItemViewData>? items,
    int? unreadCount,
    bool? isLoading,
    NotificationLoadError? loadError,
    bool clearLoadError = false,
    String? errorMessage,
    bool clearErrorMessage = false,
    List<UiEffectEnvelope<NotificationEffect>>? effects,
  }) {
    return NotificationViewState(
      items: items ?? this.items,
      unreadCount: unreadCount ?? this.unreadCount,
      isLoading: isLoading ?? this.isLoading,
      loadError: clearLoadError ? null : (loadError ?? this.loadError),
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      effects: effects ?? this.effects,
    );
  }

  @override
  List<Object?> get props => [
    items,
    unreadCount,
    isLoading,
    loadError,
    errorMessage,
    effects,
  ];
}
