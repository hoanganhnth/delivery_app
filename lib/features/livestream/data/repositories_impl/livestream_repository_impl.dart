import 'package:delivery_app/core/data/dtos/base_response_dto.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/livestream_entity.dart';
import '../../domain/repositories/livestream_repository.dart';
import '../datasources/livestream_remote_datasource_impl.dart';

/// Implementation of LivestreamRepository
class LivestreamRepositoryImpl implements LivestreamRepository {
  final LivestreamRemoteDataSource remoteDataSource;

  // Local cache for livestreams
  final Map<num, LivestreamEntity> _livestreamCache = {};

  LivestreamRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<LivestreamEntity>>> getLivestreams({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      final response = await remoteDataSource.getLivestreams(
        page: page,
        limit: limit,
        status: status,
      );

      if (response.isSuccess && response.data != null) {
        final livestreams = response.data!.map((dto) => dto.toEntity()).toList();
        
        // Cache livestreams
        for (var livestream in livestreams) {
          _livestreamCache[livestream.id] = livestream;
        }
        
        return right(livestreams);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, LivestreamEntity>> getLivestreamById(num id) async {
    try {
      final response = await remoteDataSource.getLivestreamById(id);

      if (response.isSuccess && response.data != null) {
        final livestream = response.data!.toEntity();
        
        // Update cache
        _livestreamCache[id] = livestream;
        
        return right(livestream);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<LivestreamEntity>>> getFeaturedLivestreams({
    int limit = 5,
  }) async {
    try {
      final response = await remoteDataSource.getFeaturedLivestreams(limit: limit);

      if (response.isSuccess && response.data != null) {
        final livestreams = response.data!.map((dto) => dto.toEntity()).toList();
        
        // Cache livestreams
        for (var livestream in livestreams) {
          _livestreamCache[livestream.id] = livestream;
        }
        
        return right(livestreams);
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, LivestreamEntity>> updateViewerCount(
    num livestreamId,
    int viewerCount,
  ) async {
    try {
      // Update local cache only
      final livestream = _livestreamCache[livestreamId];
      if (livestream != null) {
        final updated = LivestreamEntity(
          id: livestream.id,
          title: livestream.title,
          streamerId: livestream.streamerId,
          streamerName: livestream.streamerName,
          streamerAvatar: livestream.streamerAvatar,
          channelName: livestream.channelName,
          rtcToken: livestream.rtcToken,
          uid: livestream.uid,
          description: livestream.description,
          viewerCount: viewerCount,
          likeCount: livestream.likeCount,
          status: livestream.status,
          thumbnailUrl: livestream.thumbnailUrl,
          coverImageUrl: livestream.coverImageUrl,
          startTime: livestream.startTime,
          endTime: livestream.endTime,
          products: livestream.products,
        );
        
        _livestreamCache[livestreamId] = updated;
        return right(updated);
      }
      
      return left(const CacheFailure('Livestream not found in cache'));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, LivestreamEntity>> updateLikeCount(
    num livestreamId,
    int likeCount,
  ) async {
    try {
      // Update local cache only
      final livestream = _livestreamCache[livestreamId];
      if (livestream != null) {
        final updated = LivestreamEntity(
          id: livestream.id,
          title: livestream.title,
          streamerId: livestream.streamerId,
          streamerName: livestream.streamerName,
          streamerAvatar: livestream.streamerAvatar,
          channelName: livestream.channelName,
          rtcToken: livestream.rtcToken,
          uid: livestream.uid,
          description: livestream.description,
          viewerCount: livestream.viewerCount,
          likeCount: likeCount,
          status: livestream.status,
          thumbnailUrl: livestream.thumbnailUrl,
          coverImageUrl: livestream.coverImageUrl,
          startTime: livestream.startTime,
          endTime: livestream.endTime,
          products: livestream.products,
        );
        
        _livestreamCache[livestreamId] = updated;
        return right(updated);
      }
      
      return left(const CacheFailure('Livestream not found in cache'));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
