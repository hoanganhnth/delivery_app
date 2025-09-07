// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_restaurants_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchRestaurantsRequestDto {

 String get query; double? get latitude; double? get longitude; String? get category; int? get page; int? get limit;
/// Create a copy of SearchRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchRestaurantsRequestDtoCopyWith<SearchRestaurantsRequestDto> get copyWith => _$SearchRestaurantsRequestDtoCopyWithImpl<SearchRestaurantsRequestDto>(this as SearchRestaurantsRequestDto, _$identity);

  /// Serializes this SearchRestaurantsRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchRestaurantsRequestDto&&(identical(other.query, query) || other.query == query)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,latitude,longitude,category,page,limit);

@override
String toString() {
  return 'SearchRestaurantsRequestDto(query: $query, latitude: $latitude, longitude: $longitude, category: $category, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $SearchRestaurantsRequestDtoCopyWith<$Res>  {
  factory $SearchRestaurantsRequestDtoCopyWith(SearchRestaurantsRequestDto value, $Res Function(SearchRestaurantsRequestDto) _then) = _$SearchRestaurantsRequestDtoCopyWithImpl;
@useResult
$Res call({
 String query, double? latitude, double? longitude, String? category, int? page, int? limit
});




}
/// @nodoc
class _$SearchRestaurantsRequestDtoCopyWithImpl<$Res>
    implements $SearchRestaurantsRequestDtoCopyWith<$Res> {
  _$SearchRestaurantsRequestDtoCopyWithImpl(this._self, this._then);

  final SearchRestaurantsRequestDto _self;
  final $Res Function(SearchRestaurantsRequestDto) _then;

/// Create a copy of SearchRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? latitude = freezed,Object? longitude = freezed,Object? category = freezed,Object? page = freezed,Object? limit = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchRestaurantsRequestDto].
extension SearchRestaurantsRequestDtoPatterns on SearchRestaurantsRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchRestaurantsRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchRestaurantsRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchRestaurantsRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _SearchRestaurantsRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchRestaurantsRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _SearchRestaurantsRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  double? latitude,  double? longitude,  String? category,  int? page,  int? limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchRestaurantsRequestDto() when $default != null:
return $default(_that.query,_that.latitude,_that.longitude,_that.category,_that.page,_that.limit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  double? latitude,  double? longitude,  String? category,  int? page,  int? limit)  $default,) {final _that = this;
switch (_that) {
case _SearchRestaurantsRequestDto():
return $default(_that.query,_that.latitude,_that.longitude,_that.category,_that.page,_that.limit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  double? latitude,  double? longitude,  String? category,  int? page,  int? limit)?  $default,) {final _that = this;
switch (_that) {
case _SearchRestaurantsRequestDto() when $default != null:
return $default(_that.query,_that.latitude,_that.longitude,_that.category,_that.page,_that.limit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchRestaurantsRequestDto implements SearchRestaurantsRequestDto {
  const _SearchRestaurantsRequestDto({required this.query, this.latitude, this.longitude, this.category, this.page, this.limit});
  factory _SearchRestaurantsRequestDto.fromJson(Map<String, dynamic> json) => _$SearchRestaurantsRequestDtoFromJson(json);

@override final  String query;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? category;
@override final  int? page;
@override final  int? limit;

/// Create a copy of SearchRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchRestaurantsRequestDtoCopyWith<_SearchRestaurantsRequestDto> get copyWith => __$SearchRestaurantsRequestDtoCopyWithImpl<_SearchRestaurantsRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchRestaurantsRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchRestaurantsRequestDto&&(identical(other.query, query) || other.query == query)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.category, category) || other.category == category)&&(identical(other.page, page) || other.page == page)&&(identical(other.limit, limit) || other.limit == limit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query,latitude,longitude,category,page,limit);

@override
String toString() {
  return 'SearchRestaurantsRequestDto(query: $query, latitude: $latitude, longitude: $longitude, category: $category, page: $page, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$SearchRestaurantsRequestDtoCopyWith<$Res> implements $SearchRestaurantsRequestDtoCopyWith<$Res> {
  factory _$SearchRestaurantsRequestDtoCopyWith(_SearchRestaurantsRequestDto value, $Res Function(_SearchRestaurantsRequestDto) _then) = __$SearchRestaurantsRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String query, double? latitude, double? longitude, String? category, int? page, int? limit
});




}
/// @nodoc
class __$SearchRestaurantsRequestDtoCopyWithImpl<$Res>
    implements _$SearchRestaurantsRequestDtoCopyWith<$Res> {
  __$SearchRestaurantsRequestDtoCopyWithImpl(this._self, this._then);

  final _SearchRestaurantsRequestDto _self;
  final $Res Function(_SearchRestaurantsRequestDto) _then;

/// Create a copy of SearchRestaurantsRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? latitude = freezed,Object? longitude = freezed,Object? category = freezed,Object? page = freezed,Object? limit = freezed,}) {
  return _then(_SearchRestaurantsRequestDto(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
