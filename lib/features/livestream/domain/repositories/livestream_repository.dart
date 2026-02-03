import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/livestream_entity.dart';

/// Repository interface for livestream operations
abstract class LivestreamRepository {
  /// Get all active livestreams
  Future<Either<Failure, List<LivestreamEntity>>> getLivestreams({
    int page = 1,
    int limit = 20,
    String? status,
  });

  /// Get livestream by ID
  Future<Either<Failure, LivestreamEntity>> getLivestreamById(num id);

  /// Get featured livestreams for home page
  Future<Either<Failure, List<LivestreamEntity>>> getFeaturedLivestreams({
    int limit = 5,
  });

  /// Update viewer count (local only)
  Future<Either<Failure, LivestreamEntity>> updateViewerCount(
    num livestreamId,
    int viewerCount,
  );

  /// Update like count (local only)
  Future<Either<Failure, LivestreamEntity>> updateLikeCount(
    num livestreamId,
    int likeCount,
  );
}
