import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../repositories/support_repository.dart';

class CloseConversationUseCase {
  final SupportRepository repository;

  CloseConversationUseCase(this.repository);

  Future<Either<Failure, void>> call(
    String conversationId, {
    String closeReason = 'Đã giải quyết xong',
  }) {
    return repository.closeConversation(
      conversationId,
      closedBy: 'user',
      closeReason: closeReason,
    );
  }
}
