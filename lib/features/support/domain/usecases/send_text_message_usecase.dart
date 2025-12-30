import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/support_repository.dart';

class SendTextMessageUseCase {
  final SupportRepository repository;

  SendTextMessageUseCase(this.repository);

  Future<Either<Failure, ChatMessageEntity>> call(
    String conversationId,
    int userId,
    String content,
  ) async {
    return await repository.sendTextMessage(conversationId, userId, content);
  }
}
