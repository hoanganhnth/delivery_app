import 'package:fpdart/fpdart.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/livestream_comment_entity.dart';
import '../../domain/repositories/livestream_interaction_repository.dart';
import '../datasources/livestream_firebase_datasource_impl.dart';
import '../dtos/livestream_comment_dto.dart';

/// Implementation of LivestreamInteractionRepository
class LivestreamInteractionRepositoryImpl implements LivestreamInteractionRepository {
  final LivestreamFirebaseDataSource firebaseDataSource;

  LivestreamInteractionRepositoryImpl(this.firebaseDataSource);

  @override
  Future<Either<Failure, Unit>> sendComment(LivestreamCommentEntity comment) async {
    try {
      final commentDto = LivestreamCommentDto.fromEntity(comment);
      final result = await firebaseDataSource.sendComment(commentDto);

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (_) => right(unit),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Stream<Either<Failure, List<LivestreamCommentEntity>>> streamComments(
    num livestreamId,
  ) {
    try {
      return firebaseDataSource.streamComments(livestreamId).map(
        (either) => either.fold(
          (exception) => left<Failure, List<LivestreamCommentEntity>>(
            mapExceptionToFailure(exception),
          ),
          (dtos) => right<Failure, List<LivestreamCommentEntity>>(
            dtos.map((dto) => dto.toEntity()).toList(),
          ),
        ),
      );
    } catch (e) {
      return Stream.value(
        left<Failure, List<LivestreamCommentEntity>>(
          const ServerFailure('Unexpected error occurred'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> sendLike(LivestreamLikeEntity like) async {
    try {
      final likeDto = LivestreamLikeDto.fromEntity(like);
      final result = await firebaseDataSource.sendLike(likeDto);

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (_) => right(unit),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Stream<Either<Failure, List<LivestreamLikeEntity>>> streamLikes(
    num livestreamId,
  ) {
    try {
      return firebaseDataSource.streamLikes(livestreamId).map(
        (either) => either.fold(
          (exception) => left<Failure, List<LivestreamLikeEntity>>(
            mapExceptionToFailure(exception),
          ),
          (dtos) => right<Failure, List<LivestreamLikeEntity>>(
            dtos.map((dto) => dto.toEntity()).toList(),
          ),
        ),
      );
    } catch (e) {
      return Stream.value(
        left<Failure, List<LivestreamLikeEntity>>(
          const ServerFailure('Unexpected error occurred'),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getLikeCount(num livestreamId) async {
    try {
      final result = await firebaseDataSource.getLikeCount(livestreamId);

      return result.fold(
        (exception) => left(mapExceptionToFailure(exception)),
        (count) => right(count),
      );
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
