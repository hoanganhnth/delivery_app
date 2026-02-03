import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/livestream_comment_entity.dart';
import '../repositories/livestream_interaction_repository.dart';

/// Use case for sending comment
class SendCommentUseCase extends UseCase<Unit, SendCommentParams> {
  final LivestreamInteractionRepository repository;

  SendCommentUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SendCommentParams params) async {
    // Validate comment
    if (params.comment.message.trim().isEmpty) {
      return left(const ValidationFailure('Nội dung bình luận không được để trống'));
    }

    return await repository.sendComment(params.comment);
  }
}

class SendCommentParams {
  final LivestreamCommentEntity comment;

  SendCommentParams({required this.comment});
}

/// Use case for streaming comments
class StreamCommentsUseCase {
  final LivestreamInteractionRepository repository;

  StreamCommentsUseCase(this.repository);

  Stream<Either<Failure, List<LivestreamCommentEntity>>> call(StreamCommentsParams params) {
    return repository.streamComments(params.livestreamId);
  }
}

class StreamCommentsParams {
  final num livestreamId;

  StreamCommentsParams({required this.livestreamId});
}

/// Use case for sending like
class SendLikeUseCase extends UseCase<Unit, SendLikeParams> {
  final LivestreamInteractionRepository repository;

  SendLikeUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SendLikeParams params) async {
    return await repository.sendLike(params.like);
  }
}

class SendLikeParams {
  final LivestreamLikeEntity like;

  SendLikeParams({required this.like});
}

/// Use case for streaming likes
class StreamLikesUseCase {
  final LivestreamInteractionRepository repository;

  StreamLikesUseCase(this.repository);

  Stream<Either<Failure, List<LivestreamLikeEntity>>> call(StreamLikesParams params) {
    return repository.streamLikes(params.livestreamId);
  }
}

class StreamLikesParams {
  final num livestreamId;

  StreamLikesParams({required this.livestreamId});
}

/// Use case for getting like count
class GetLikeCountUseCase extends UseCase<int, GetLikeCountParams> {
  final LivestreamInteractionRepository repository;

  GetLikeCountUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(GetLikeCountParams params) async {
    return await repository.getLikeCount(params.livestreamId);
  }
}

class GetLikeCountParams {
  final num livestreamId;

  GetLikeCountParams({required this.livestreamId});
}
