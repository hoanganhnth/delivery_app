import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/conversation_entity.dart';
import '../repositories/support_repository.dart';

class GetOrCreateConversationUseCase {
  final SupportRepository repository;

  GetOrCreateConversationUseCase(this.repository);

  Future<Either<Failure, ConversationEntity>> call(
    int userId,
    String userEmail,
    String? userName,
  ) async {
    return await repository.getOrCreateConversation(userId, userEmail, userName);
  }
}
