sealed class OrderTrackingIntent {
  const OrderTrackingIntent();
}

final class OrderTrackingStartRequested extends OrderTrackingIntent {
  const OrderTrackingStartRequested();
}

final class OrderTrackingRetryRequested extends OrderTrackingIntent {
  const OrderTrackingRetryRequested();
}

final class OrderTrackingErrorDismissed extends OrderTrackingIntent {
  const OrderTrackingErrorDismissed();
}

/// Lifecycle intent sent by the page adapter when its tracking host unmounts.
final class OrderTrackingStopRequested extends OrderTrackingIntent {
  const OrderTrackingStopRequested();
}
