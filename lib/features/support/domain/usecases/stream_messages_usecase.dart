import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/support_repository.dart';
import 'package:fpdart/fpdart.dart';

class StreamMessagesUseCase {
  final SupportRepository repository;

  StreamMessagesUseCase(this.repository);

  Stream<Either<Failure, List<ChatMessageEntity>>> call(String conversationId) {
    return repository.streamMessages(conversationId);
  }
}
