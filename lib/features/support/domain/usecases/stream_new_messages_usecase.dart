import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/support_repository.dart';

class StreamNewMessagesUseCase {
  final SupportRepository repository;

  StreamNewMessagesUseCase(this.repository);

  Stream<Either<Failure, List<ChatMessageEntity>>> call(
    String conversationId,
    DateTime afterTimestamp,
  ) {
    return repository.streamNewMessages(conversationId, afterTimestamp);
  }
}
