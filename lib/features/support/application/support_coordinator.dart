import '../domain/entities/support_conversation.dart';
import '../domain/repositories/support_repository.dart';

final class SupportState {
  const SupportState(this.status, this.messages, {this.conversationId});

  final SupportStatus status;
  final List<SupportMessage> messages;
  final String? conversationId;
}

final class SupportCoordinator {
  const SupportCoordinator(this._repository);

  final SupportRepository _repository;

  Future<SupportState> load() async {
    try {
      final conversation = await _repository.current();
      return SupportState(
        conversation.status,
        conversation.messages,
        conversationId: conversation.id.isEmpty ? null : conversation.id,
      );
    } on SupportBackendUnavailableException {
      return const SupportState(SupportStatus.unavailable, []);
    }
  }

  Stream<List<SupportMessage>> watchMessages(String conversationId) =>
      _repository.watchMessages(conversationId);

  Future<void> sendTextMessage(String conversationId, String content) =>
      _repository.sendTextMessage(conversationId, content);

  Future<void> markConversationRead(String conversationId) =>
      _repository.markConversationRead(conversationId);

  Future<void> closeConversation(String conversationId, {String? reason}) =>
      _repository.closeConversation(conversationId, reason: reason);
}
