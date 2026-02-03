import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/livestream_comment_entity.dart';

/// Repository interface for livestream interactions (Firebase)
abstract class LivestreamInteractionRepository {
  /// Send a comment to livestream
  Future<Either<Failure, Unit>> sendComment(LivestreamCommentEntity comment);

  /// Stream comments from Firebase
  Stream<Either<Failure, List<LivestreamCommentEntity>>> streamComments(
    num livestreamId,
  );

  /// Send a like to livestream
  Future<Either<Failure, Unit>> sendLike(LivestreamLikeEntity like);

  /// Stream likes from Firebase
  Stream<Either<Failure, List<LivestreamLikeEntity>>> streamLikes(
    num livestreamId,
  );

  /// Get total like count
  Future<Either<Failure, int>> getLikeCount(num livestreamId);
}
