enum SupportStatus { unavailable, open, closed }

final class SupportMessage {
  const SupportMessage({
    required this.id,
    required this.body,
    required this.sentAt,
  });

  final String id;
  final String body;
  final String sentAt;
}

final class SupportConversation {
  const SupportConversation._(this.status, this.messages);

  const SupportConversation.open(List<SupportMessage> messages)
    : this._(SupportStatus.open, messages);

  const SupportConversation.closed(List<SupportMessage> messages)
    : this._(SupportStatus.closed, messages);

  final SupportStatus status;
  final List<SupportMessage> messages;
}
