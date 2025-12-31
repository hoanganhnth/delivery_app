import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/support_repository.dart';

class LoadMoreMessagesUseCase {
  final SupportRepository repository;

  LoadMoreMessagesUseCase(this.repository);

  Future<Either<Failure, List<ChatMessageEntity>>> call(
    String conversationId,
    DateTime beforeTimestamp, {
    int limit = 50,
  }) {
    return repository.loadMoreMessages(
      conversationId,
      beforeTimestamp,
      limit: limit,
    );
  }
}
