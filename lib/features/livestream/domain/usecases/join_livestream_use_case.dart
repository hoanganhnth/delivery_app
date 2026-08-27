import '../entities/livestream_join_session.dart';
import '../repositories/livestream_repository.dart';

final class JoinLivestreamUseCase {
  const JoinLivestreamUseCase(this._repository);

  final LivestreamRepository _repository;

  Future<LivestreamJoinSession> call(String livestreamId) {
    return _repository.join(livestreamId);
  }
}
