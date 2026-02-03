import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/data/dtos/base_response_dto.dart';
import '../dtos/livestream_dto.dart';

part 'livestream_remote_datasource_impl.g.dart';

/// Retrofit API service for livestreams
@RestApi()
abstract class LivestreamApiService {
  factory LivestreamApiService(Dio dio) = _LivestreamApiService;

  @GET('/livestreams')
  Future<BaseResponseDto<List<LivestreamDto>>> getLivestreams({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('status') String? status,
  });

  @GET('/livestreams/{id}')
  Future<BaseResponseDto<LivestreamDto>> getLivestreamById(
    @Path('id') num id,
  );

  @GET('/livestreams/featured')
  Future<BaseResponseDto<List<LivestreamDto>>> getFeaturedLivestreams({
    @Query('limit') int? limit,
  });
}

/// Remote datasource interface
abstract class LivestreamRemoteDataSource {
  Future<BaseResponseDto<List<LivestreamDto>>> getLivestreams({
    int page = 1,
    int limit = 20,
    String? status,
  });

  Future<BaseResponseDto<LivestreamDto>> getLivestreamById(num id);

  Future<BaseResponseDto<List<LivestreamDto>>> getFeaturedLivestreams({
    int limit = 5,
  });
}

/// Remote datasource implementation
class LivestreamRemoteDataSourceImpl implements LivestreamRemoteDataSource {
  final LivestreamApiService _apiService;

  LivestreamRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseDto<List<LivestreamDto>>> getLivestreams({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      // AppLogger.d('Getting livestreams - page: $page, limit: $limit, status: $status');
      final response = await _apiService.getLivestreams(
        page: page,
        limit: limit,
        status: status,
      );
      // AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} livestreams');
      return response;
    } on DioException catch (_) {
      // AppLogger.e('Failed to get livestreams', e);
      rethrow;
    } catch (e) {
      // AppLogger.e('Unexpected error getting livestreams', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<LivestreamDto>> getLivestreamById(num id) async {
    try {
      // AppLogger.d('Getting livestream with id: $id');
      final response = await _apiService.getLivestreamById(id);
      // AppLogger.i('Successfully retrieved livestream: ${response.data?.title}');
      return response;
    } on DioException catch (_) {
      // AppLogger.e('Failed to get livestream with id: $id', e);
      rethrow;
    } catch (e) {
      // AppLogger.e('Unexpected error getting livestream', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<BaseResponseDto<List<LivestreamDto>>> getFeaturedLivestreams({
    int limit = 5,
  }) async {
    try {
      // AppLogger.d('Getting featured livestreams - limit: $limit');
      final response = await _apiService.getFeaturedLivestreams(limit: limit);
      // AppLogger.i('Successfully retrieved ${response.data?.length ?? 0} featured livestreams');
      return response;
    } on DioException catch (_) {
      // AppLogger.e('Failed to get featured livestreams', e);
      rethrow;
    } catch (e) {
      // AppLogger.e('Unexpected error getting featured livestreams', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
