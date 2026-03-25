// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_remote_datasource_impl.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter

class _RestaurantApiService implements RestaurantApiService {
  _RestaurantApiService(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<BaseResponseDto<List<RestaurantDto>>> getRestaurants(
    GetRestaurantsRequestDto request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponseDto<List<RestaurantDto>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/restaurants',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponseDto<List<RestaurantDto>> _value;
    try {
      _value = BaseResponseDto<List<RestaurantDto>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<RestaurantDto>(
                    (i) => RestaurantDto.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponseDto<RestaurantDto>> getRestaurantById(num id) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponseDto<RestaurantDto>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/restaurants/${id}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponseDto<RestaurantDto> _value;
    try {
      _value = BaseResponseDto<RestaurantDto>.fromJson(
        _result.data!,
        (json) => RestaurantDto.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponseDto<List<MenuItemDto>>> getMenuItems(
    num restaurantId,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponseDto<List<MenuItemDto>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/menu-items/restaurant/${restaurantId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponseDto<List<MenuItemDto>> _value;
    try {
      _value = BaseResponseDto<List<MenuItemDto>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<MenuItemDto>(
                    (i) => MenuItemDto.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponseDto<List<RestaurantDto>>> getNearbyRestaurants(
    NearbyRestaurantsRequestDto request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponseDto<List<RestaurantDto>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/restaurants/nearby',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponseDto<List<RestaurantDto>> _value;
    try {
      _value = BaseResponseDto<List<RestaurantDto>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<RestaurantDto>(
                    (i) => RestaurantDto.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponseDto<List<RestaurantDto>>> searchRestaurants(
    SearchRestaurantsRequestDto request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponseDto<List<RestaurantDto>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/restaurants/search',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponseDto<List<RestaurantDto>> _value;
    try {
      _value = BaseResponseDto<List<RestaurantDto>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<RestaurantDto>(
                    (i) => RestaurantDto.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<BaseResponseDto<List<String>>> getRestaurantCategories() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<BaseResponseDto<List<String>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/restaurants/categories',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late BaseResponseDto<List<String>> _value;
    try {
      _value = BaseResponseDto<List<String>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json.map<String>((i) => i as String).toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
