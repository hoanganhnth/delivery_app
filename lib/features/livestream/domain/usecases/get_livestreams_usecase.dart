import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/livestream_entity.dart';
import '../repositories/livestream_repository.dart';

/// Use case for getting all livestreams
class GetLivestreamsUseCase extends UseCase<List<LivestreamEntity>, GetLivestreamsParams> {
  final LivestreamRepository repository;

  GetLivestreamsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LivestreamEntity>>> call(GetLivestreamsParams params) async {
    return await repository.getLivestreams(
      page: params.page,
      limit: params.limit,
      status: params.status,
    );
  }
}

class GetLivestreamsParams {
  final int page;
  final int limit;
  final String? status;

  GetLivestreamsParams({
    this.page = 1,
    this.limit = 20,
    this.status,
  });
}

/// Use case for getting livestream by ID
class GetLivestreamByIdUseCase extends UseCase<LivestreamEntity, GetLivestreamByIdParams> {
  final LivestreamRepository repository;

  GetLivestreamByIdUseCase(this.repository);

  @override
  Future<Either<Failure, LivestreamEntity>> call(GetLivestreamByIdParams params) async {
    return await repository.getLivestreamById(params.id);
  }
}

class GetLivestreamByIdParams {
  final num id;

  GetLivestreamByIdParams({required this.id});
}

/// Use case for getting featured livestreams
class GetFeaturedLivestreamsUseCase extends UseCase<List<LivestreamEntity>, GetFeaturedLivestreamsParams> {
  final LivestreamRepository repository;

  GetFeaturedLivestreamsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LivestreamEntity>>> call(GetFeaturedLivestreamsParams params) async {
    return await repository.getFeaturedLivestreams(limit: params.limit);
  }
}

class GetFeaturedLivestreamsParams {
  final int limit;

  GetFeaturedLivestreamsParams({this.limit = 5});
}
