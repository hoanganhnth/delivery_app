// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'livestream_comment_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LivestreamCommentDto {

 String get id;@JsonKey(name: 'livestream_id') num get livestreamId;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'user_name') String get userName;@JsonKey(name: 'user_avatar') String? get userAvatar; String get message; int get timestamp;
/// Create a copy of LivestreamCommentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamCommentDtoCopyWith<LivestreamCommentDto> get copyWith => _$LivestreamCommentDtoCopyWithImpl<LivestreamCommentDto>(this as LivestreamCommentDto, _$identity);

  /// Serializes this LivestreamCommentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamCommentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,livestreamId,userId,userName,userAvatar,message,timestamp);

@override
String toString() {
  return 'LivestreamCommentDto(id: $id, livestreamId: $livestreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, message: $message, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $LivestreamCommentDtoCopyWith<$Res>  {
  factory $LivestreamCommentDtoCopyWith(LivestreamCommentDto value, $Res Function(LivestreamCommentDto) _then) = _$LivestreamCommentDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'livestream_id') num livestreamId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String userName,@JsonKey(name: 'user_avatar') String? userAvatar, String message, int timestamp
});




}
/// @nodoc
class _$LivestreamCommentDtoCopyWithImpl<$Res>
    implements $LivestreamCommentDtoCopyWith<$Res> {
  _$LivestreamCommentDtoCopyWithImpl(this._self, this._then);

  final LivestreamCommentDto _self;
  final $Res Function(LivestreamCommentDto) _then;

/// Create a copy of LivestreamCommentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? livestreamId = null,Object? userId = null,Object? userName = null,Object? userAvatar = freezed,Object? message = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as num,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LivestreamCommentDto].
extension LivestreamCommentDtoPatterns on LivestreamCommentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivestreamCommentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivestreamCommentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivestreamCommentDto value)  $default,){
final _that = this;
switch (_that) {
case _LivestreamCommentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivestreamCommentDto value)?  $default,){
final _that = this;
switch (_that) {
case _LivestreamCommentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'livestream_id')  num livestreamId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName, @JsonKey(name: 'user_avatar')  String? userAvatar,  String message,  int timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivestreamCommentDto() when $default != null:
return $default(_that.id,_that.livestreamId,_that.userId,_that.userName,_that.userAvatar,_that.message,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'livestream_id')  num livestreamId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName, @JsonKey(name: 'user_avatar')  String? userAvatar,  String message,  int timestamp)  $default,) {final _that = this;
switch (_that) {
case _LivestreamCommentDto():
return $default(_that.id,_that.livestreamId,_that.userId,_that.userName,_that.userAvatar,_that.message,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'livestream_id')  num livestreamId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String userName, @JsonKey(name: 'user_avatar')  String? userAvatar,  String message,  int timestamp)?  $default,) {final _that = this;
switch (_that) {
case _LivestreamCommentDto() when $default != null:
return $default(_that.id,_that.livestreamId,_that.userId,_that.userName,_that.userAvatar,_that.message,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivestreamCommentDto extends LivestreamCommentDto {
  const _LivestreamCommentDto({required this.id, @JsonKey(name: 'livestream_id') required this.livestreamId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'user_name') required this.userName, @JsonKey(name: 'user_avatar') this.userAvatar, required this.message, required this.timestamp}): super._();
  factory _LivestreamCommentDto.fromJson(Map<String, dynamic> json) => _$LivestreamCommentDtoFromJson(json);

@override final  String id;
@override@JsonKey(name: 'livestream_id') final  num livestreamId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'user_name') final  String userName;
@override@JsonKey(name: 'user_avatar') final  String? userAvatar;
@override final  String message;
@override final  int timestamp;

/// Create a copy of LivestreamCommentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivestreamCommentDtoCopyWith<_LivestreamCommentDto> get copyWith => __$LivestreamCommentDtoCopyWithImpl<_LivestreamCommentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivestreamCommentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivestreamCommentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,livestreamId,userId,userName,userAvatar,message,timestamp);

@override
String toString() {
  return 'LivestreamCommentDto(id: $id, livestreamId: $livestreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, message: $message, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$LivestreamCommentDtoCopyWith<$Res> implements $LivestreamCommentDtoCopyWith<$Res> {
  factory _$LivestreamCommentDtoCopyWith(_LivestreamCommentDto value, $Res Function(_LivestreamCommentDto) _then) = __$LivestreamCommentDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'livestream_id') num livestreamId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String userName,@JsonKey(name: 'user_avatar') String? userAvatar, String message, int timestamp
});




}
/// @nodoc
class __$LivestreamCommentDtoCopyWithImpl<$Res>
    implements _$LivestreamCommentDtoCopyWith<$Res> {
  __$LivestreamCommentDtoCopyWithImpl(this._self, this._then);

  final _LivestreamCommentDto _self;
  final $Res Function(_LivestreamCommentDto) _then;

/// Create a copy of LivestreamCommentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? livestreamId = null,Object? userId = null,Object? userName = null,Object? userAvatar = freezed,Object? message = null,Object? timestamp = null,}) {
  return _then(_LivestreamCommentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as num,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LivestreamLikeDto {

 String get id;@JsonKey(name: 'livestream_id') num get livestreamId;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'user_name') String? get userName;@JsonKey(name: 'user_avatar') String? get userAvatar; int get timestamp;
/// Create a copy of LivestreamLikeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamLikeDtoCopyWith<LivestreamLikeDto> get copyWith => _$LivestreamLikeDtoCopyWithImpl<LivestreamLikeDto>(this as LivestreamLikeDto, _$identity);

  /// Serializes this LivestreamLikeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamLikeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,livestreamId,userId,userName,userAvatar,timestamp);

@override
String toString() {
  return 'LivestreamLikeDto(id: $id, livestreamId: $livestreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $LivestreamLikeDtoCopyWith<$Res>  {
  factory $LivestreamLikeDtoCopyWith(LivestreamLikeDto value, $Res Function(LivestreamLikeDto) _then) = _$LivestreamLikeDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'livestream_id') num livestreamId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String? userName,@JsonKey(name: 'user_avatar') String? userAvatar, int timestamp
});




}
/// @nodoc
class _$LivestreamLikeDtoCopyWithImpl<$Res>
    implements $LivestreamLikeDtoCopyWith<$Res> {
  _$LivestreamLikeDtoCopyWithImpl(this._self, this._then);

  final LivestreamLikeDto _self;
  final $Res Function(LivestreamLikeDto) _then;

/// Create a copy of LivestreamLikeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? livestreamId = null,Object? userId = null,Object? userName = freezed,Object? userAvatar = freezed,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as num,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LivestreamLikeDto].
extension LivestreamLikeDtoPatterns on LivestreamLikeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivestreamLikeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivestreamLikeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivestreamLikeDto value)  $default,){
final _that = this;
switch (_that) {
case _LivestreamLikeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivestreamLikeDto value)?  $default,){
final _that = this;
switch (_that) {
case _LivestreamLikeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'livestream_id')  num livestreamId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName, @JsonKey(name: 'user_avatar')  String? userAvatar,  int timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivestreamLikeDto() when $default != null:
return $default(_that.id,_that.livestreamId,_that.userId,_that.userName,_that.userAvatar,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'livestream_id')  num livestreamId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName, @JsonKey(name: 'user_avatar')  String? userAvatar,  int timestamp)  $default,) {final _that = this;
switch (_that) {
case _LivestreamLikeDto():
return $default(_that.id,_that.livestreamId,_that.userId,_that.userName,_that.userAvatar,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'livestream_id')  num livestreamId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'user_name')  String? userName, @JsonKey(name: 'user_avatar')  String? userAvatar,  int timestamp)?  $default,) {final _that = this;
switch (_that) {
case _LivestreamLikeDto() when $default != null:
return $default(_that.id,_that.livestreamId,_that.userId,_that.userName,_that.userAvatar,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivestreamLikeDto extends LivestreamLikeDto {
  const _LivestreamLikeDto({required this.id, @JsonKey(name: 'livestream_id') required this.livestreamId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'user_name') this.userName, @JsonKey(name: 'user_avatar') this.userAvatar, required this.timestamp}): super._();
  factory _LivestreamLikeDto.fromJson(Map<String, dynamic> json) => _$LivestreamLikeDtoFromJson(json);

@override final  String id;
@override@JsonKey(name: 'livestream_id') final  num livestreamId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'user_name') final  String? userName;
@override@JsonKey(name: 'user_avatar') final  String? userAvatar;
@override final  int timestamp;

/// Create a copy of LivestreamLikeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivestreamLikeDtoCopyWith<_LivestreamLikeDto> get copyWith => __$LivestreamLikeDtoCopyWithImpl<_LivestreamLikeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivestreamLikeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivestreamLikeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,livestreamId,userId,userName,userAvatar,timestamp);

@override
String toString() {
  return 'LivestreamLikeDto(id: $id, livestreamId: $livestreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$LivestreamLikeDtoCopyWith<$Res> implements $LivestreamLikeDtoCopyWith<$Res> {
  factory _$LivestreamLikeDtoCopyWith(_LivestreamLikeDto value, $Res Function(_LivestreamLikeDto) _then) = __$LivestreamLikeDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'livestream_id') num livestreamId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'user_name') String? userName,@JsonKey(name: 'user_avatar') String? userAvatar, int timestamp
});




}
/// @nodoc
class __$LivestreamLikeDtoCopyWithImpl<$Res>
    implements _$LivestreamLikeDtoCopyWith<$Res> {
  __$LivestreamLikeDtoCopyWithImpl(this._self, this._then);

  final _LivestreamLikeDto _self;
  final $Res Function(_LivestreamLikeDto) _then;

/// Create a copy of LivestreamLikeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? livestreamId = null,Object? userId = null,Object? userName = freezed,Object? userAvatar = freezed,Object? timestamp = null,}) {
  return _then(_LivestreamLikeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as num,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
