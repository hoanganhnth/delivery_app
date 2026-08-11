sealed class NotificationIntent {
  const NotificationIntent();
}

/// Requests a fresh, server-authoritative notification inbox.
final class NotificationLoadRequested extends NotificationIntent {
  const NotificationLoadRequested();
}

final class NotificationRefreshRequested extends NotificationIntent {
  const NotificationRefreshRequested();
}

final class NotificationReadRequested extends NotificationIntent {
  const NotificationReadRequested(this.notificationId);

  final int notificationId;
}

final class NotificationMarkAllReadRequested extends NotificationIntent {
  const NotificationMarkAllReadRequested();
}

/// Returns `true` from [NotificationViewModel.dispatch] only when the API
/// deletion succeeds, so the view can let [Dismissible] complete its gesture.
final class NotificationDeleteRequested extends NotificationIntent {
  const NotificationDeleteRequested(this.notificationId);

  final int notificationId;
}

final class NotificationEffectConsumed extends NotificationIntent {
  const NotificationEffectConsumed(this.effectId);

  final int effectId;
}
