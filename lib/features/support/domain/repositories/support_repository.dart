import '../entities/support_conversation.dart';

abstract interface class SupportRepository {
  Future<SupportConversation> current();

  Stream<List<SupportMessage>> watchMessages(String conversationId);

  Future<void> sendTextMessage(String conversationId, String content);

  Future<void> markConversationRead(String conversationId);

  Future<void> closeConversation(String conversationId, {String? reason});
}

final class SupportBackendUnavailableException implements Exception {
  const SupportBackendUnavailableException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Support backend unavailable';
}

final class UnavailableSupportRepository implements SupportRepository {
  const UnavailableSupportRepository();

  @override
  Future<SupportConversation> current() =>
      Future.error(const SupportBackendUnavailableException());

  @override
  Stream<List<SupportMessage>> watchMessages(String conversationId) =>
      Stream<List<SupportMessage>>.error(
        const SupportBackendUnavailableException(),
      );

  @override
  Future<void> sendTextMessage(String conversationId, String content) =>
      Future<void>.error(const SupportBackendUnavailableException());

  @override
  Future<void> markConversationRead(String conversationId) =>
      Future<void>.error(const SupportBackendUnavailableException());

  @override
  Future<void> closeConversation(String conversationId, {String? reason}) =>
      Future<void>.error(const SupportBackendUnavailableException());
}
