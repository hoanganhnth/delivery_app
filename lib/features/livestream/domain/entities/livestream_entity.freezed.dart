// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'livestream_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LivestreamEntity {

 num get id; String get title; String get streamerId; String get streamerName; String? get streamerAvatar; String get channelName; String get rtcToken; int get uid; String get description; int get viewerCount; int get likeCount; String get status;// 'live', 'upcoming', 'ended'
 String? get thumbnailUrl; String? get coverImageUrl; DateTime get startTime; DateTime? get endTime; List<LivestreamProductEntity>? get products;
/// Create a copy of LivestreamEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamEntityCopyWith<LivestreamEntity> get copyWith => _$LivestreamEntityCopyWithImpl<LivestreamEntity>(this as LivestreamEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.streamerId, streamerId) || other.streamerId == streamerId)&&(identical(other.streamerName, streamerName) || other.streamerName == streamerName)&&(identical(other.streamerAvatar, streamerAvatar) || other.streamerAvatar == streamerAvatar)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.rtcToken, rtcToken) || other.rtcToken == rtcToken)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.description, description) || other.description == description)&&(identical(other.viewerCount, viewerCount) || other.viewerCount == viewerCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other.products, products));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,streamerId,streamerName,streamerAvatar,channelName,rtcToken,uid,description,viewerCount,likeCount,status,thumbnailUrl,coverImageUrl,startTime,endTime,const DeepCollectionEquality().hash(products));

@override
String toString() {
  return 'LivestreamEntity(id: $id, title: $title, streamerId: $streamerId, streamerName: $streamerName, streamerAvatar: $streamerAvatar, channelName: $channelName, rtcToken: $rtcToken, uid: $uid, description: $description, viewerCount: $viewerCount, likeCount: $likeCount, status: $status, thumbnailUrl: $thumbnailUrl, coverImageUrl: $coverImageUrl, startTime: $startTime, endTime: $endTime, products: $products)';
}


}

/// @nodoc
abstract mixin class $LivestreamEntityCopyWith<$Res>  {
  factory $LivestreamEntityCopyWith(LivestreamEntity value, $Res Function(LivestreamEntity) _then) = _$LivestreamEntityCopyWithImpl;
@useResult
$Res call({
 num id, String title, String streamerId, String streamerName, String? streamerAvatar, String channelName, String rtcToken, int uid, String description, int viewerCount, int likeCount, String status, String? thumbnailUrl, String? coverImageUrl, DateTime startTime, DateTime? endTime, List<LivestreamProductEntity>? products
});




}
/// @nodoc
class _$LivestreamEntityCopyWithImpl<$Res>
    implements $LivestreamEntityCopyWith<$Res> {
  _$LivestreamEntityCopyWithImpl(this._self, this._then);

  final LivestreamEntity _self;
  final $Res Function(LivestreamEntity) _then;

/// Create a copy of LivestreamEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? streamerId = null,Object? streamerName = null,Object? streamerAvatar = freezed,Object? channelName = null,Object? rtcToken = null,Object? uid = null,Object? description = null,Object? viewerCount = null,Object? likeCount = null,Object? status = null,Object? thumbnailUrl = freezed,Object? coverImageUrl = freezed,Object? startTime = null,Object? endTime = freezed,Object? products = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,streamerId: null == streamerId ? _self.streamerId : streamerId // ignore: cast_nullable_to_non_nullable
as String,streamerName: null == streamerName ? _self.streamerName : streamerName // ignore: cast_nullable_to_non_nullable
as String,streamerAvatar: freezed == streamerAvatar ? _self.streamerAvatar : streamerAvatar // ignore: cast_nullable_to_non_nullable
as String?,channelName: null == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String,rtcToken: null == rtcToken ? _self.rtcToken : rtcToken // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,viewerCount: null == viewerCount ? _self.viewerCount : viewerCount // ignore: cast_nullable_to_non_nullable
as int,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,products: freezed == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<LivestreamProductEntity>?,
  ));
}

}


/// Adds pattern-matching-related methods to [LivestreamEntity].
extension LivestreamEntityPatterns on LivestreamEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivestreamEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivestreamEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivestreamEntity value)  $default,){
final _that = this;
switch (_that) {
case _LivestreamEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivestreamEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LivestreamEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num id,  String title,  String streamerId,  String streamerName,  String? streamerAvatar,  String channelName,  String rtcToken,  int uid,  String description,  int viewerCount,  int likeCount,  String status,  String? thumbnailUrl,  String? coverImageUrl,  DateTime startTime,  DateTime? endTime,  List<LivestreamProductEntity>? products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivestreamEntity() when $default != null:
return $default(_that.id,_that.title,_that.streamerId,_that.streamerName,_that.streamerAvatar,_that.channelName,_that.rtcToken,_that.uid,_that.description,_that.viewerCount,_that.likeCount,_that.status,_that.thumbnailUrl,_that.coverImageUrl,_that.startTime,_that.endTime,_that.products);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num id,  String title,  String streamerId,  String streamerName,  String? streamerAvatar,  String channelName,  String rtcToken,  int uid,  String description,  int viewerCount,  int likeCount,  String status,  String? thumbnailUrl,  String? coverImageUrl,  DateTime startTime,  DateTime? endTime,  List<LivestreamProductEntity>? products)  $default,) {final _that = this;
switch (_that) {
case _LivestreamEntity():
return $default(_that.id,_that.title,_that.streamerId,_that.streamerName,_that.streamerAvatar,_that.channelName,_that.rtcToken,_that.uid,_that.description,_that.viewerCount,_that.likeCount,_that.status,_that.thumbnailUrl,_that.coverImageUrl,_that.startTime,_that.endTime,_that.products);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num id,  String title,  String streamerId,  String streamerName,  String? streamerAvatar,  String channelName,  String rtcToken,  int uid,  String description,  int viewerCount,  int likeCount,  String status,  String? thumbnailUrl,  String? coverImageUrl,  DateTime startTime,  DateTime? endTime,  List<LivestreamProductEntity>? products)?  $default,) {final _that = this;
switch (_that) {
case _LivestreamEntity() when $default != null:
return $default(_that.id,_that.title,_that.streamerId,_that.streamerName,_that.streamerAvatar,_that.channelName,_that.rtcToken,_that.uid,_that.description,_that.viewerCount,_that.likeCount,_that.status,_that.thumbnailUrl,_that.coverImageUrl,_that.startTime,_that.endTime,_that.products);case _:
  return null;

}
}

}

/// @nodoc


class _LivestreamEntity extends LivestreamEntity {
  const _LivestreamEntity({required this.id, required this.title, required this.streamerId, required this.streamerName, this.streamerAvatar, required this.channelName, required this.rtcToken, required this.uid, required this.description, required this.viewerCount, required this.likeCount, required this.status, this.thumbnailUrl, this.coverImageUrl, required this.startTime, this.endTime, final  List<LivestreamProductEntity>? products}): _products = products,super._();
  

@override final  num id;
@override final  String title;
@override final  String streamerId;
@override final  String streamerName;
@override final  String? streamerAvatar;
@override final  String channelName;
@override final  String rtcToken;
@override final  int uid;
@override final  String description;
@override final  int viewerCount;
@override final  int likeCount;
@override final  String status;
// 'live', 'upcoming', 'ended'
@override final  String? thumbnailUrl;
@override final  String? coverImageUrl;
@override final  DateTime startTime;
@override final  DateTime? endTime;
 final  List<LivestreamProductEntity>? _products;
@override List<LivestreamProductEntity>? get products {
  final value = _products;
  if (value == null) return null;
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of LivestreamEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivestreamEntityCopyWith<_LivestreamEntity> get copyWith => __$LivestreamEntityCopyWithImpl<_LivestreamEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivestreamEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.streamerId, streamerId) || other.streamerId == streamerId)&&(identical(other.streamerName, streamerName) || other.streamerName == streamerName)&&(identical(other.streamerAvatar, streamerAvatar) || other.streamerAvatar == streamerAvatar)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.rtcToken, rtcToken) || other.rtcToken == rtcToken)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.description, description) || other.description == description)&&(identical(other.viewerCount, viewerCount) || other.viewerCount == viewerCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other._products, _products));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,streamerId,streamerName,streamerAvatar,channelName,rtcToken,uid,description,viewerCount,likeCount,status,thumbnailUrl,coverImageUrl,startTime,endTime,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'LivestreamEntity(id: $id, title: $title, streamerId: $streamerId, streamerName: $streamerName, streamerAvatar: $streamerAvatar, channelName: $channelName, rtcToken: $rtcToken, uid: $uid, description: $description, viewerCount: $viewerCount, likeCount: $likeCount, status: $status, thumbnailUrl: $thumbnailUrl, coverImageUrl: $coverImageUrl, startTime: $startTime, endTime: $endTime, products: $products)';
}


}

/// @nodoc
abstract mixin class _$LivestreamEntityCopyWith<$Res> implements $LivestreamEntityCopyWith<$Res> {
  factory _$LivestreamEntityCopyWith(_LivestreamEntity value, $Res Function(_LivestreamEntity) _then) = __$LivestreamEntityCopyWithImpl;
@override @useResult
$Res call({
 num id, String title, String streamerId, String streamerName, String? streamerAvatar, String channelName, String rtcToken, int uid, String description, int viewerCount, int likeCount, String status, String? thumbnailUrl, String? coverImageUrl, DateTime startTime, DateTime? endTime, List<LivestreamProductEntity>? products
});




}
/// @nodoc
class __$LivestreamEntityCopyWithImpl<$Res>
    implements _$LivestreamEntityCopyWith<$Res> {
  __$LivestreamEntityCopyWithImpl(this._self, this._then);

  final _LivestreamEntity _self;
  final $Res Function(_LivestreamEntity) _then;

/// Create a copy of LivestreamEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? streamerId = null,Object? streamerName = null,Object? streamerAvatar = freezed,Object? channelName = null,Object? rtcToken = null,Object? uid = null,Object? description = null,Object? viewerCount = null,Object? likeCount = null,Object? status = null,Object? thumbnailUrl = freezed,Object? coverImageUrl = freezed,Object? startTime = null,Object? endTime = freezed,Object? products = freezed,}) {
  return _then(_LivestreamEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,streamerId: null == streamerId ? _self.streamerId : streamerId // ignore: cast_nullable_to_non_nullable
as String,streamerName: null == streamerName ? _self.streamerName : streamerName // ignore: cast_nullable_to_non_nullable
as String,streamerAvatar: freezed == streamerAvatar ? _self.streamerAvatar : streamerAvatar // ignore: cast_nullable_to_non_nullable
as String?,channelName: null == channelName ? _self.channelName : channelName // ignore: cast_nullable_to_non_nullable
as String,rtcToken: null == rtcToken ? _self.rtcToken : rtcToken // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,viewerCount: null == viewerCount ? _self.viewerCount : viewerCount // ignore: cast_nullable_to_non_nullable
as int,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,products: freezed == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<LivestreamProductEntity>?,
  ));
}


}

/// @nodoc
mixin _$LivestreamProductEntity {

 num get id; String get name; double get price; String get image; num get restaurantId; String get restaurantName; double? get discountPrice; String? get description; int? get stockQuantity;
/// Create a copy of LivestreamProductEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamProductEntityCopyWith<LivestreamProductEntity> get copyWith => _$LivestreamProductEntityCopyWithImpl<LivestreamProductEntity>(this as LivestreamProductEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamProductEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.image, image) || other.image == image)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.description, description) || other.description == description)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,price,image,restaurantId,restaurantName,discountPrice,description,stockQuantity);

@override
String toString() {
  return 'LivestreamProductEntity(id: $id, name: $name, price: $price, image: $image, restaurantId: $restaurantId, restaurantName: $restaurantName, discountPrice: $discountPrice, description: $description, stockQuantity: $stockQuantity)';
}


}

/// @nodoc
abstract mixin class $LivestreamProductEntityCopyWith<$Res>  {
  factory $LivestreamProductEntityCopyWith(LivestreamProductEntity value, $Res Function(LivestreamProductEntity) _then) = _$LivestreamProductEntityCopyWithImpl;
@useResult
$Res call({
 num id, String name, double price, String image, num restaurantId, String restaurantName, double? discountPrice, String? description, int? stockQuantity
});




}
/// @nodoc
class _$LivestreamProductEntityCopyWithImpl<$Res>
    implements $LivestreamProductEntityCopyWith<$Res> {
  _$LivestreamProductEntityCopyWithImpl(this._self, this._then);

  final LivestreamProductEntity _self;
  final $Res Function(LivestreamProductEntity) _then;

/// Create a copy of LivestreamProductEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? price = null,Object? image = null,Object? restaurantId = null,Object? restaurantName = null,Object? discountPrice = freezed,Object? description = freezed,Object? stockQuantity = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as num,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,stockQuantity: freezed == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [LivestreamProductEntity].
extension LivestreamProductEntityPatterns on LivestreamProductEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivestreamProductEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivestreamProductEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivestreamProductEntity value)  $default,){
final _that = this;
switch (_that) {
case _LivestreamProductEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivestreamProductEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LivestreamProductEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num id,  String name,  double price,  String image,  num restaurantId,  String restaurantName,  double? discountPrice,  String? description,  int? stockQuantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivestreamProductEntity() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.image,_that.restaurantId,_that.restaurantName,_that.discountPrice,_that.description,_that.stockQuantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num id,  String name,  double price,  String image,  num restaurantId,  String restaurantName,  double? discountPrice,  String? description,  int? stockQuantity)  $default,) {final _that = this;
switch (_that) {
case _LivestreamProductEntity():
return $default(_that.id,_that.name,_that.price,_that.image,_that.restaurantId,_that.restaurantName,_that.discountPrice,_that.description,_that.stockQuantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num id,  String name,  double price,  String image,  num restaurantId,  String restaurantName,  double? discountPrice,  String? description,  int? stockQuantity)?  $default,) {final _that = this;
switch (_that) {
case _LivestreamProductEntity() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.image,_that.restaurantId,_that.restaurantName,_that.discountPrice,_that.description,_that.stockQuantity);case _:
  return null;

}
}

}

/// @nodoc


class _LivestreamProductEntity extends LivestreamProductEntity {
  const _LivestreamProductEntity({required this.id, required this.name, required this.price, required this.image, required this.restaurantId, required this.restaurantName, this.discountPrice, this.description, this.stockQuantity}): super._();
  

@override final  num id;
@override final  String name;
@override final  double price;
@override final  String image;
@override final  num restaurantId;
@override final  String restaurantName;
@override final  double? discountPrice;
@override final  String? description;
@override final  int? stockQuantity;

/// Create a copy of LivestreamProductEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivestreamProductEntityCopyWith<_LivestreamProductEntity> get copyWith => __$LivestreamProductEntityCopyWithImpl<_LivestreamProductEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivestreamProductEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.image, image) || other.image == image)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.description, description) || other.description == description)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,price,image,restaurantId,restaurantName,discountPrice,description,stockQuantity);

@override
String toString() {
  return 'LivestreamProductEntity(id: $id, name: $name, price: $price, image: $image, restaurantId: $restaurantId, restaurantName: $restaurantName, discountPrice: $discountPrice, description: $description, stockQuantity: $stockQuantity)';
}


}

/// @nodoc
abstract mixin class _$LivestreamProductEntityCopyWith<$Res> implements $LivestreamProductEntityCopyWith<$Res> {
  factory _$LivestreamProductEntityCopyWith(_LivestreamProductEntity value, $Res Function(_LivestreamProductEntity) _then) = __$LivestreamProductEntityCopyWithImpl;
@override @useResult
$Res call({
 num id, String name, double price, String image, num restaurantId, String restaurantName, double? discountPrice, String? description, int? stockQuantity
});




}
/// @nodoc
class __$LivestreamProductEntityCopyWithImpl<$Res>
    implements _$LivestreamProductEntityCopyWith<$Res> {
  __$LivestreamProductEntityCopyWithImpl(this._self, this._then);

  final _LivestreamProductEntity _self;
  final $Res Function(_LivestreamProductEntity) _then;

/// Create a copy of LivestreamProductEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? price = null,Object? image = null,Object? restaurantId = null,Object? restaurantName = null,Object? discountPrice = freezed,Object? description = freezed,Object? stockQuantity = freezed,}) {
  return _then(_LivestreamProductEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as num,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as num,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,stockQuantity: freezed == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
