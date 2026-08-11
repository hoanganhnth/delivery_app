import 'package:equatable/equatable.dart';

sealed class NotificationEffect extends Equatable {
  const NotificationEffect();
}

/// A transient message for an action failure. Initial-load failures are part
/// of state so that the view can render an accessible retry surface.
final class NotificationShowMessage extends NotificationEffect {
  const NotificationShowMessage(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
