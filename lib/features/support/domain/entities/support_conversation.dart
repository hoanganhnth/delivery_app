enum SupportStatus { unavailable, open, closed }

enum SupportMessageSender { customer, support }

final class SupportMessage {
  const SupportMessage({
    required this.id,
    required this.body,
    required this.sentAt,
    this.sender = SupportMessageSender.customer,
    this.isRead = false,
  });

  final String id;
  final String body;
  final String sentAt;
  final SupportMessageSender sender;
  final bool isRead;
}

final class SupportConversation {
  const SupportConversation._(this.status, this.messages, this.id);

  const SupportConversation.open(
    List<SupportMessage> messages, {
    String id = '',
  }) : this._(SupportStatus.open, messages, id);

  const SupportConversation.closed(
    List<SupportMessage> messages, {
    String id = '',
  }) : this._(SupportStatus.closed, messages, id);

  final SupportStatus status;
  final List<SupportMessage> messages;
  final String id;
}
