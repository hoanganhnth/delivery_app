# Skill: API Layer (Data Layer)

> Use when: Creating datasources, repositories, API calls

## Pattern: Remote DataSource (throws Exception)

// Định nghĩa bắt buộc: Xài `abstract interface class` của Dart 3
abstract interface class FeatureRemoteDataSource {
  Future<BaseResponseDto<FeatureDto>> getItems();
}

class FeatureRemoteDataSourceImpl implements FeatureRemoteDataSource {
  final FeatureApiService _apiService;

  FeatureRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseDto<FeatureDto>> getItems() async {
    try {
      AppLogger.d('Fetching items');
      final response = await _apiService.getItems();
      AppLogger.i('Fetched ${response.data?.length ?? 0} items');
      return response;
    } on DioException catch (e) {
      AppLogger.e('Failed to fetch items', e);
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error', e);
      throw Exception('Unexpected: ${e.toString()}');
    }
  }
}
```

## Pattern: Repository (returns Either)

// Định nghĩa bắt buộc: Xài `abstract interface class` của Dart 3
abstract interface class FeatureRepository {
  Future<Either<Failure, List<FeatureEntity>>> getItems();
}

class FeatureRepositoryImpl implements FeatureRepository {
  final FeatureRemoteDataSource _remoteDataSource;

  FeatureRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<FeatureEntity>>> getItems() async {
    try {
      final response = await _remoteDataSource.getItems();
      if (response.isSuccess && response.data != null) {
        return right(response.data!.map((e) => e.toEntity()).toList());
      }
      return left(ServerFailure(response.message));
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
```

## Pattern: Retrofit API Service

```dart
@RestApi()
abstract class FeatureApiService {
  factory FeatureApiService(Dio dio) = _FeatureApiService;

  @GET('/features')
  Future<BaseResponseDto<List<FeatureDto>>> getItems();

  @GET('/features/{id}')
  Future<BaseResponseDto<FeatureDto>> getById(@Path() String id);

  @POST('/features')
  Future<BaseResponseDto<FeatureDto>> create(@Body() CreateFeatureDto dto);

  @PUT('/features/{id}')
  Future<BaseResponseDto<FeatureDto>> update(
    @Path() String id,
    @Body() UpdateFeatureDto dto,
  );

  @DELETE('/features/{id}')
  Future<BaseResponseDto<void>> delete(@Path() String id);
}
```

## Pattern: DTO with Freezed

```dart
@freezed
class FeatureDto with _$FeatureDto {
  const factory FeatureDto({
    required String id,
    required String name,
    String? description,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _FeatureDto;

  factory FeatureDto.fromJson(Map<String, dynamic> json) =>
      _$FeatureDtoFromJson(json);
}

extension FeatureDtoX on FeatureDto {
  FeatureEntity toEntity() => FeatureEntity(
    id: id,
    name: name,
    description: description,
  );
}
```

## Logging Standards

```dart
AppLogger.d('Debug: method start with params');  // Debug
AppLogger.i('Info: success with result');        // Success
AppLogger.e('Error: context message', error);    // Error
```
