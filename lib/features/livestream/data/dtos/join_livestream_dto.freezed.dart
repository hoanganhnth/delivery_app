// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_livestream_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JoinLivestreamDto {

 String get livestreamId; String get channelName; String get title; int get restaurantId; String get token; int get uid; String? get tokenExpiresAt; int get sellerId; String? get startedAt; int? get currentViewers;
/// Create a copy of JoinLivestreamDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinLivestreamDtoCopyWith<JoinLivestreamDto> get copyWith => _$JoinLivestreamDtoCopyWithImpl<JoinLivestreamDto>(this as JoinLivestreamDto, _$identity);

  /// Serializes this JoinLivestreamDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinLivestreamDto&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.title, title) || other.title == title)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.token, token) || other.token == token)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.tokenExpiresAt, tokenExpiresAt) || other.tokenExpiresAt == tokenExpiresAt)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.currentViewers, currentViewers) || other.currentViewers == currentViewers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,livestreamId,channelName,title,restaurantId,token,uid,tokenExpiresAt,sellerId,startedAt,currentViewers);

@override
String toString() {
  return 'JoinLivestreamDto(livestreamId: $livestreamId, channelName: $channelName, title: $title, restaurantId: $restaurantId, token: $token, uid: $uid, tokenExpiresAt: $tokenExpiresAt, sellerId: $sellerId, startedAt: $startedAt, currentViewers: $currentViewers)';
}


}

/// @nodoc
abstract mixin class $JoinLivestreamDtoCopyWith<$Res>  {
  factory $JoinLivestreamDtoCopyWith(JoinLivestreamDto value, $Res Function(JoinLivestreamDto) _then) = _$JoinLivestreamDtoCopyWithImpl;
@useResult
$Res call({
 String livestreamId, String channelName, String title, int restaurantId, String token, int uid, String? tokenExpiresAt, int sellerId, String? startedAt, int? currentViewers
});




}
/// @nodoc
class _$JoinLivestreamDtoCopyWithImpl<$Res>
    implements $JoinLivestreamDtoCopyWith<$Res> {
  _$JoinLivestreamDtoCopyWithImpl(this._self, this._then);

  final JoinLivestreamDto _self;
  final $Res Function(JoinLivestreamDto) _then;

/// Create a copy of JoinLivestreamDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? livestreamId = null,Object? channelName = null,Object? title = null,Object? restaurantId = null,Object? token = null,Object? uid = null,Object? tokenExpiresAt = freezed,Object? sellerId = null,Object? startedAt = freezed,Object? currentViewers = freezed,}) {
  return _then(_self.copyWith(
livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as String,channelName: null == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,tokenExpiresAt: freezed == tokenExpiresAt ? _self.tokenExpiresAt : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
as String?,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as int,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,currentViewers: freezed == currentViewers ? _self.currentViewers : currentViewers // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [JoinLivestreamDto].
extension JoinLivestreamDtoPatterns on JoinLivestreamDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinLivestreamDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinLivestreamDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinLivestreamDto value)  $default,){
final _that = this;
switch (_that) {
case _JoinLivestreamDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinLivestreamDto value)?  $default,){
final _that = this;
switch (_that) {
case _JoinLivestreamDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String livestreamId,  String channelName,  String title,  int restaurantId,  String token,  int uid,  String? tokenExpiresAt,  int sellerId,  String? startedAt,  int? currentViewers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinLivestreamDto() when $default != null:
return $default(_that.livestreamId,_that.channelName,_that.title,_that.restaurantId,_that.token,_that.uid,_that.tokenExpiresAt,_that.sellerId,_that.startedAt,_that.currentViewers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String livestreamId,  String channelName,  String title,  int restaurantId,  String token,  int uid,  String? tokenExpiresAt,  int sellerId,  String? startedAt,  int? currentViewers)  $default,) {final _that = this;
switch (_that) {
case _JoinLivestreamDto():
return $default(_that.livestreamId,_that.channelName,_that.title,_that.restaurantId,_that.token,_that.uid,_that.tokenExpiresAt,_that.sellerId,_that.startedAt,_that.currentViewers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String livestreamId,  String channelName,  String title,  int restaurantId,  String token,  int uid,  String? tokenExpiresAt,  int sellerId,  String? startedAt,  int? currentViewers)?  $default,) {final _that = this;
switch (_that) {
case _JoinLivestreamDto() when $default != null:
return $default(_that.livestreamId,_that.channelName,_that.title,_that.restaurantId,_that.token,_that.uid,_that.tokenExpiresAt,_that.sellerId,_that.startedAt,_that.currentViewers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JoinLivestreamDto implements JoinLivestreamDto {
  const _JoinLivestreamDto({required this.livestreamId, required this.channelName, required this.title, required this.restaurantId, required this.token, required this.uid, this.tokenExpiresAt, required this.sellerId, this.startedAt, this.currentViewers});
  factory _JoinLivestreamDto.fromJson(Map<String, dynamic> json) => _$JoinLivestreamDtoFromJson(json);

@override final  String livestreamId;
@override final  String channelName;
@override final  String title;
@override final  int restaurantId;
@override final  String token;
@override final  int uid;
@override final  String? tokenExpiresAt;
@override final  int sellerId;
@override final  String? startedAt;
@override final  int? currentViewers;

/// Create a copy of JoinLivestreamDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinLivestreamDtoCopyWith<_JoinLivestreamDto> get copyWith => __$JoinLivestreamDtoCopyWithImpl<_JoinLivestreamDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinLivestreamDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinLivestreamDto&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.title, title) || other.title == title)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.token, token) || other.token == token)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.tokenExpiresAt, tokenExpiresAt) || other.tokenExpiresAt == tokenExpiresAt)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.currentViewers, currentViewers) || other.currentViewers == currentViewers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,livestreamId,channelName,title,restaurantId,token,uid,tokenExpiresAt,sellerId,startedAt,currentViewers);

@override
String toString() {
  return 'JoinLivestreamDto(livestreamId: $livestreamId, channelName: $channelName, title: $title, restaurantId: $restaurantId, token: $token, uid: $uid, tokenExpiresAt: $tokenExpiresAt, sellerId: $sellerId, startedAt: $startedAt, currentViewers: $currentViewers)';
}


}

/// @nodoc
abstract mixin class _$JoinLivestreamDtoCopyWith<$Res> implements $JoinLivestreamDtoCopyWith<$Res> {
  factory _$JoinLivestreamDtoCopyWith(_JoinLivestreamDto value, $Res Function(_JoinLivestreamDto) _then) = __$JoinLivestreamDtoCopyWithImpl;
@override @useResult
$Res call({
 String livestreamId, String channelName, String title, int restaurantId, String token, int uid, String? tokenExpiresAt, int sellerId, String? startedAt, int? currentViewers
});




}
/// @nodoc
class __$JoinLivestreamDtoCopyWithImpl<$Res>
    implements _$JoinLivestreamDtoCopyWith<$Res> {
  __$JoinLivestreamDtoCopyWithImpl(this._self, this._then);

  final _JoinLivestreamDto _self;
  final $Res Function(_JoinLivestreamDto) _then;

/// Create a copy of JoinLivestreamDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? livestreamId = null,Object? channelName = null,Object? title = null,Object? restaurantId = null,Object? token = null,Object? uid = null,Object? tokenExpiresAt = freezed,Object? sellerId = null,Object? startedAt = freezed,Object? currentViewers = freezed,}) {
  return _then(_JoinLivestreamDto(
livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as String,channelName: null == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as int,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,tokenExpiresAt: freezed == tokenExpiresAt ? _self.tokenExpiresAt : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
as String?,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as int,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String?,currentViewers: freezed == currentViewers ? _self.currentViewers : currentViewers // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
