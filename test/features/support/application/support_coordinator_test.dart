import 'package:delivery_app/features/support/application/support_coordinator.dart';
import 'package:delivery_app/features/support/domain/entities/support_conversation.dart';
import 'package:delivery_app/features/support/domain/repositories/support_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'support remains unavailable when the backend boundary is absent',
    () async {
      final coordinator = SupportCoordinator(
        const UnavailableSupportRepository(),
      );

      final state = await coordinator.load();

      expect(state.status, SupportStatus.unavailable);
      expect(state.messages, isEmpty);
    },
  );

  test('only backend-owned conversation messages are exposed', () async {
    final coordinator = SupportCoordinator(_BackendSupportRepository());

    final state = await coordinator.load();

    expect(state.status, SupportStatus.open);
    expect(state.messages.single.body, 'Server message');
  });
}

final class _BackendSupportRepository implements SupportRepository {
  @override
  Future<SupportConversation> current() async =>
      const SupportConversation.open([
        SupportMessage(
          id: 'm1',
          body: 'Server message',
          sentAt: '2026-08-28T00:00:00Z',
        ),
      ]);

  @override
  Stream<List<SupportMessage>> watchMessages(String conversationId) =>
      const Stream.empty();

  @override
  Future<void> sendTextMessage(String conversationId, String content) async {}

  @override
  Future<void> markConversationRead(String conversationId) async {}

  @override
  Future<void> closeConversation(
    String conversationId, {
    String? reason,
  }) async {}
}
