import '../entities/support_conversation.dart';

abstract interface class SupportRepository {
  Future<SupportConversation> current();
}

final class SupportBackendUnavailableException implements Exception {
  const SupportBackendUnavailableException();
}

final class UnavailableSupportRepository implements SupportRepository {
  const UnavailableSupportRepository();

  @override
  Future<SupportConversation> current() =>
      Future.error(const SupportBackendUnavailableException());
}
