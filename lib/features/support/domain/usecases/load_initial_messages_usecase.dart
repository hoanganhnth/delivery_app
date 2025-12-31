import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/support_repository.dart';

class LoadInitialMessagesUseCase {
  final SupportRepository repository;

  LoadInitialMessagesUseCase(this.repository);

  Future<Either<Failure, List<ChatMessageEntity>>> call(
    String conversationId, {
    int limit = 50,
  }) {
    return repository.loadInitialMessages(conversationId, limit: limit);
  }
}
