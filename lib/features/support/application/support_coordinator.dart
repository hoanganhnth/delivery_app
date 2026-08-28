import '../domain/entities/support_conversation.dart';
import '../domain/repositories/support_repository.dart';

final class SupportState {
  const SupportState(this.status, this.messages);

  final SupportStatus status;
  final List<SupportMessage> messages;
}

final class SupportCoordinator {
  const SupportCoordinator(this._repository);

  final SupportRepository _repository;

  Future<SupportState> load() async {
    try {
      final conversation = await _repository.current();
      return SupportState(conversation.status, conversation.messages);
    } on SupportBackendUnavailableException {
      return const SupportState(SupportStatus.unavailable, []);
    }
  }
}
