// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'livestream_comment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LivestreamCommentEntity {

 String get id; num get livestreamId; String get userId; String get userName; String? get userAvatar; String get message; DateTime get timestamp;
/// Create a copy of LivestreamCommentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamCommentEntityCopyWith<LivestreamCommentEntity> get copyWith => _$LivestreamCommentEntityCopyWithImpl<LivestreamCommentEntity>(this as LivestreamCommentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamCommentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,livestreamId,userId,userName,userAvatar,message,timestamp);

@override
String toString() {
  return 'LivestreamCommentEntity(id: $id, livestreamId: $livestreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, message: $message, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $LivestreamCommentEntityCopyWith<$Res>  {
  factory $LivestreamCommentEntityCopyWith(LivestreamCommentEntity value, $Res Function(LivestreamCommentEntity) _then) = _$LivestreamCommentEntityCopyWithImpl;
@useResult
$Res call({
 String id, num livestreamId, String userId, String userName, String? userAvatar, String message, DateTime timestamp
});




}
/// @nodoc
class _$LivestreamCommentEntityCopyWithImpl<$Res>
    implements $LivestreamCommentEntityCopyWith<$Res> {
  _$LivestreamCommentEntityCopyWithImpl(this._self, this._then);

  final LivestreamCommentEntity _self;
  final $Res Function(LivestreamCommentEntity) _then;

/// Create a copy of LivestreamCommentEntity
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
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LivestreamCommentEntity].
extension LivestreamCommentEntityPatterns on LivestreamCommentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivestreamCommentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivestreamCommentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivestreamCommentEntity value)  $default,){
final _that = this;
switch (_that) {
case _LivestreamCommentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivestreamCommentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LivestreamCommentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  num livestreamId,  String userId,  String userName,  String? userAvatar,  String message,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivestreamCommentEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  num livestreamId,  String userId,  String userName,  String? userAvatar,  String message,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _LivestreamCommentEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  num livestreamId,  String userId,  String userName,  String? userAvatar,  String message,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _LivestreamCommentEntity() when $default != null:
return $default(_that.id,_that.livestreamId,_that.userId,_that.userName,_that.userAvatar,_that.message,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _LivestreamCommentEntity extends LivestreamCommentEntity {
  const _LivestreamCommentEntity({required this.id, required this.livestreamId, required this.userId, required this.userName, this.userAvatar, required this.message, required this.timestamp}): super._();
  

@override final  String id;
@override final  num livestreamId;
@override final  String userId;
@override final  String userName;
@override final  String? userAvatar;
@override final  String message;
@override final  DateTime timestamp;

/// Create a copy of LivestreamCommentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivestreamCommentEntityCopyWith<_LivestreamCommentEntity> get copyWith => __$LivestreamCommentEntityCopyWithImpl<_LivestreamCommentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivestreamCommentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,livestreamId,userId,userName,userAvatar,message,timestamp);

@override
String toString() {
  return 'LivestreamCommentEntity(id: $id, livestreamId: $livestreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, message: $message, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$LivestreamCommentEntityCopyWith<$Res> implements $LivestreamCommentEntityCopyWith<$Res> {
  factory _$LivestreamCommentEntityCopyWith(_LivestreamCommentEntity value, $Res Function(_LivestreamCommentEntity) _then) = __$LivestreamCommentEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, num livestreamId, String userId, String userName, String? userAvatar, String message, DateTime timestamp
});




}
/// @nodoc
class __$LivestreamCommentEntityCopyWithImpl<$Res>
    implements _$LivestreamCommentEntityCopyWith<$Res> {
  __$LivestreamCommentEntityCopyWithImpl(this._self, this._then);

  final _LivestreamCommentEntity _self;
  final $Res Function(_LivestreamCommentEntity) _then;

/// Create a copy of LivestreamCommentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? livestreamId = null,Object? userId = null,Object? userName = null,Object? userAvatar = freezed,Object? message = null,Object? timestamp = null,}) {
  return _then(_LivestreamCommentEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as num,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$LivestreamLikeEntity {

 String get id; num get livestreamId; String get userId; String? get userName; String? get userAvatar; DateTime get timestamp;
/// Create a copy of LivestreamLikeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamLikeEntityCopyWith<LivestreamLikeEntity> get copyWith => _$LivestreamLikeEntityCopyWithImpl<LivestreamLikeEntity>(this as LivestreamLikeEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamLikeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,livestreamId,userId,userName,userAvatar,timestamp);

@override
String toString() {
  return 'LivestreamLikeEntity(id: $id, livestreamId: $livestreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $LivestreamLikeEntityCopyWith<$Res>  {
  factory $LivestreamLikeEntityCopyWith(LivestreamLikeEntity value, $Res Function(LivestreamLikeEntity) _then) = _$LivestreamLikeEntityCopyWithImpl;
@useResult
$Res call({
 String id, num livestreamId, String userId, String? userName, String? userAvatar, DateTime timestamp
});




}
/// @nodoc
class _$LivestreamLikeEntityCopyWithImpl<$Res>
    implements $LivestreamLikeEntityCopyWith<$Res> {
  _$LivestreamLikeEntityCopyWithImpl(this._self, this._then);

  final LivestreamLikeEntity _self;
  final $Res Function(LivestreamLikeEntity) _then;

/// Create a copy of LivestreamLikeEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? livestreamId = null,Object? userId = null,Object? userName = freezed,Object? userAvatar = freezed,Object? timestamp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as num,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LivestreamLikeEntity].
extension LivestreamLikeEntityPatterns on LivestreamLikeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivestreamLikeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivestreamLikeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivestreamLikeEntity value)  $default,){
final _that = this;
switch (_that) {
case _LivestreamLikeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivestreamLikeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LivestreamLikeEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  num livestreamId,  String userId,  String? userName,  String? userAvatar,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivestreamLikeEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  num livestreamId,  String userId,  String? userName,  String? userAvatar,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _LivestreamLikeEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  num livestreamId,  String userId,  String? userName,  String? userAvatar,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _LivestreamLikeEntity() when $default != null:
return $default(_that.id,_that.livestreamId,_that.userId,_that.userName,_that.userAvatar,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc


class _LivestreamLikeEntity extends LivestreamLikeEntity {
  const _LivestreamLikeEntity({required this.id, required this.livestreamId, required this.userId, this.userName, this.userAvatar, required this.timestamp}): super._();
  

@override final  String id;
@override final  num livestreamId;
@override final  String userId;
@override final  String? userName;
@override final  String? userAvatar;
@override final  DateTime timestamp;

/// Create a copy of LivestreamLikeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivestreamLikeEntityCopyWith<_LivestreamLikeEntity> get copyWith => __$LivestreamLikeEntityCopyWithImpl<_LivestreamLikeEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivestreamLikeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.livestreamId, livestreamId) || other.livestreamId == livestreamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,id,livestreamId,userId,userName,userAvatar,timestamp);

@override
String toString() {
  return 'LivestreamLikeEntity(id: $id, livestreamId: $livestreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$LivestreamLikeEntityCopyWith<$Res> implements $LivestreamLikeEntityCopyWith<$Res> {
  factory _$LivestreamLikeEntityCopyWith(_LivestreamLikeEntity value, $Res Function(_LivestreamLikeEntity) _then) = __$LivestreamLikeEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, num livestreamId, String userId, String? userName, String? userAvatar, DateTime timestamp
});




}
/// @nodoc
class __$LivestreamLikeEntityCopyWithImpl<$Res>
    implements _$LivestreamLikeEntityCopyWith<$Res> {
  __$LivestreamLikeEntityCopyWithImpl(this._self, this._then);

  final _LivestreamLikeEntity _self;
  final $Res Function(_LivestreamLikeEntity) _then;

/// Create a copy of LivestreamLikeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? livestreamId = null,Object? userId = null,Object? userName = freezed,Object? userAvatar = freezed,Object? timestamp = null,}) {
  return _then(_LivestreamLikeEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,livestreamId: null == livestreamId ? _self.livestreamId : livestreamId // ignore: cast_nullable_to_non_nullable
as num,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,userAvatar: freezed == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
