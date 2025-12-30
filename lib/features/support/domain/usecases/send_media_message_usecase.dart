import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/support_repository.dart';

class SendMediaMessageUseCase {
  final SupportRepository repository;

  SendMediaMessageUseCase(this.repository);

  Future<Either<Failure, ChatMessageEntity>> call(
    String conversationId,
    int userId,
    String filePath,
    MessageType type,
  ) async {
    return await repository.sendMediaMessage(conversationId, userId, filePath, type);
  }
}
