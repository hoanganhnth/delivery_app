// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'livestream_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LivestreamDto {

 num get id; String get title;@JsonKey(name: 'streamer_id') String get streamerId;@JsonKey(name: 'streamer_name') String get streamerName;@JsonKey(name: 'streamer_avatar') String? get streamerAvatar;@JsonKey(name: 'channel_name') String get channelName;@JsonKey(name: 'rtc_token') String get rtcToken; int get uid; String get description;@JsonKey(name: 'viewer_count') int get viewerCount;@JsonKey(name: 'like_count') int get likeCount; String get status;@JsonKey(name: 'thumbnail_url') String? get thumbnailUrl;@JsonKey(name: 'cover_image_url') String? get coverImageUrl;@JsonKey(name: 'start_time') String get startTime;@JsonKey(name: 'end_time') String? get endTime; List<LivestreamProductDto>? get products;
/// Create a copy of LivestreamDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamDtoCopyWith<LivestreamDto> get copyWith => _$LivestreamDtoCopyWithImpl<LivestreamDto>(this as LivestreamDto, _$identity);

  /// Serializes this LivestreamDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.streamerId, streamerId) || other.streamerId == streamerId)&&(identical(other.streamerName, streamerName) || other.streamerName == streamerName)&&(identical(other.streamerAvatar, streamerAvatar) || other.streamerAvatar == streamerAvatar)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.rtcToken, rtcToken) || other.rtcToken == rtcToken)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.description, description) || other.description == description)&&(identical(other.viewerCount, viewerCount) || other.viewerCount == viewerCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other.products, products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,streamerId,streamerName,streamerAvatar,channelName,rtcToken,uid,description,viewerCount,likeCount,status,thumbnailUrl,coverImageUrl,startTime,endTime,const DeepCollectionEquality().hash(products));

@override
String toString() {
  return 'LivestreamDto(id: $id, title: $title, streamerId: $streamerId, streamerName: $streamerName, streamerAvatar: $streamerAvatar, channelName: $channelName, rtcToken: $rtcToken, uid: $uid, description: $description, viewerCount: $viewerCount, likeCount: $likeCount, status: $status, thumbnailUrl: $thumbnailUrl, coverImageUrl: $coverImageUrl, startTime: $startTime, endTime: $endTime, products: $products)';
}


}

/// @nodoc
abstract mixin class $LivestreamDtoCopyWith<$Res>  {
  factory $LivestreamDtoCopyWith(LivestreamDto value, $Res Function(LivestreamDto) _then) = _$LivestreamDtoCopyWithImpl;
@useResult
$Res call({
 num id, String title,@JsonKey(name: 'streamer_id') String streamerId,@JsonKey(name: 'streamer_name') String streamerName,@JsonKey(name: 'streamer_avatar') String? streamerAvatar,@JsonKey(name: 'channel_name') String channelName,@JsonKey(name: 'rtc_token') String rtcToken, int uid, String description,@JsonKey(name: 'viewer_count') int viewerCount,@JsonKey(name: 'like_count') int likeCount, String status,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl,@JsonKey(name: 'cover_image_url') String? coverImageUrl,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String? endTime, List<LivestreamProductDto>? products
});




}
/// @nodoc
class _$LivestreamDtoCopyWithImpl<$Res>
    implements $LivestreamDtoCopyWith<$Res> {
  _$LivestreamDtoCopyWithImpl(this._self, this._then);

  final LivestreamDto _self;
  final $Res Function(LivestreamDto) _then;

/// Create a copy of LivestreamDto
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
as String,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,products: freezed == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<LivestreamProductDto>?,
  ));
}

}


/// Adds pattern-matching-related methods to [LivestreamDto].
extension LivestreamDtoPatterns on LivestreamDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivestreamDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivestreamDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivestreamDto value)  $default,){
final _that = this;
switch (_that) {
case _LivestreamDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivestreamDto value)?  $default,){
final _that = this;
switch (_that) {
case _LivestreamDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num id,  String title, @JsonKey(name: 'streamer_id')  String streamerId, @JsonKey(name: 'streamer_name')  String streamerName, @JsonKey(name: 'streamer_avatar')  String? streamerAvatar, @JsonKey(name: 'channel_name')  String channelName, @JsonKey(name: 'rtc_token')  String rtcToken,  int uid,  String description, @JsonKey(name: 'viewer_count')  int viewerCount, @JsonKey(name: 'like_count')  int likeCount,  String status, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'cover_image_url')  String? coverImageUrl, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String? endTime,  List<LivestreamProductDto>? products)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivestreamDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num id,  String title, @JsonKey(name: 'streamer_id')  String streamerId, @JsonKey(name: 'streamer_name')  String streamerName, @JsonKey(name: 'streamer_avatar')  String? streamerAvatar, @JsonKey(name: 'channel_name')  String channelName, @JsonKey(name: 'rtc_token')  String rtcToken,  int uid,  String description, @JsonKey(name: 'viewer_count')  int viewerCount, @JsonKey(name: 'like_count')  int likeCount,  String status, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'cover_image_url')  String? coverImageUrl, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String? endTime,  List<LivestreamProductDto>? products)  $default,) {final _that = this;
switch (_that) {
case _LivestreamDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num id,  String title, @JsonKey(name: 'streamer_id')  String streamerId, @JsonKey(name: 'streamer_name')  String streamerName, @JsonKey(name: 'streamer_avatar')  String? streamerAvatar, @JsonKey(name: 'channel_name')  String channelName, @JsonKey(name: 'rtc_token')  String rtcToken,  int uid,  String description, @JsonKey(name: 'viewer_count')  int viewerCount, @JsonKey(name: 'like_count')  int likeCount,  String status, @JsonKey(name: 'thumbnail_url')  String? thumbnailUrl, @JsonKey(name: 'cover_image_url')  String? coverImageUrl, @JsonKey(name: 'start_time')  String startTime, @JsonKey(name: 'end_time')  String? endTime,  List<LivestreamProductDto>? products)?  $default,) {final _that = this;
switch (_that) {
case _LivestreamDto() when $default != null:
return $default(_that.id,_that.title,_that.streamerId,_that.streamerName,_that.streamerAvatar,_that.channelName,_that.rtcToken,_that.uid,_that.description,_that.viewerCount,_that.likeCount,_that.status,_that.thumbnailUrl,_that.coverImageUrl,_that.startTime,_that.endTime,_that.products);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivestreamDto extends LivestreamDto {
  const _LivestreamDto({required this.id, required this.title, @JsonKey(name: 'streamer_id') required this.streamerId, @JsonKey(name: 'streamer_name') required this.streamerName, @JsonKey(name: 'streamer_avatar') this.streamerAvatar, @JsonKey(name: 'channel_name') required this.channelName, @JsonKey(name: 'rtc_token') required this.rtcToken, required this.uid, required this.description, @JsonKey(name: 'viewer_count') required this.viewerCount, @JsonKey(name: 'like_count') required this.likeCount, required this.status, @JsonKey(name: 'thumbnail_url') this.thumbnailUrl, @JsonKey(name: 'cover_image_url') this.coverImageUrl, @JsonKey(name: 'start_time') required this.startTime, @JsonKey(name: 'end_time') this.endTime, final  List<LivestreamProductDto>? products}): _products = products,super._();
  factory _LivestreamDto.fromJson(Map<String, dynamic> json) => _$LivestreamDtoFromJson(json);

@override final  num id;
@override final  String title;
@override@JsonKey(name: 'streamer_id') final  String streamerId;
@override@JsonKey(name: 'streamer_name') final  String streamerName;
@override@JsonKey(name: 'streamer_avatar') final  String? streamerAvatar;
@override@JsonKey(name: 'channel_name') final  String channelName;
@override@JsonKey(name: 'rtc_token') final  String rtcToken;
@override final  int uid;
@override final  String description;
@override@JsonKey(name: 'viewer_count') final  int viewerCount;
@override@JsonKey(name: 'like_count') final  int likeCount;
@override final  String status;
@override@JsonKey(name: 'thumbnail_url') final  String? thumbnailUrl;
@override@JsonKey(name: 'cover_image_url') final  String? coverImageUrl;
@override@JsonKey(name: 'start_time') final  String startTime;
@override@JsonKey(name: 'end_time') final  String? endTime;
 final  List<LivestreamProductDto>? _products;
@override List<LivestreamProductDto>? get products {
  final value = _products;
  if (value == null) return null;
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of LivestreamDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivestreamDtoCopyWith<_LivestreamDto> get copyWith => __$LivestreamDtoCopyWithImpl<_LivestreamDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivestreamDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivestreamDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.streamerId, streamerId) || other.streamerId == streamerId)&&(identical(other.streamerName, streamerName) || other.streamerName == streamerName)&&(identical(other.streamerAvatar, streamerAvatar) || other.streamerAvatar == streamerAvatar)&&(identical(other.channelName, channelName) || other.channelName == channelName)&&(identical(other.rtcToken, rtcToken) || other.rtcToken == rtcToken)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.description, description) || other.description == description)&&(identical(other.viewerCount, viewerCount) || other.viewerCount == viewerCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.status, status) || other.status == status)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other._products, _products));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,streamerId,streamerName,streamerAvatar,channelName,rtcToken,uid,description,viewerCount,likeCount,status,thumbnailUrl,coverImageUrl,startTime,endTime,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'LivestreamDto(id: $id, title: $title, streamerId: $streamerId, streamerName: $streamerName, streamerAvatar: $streamerAvatar, channelName: $channelName, rtcToken: $rtcToken, uid: $uid, description: $description, viewerCount: $viewerCount, likeCount: $likeCount, status: $status, thumbnailUrl: $thumbnailUrl, coverImageUrl: $coverImageUrl, startTime: $startTime, endTime: $endTime, products: $products)';
}


}

/// @nodoc
abstract mixin class _$LivestreamDtoCopyWith<$Res> implements $LivestreamDtoCopyWith<$Res> {
  factory _$LivestreamDtoCopyWith(_LivestreamDto value, $Res Function(_LivestreamDto) _then) = __$LivestreamDtoCopyWithImpl;
@override @useResult
$Res call({
 num id, String title,@JsonKey(name: 'streamer_id') String streamerId,@JsonKey(name: 'streamer_name') String streamerName,@JsonKey(name: 'streamer_avatar') String? streamerAvatar,@JsonKey(name: 'channel_name') String channelName,@JsonKey(name: 'rtc_token') String rtcToken, int uid, String description,@JsonKey(name: 'viewer_count') int viewerCount,@JsonKey(name: 'like_count') int likeCount, String status,@JsonKey(name: 'thumbnail_url') String? thumbnailUrl,@JsonKey(name: 'cover_image_url') String? coverImageUrl,@JsonKey(name: 'start_time') String startTime,@JsonKey(name: 'end_time') String? endTime, List<LivestreamProductDto>? products
});




}
/// @nodoc
class __$LivestreamDtoCopyWithImpl<$Res>
    implements _$LivestreamDtoCopyWith<$Res> {
  __$LivestreamDtoCopyWithImpl(this._self, this._then);

  final _LivestreamDto _self;
  final $Res Function(_LivestreamDto) _then;

/// Create a copy of LivestreamDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? streamerId = null,Object? streamerName = null,Object? streamerAvatar = freezed,Object? channelName = null,Object? rtcToken = null,Object? uid = null,Object? description = null,Object? viewerCount = null,Object? likeCount = null,Object? status = null,Object? thumbnailUrl = freezed,Object? coverImageUrl = freezed,Object? startTime = null,Object? endTime = freezed,Object? products = freezed,}) {
  return _then(_LivestreamDto(
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
as String,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,products: freezed == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<LivestreamProductDto>?,
  ));
}


}


/// @nodoc
mixin _$LivestreamProductDto {

 num get id; String get name; double get price; String get image;@JsonKey(name: 'restaurant_id') num get restaurantId;@JsonKey(name: 'restaurant_name') String get restaurantName;@JsonKey(name: 'discount_price') double? get discountPrice; String? get description;@JsonKey(name: 'stock_quantity') int? get stockQuantity;
/// Create a copy of LivestreamProductDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivestreamProductDtoCopyWith<LivestreamProductDto> get copyWith => _$LivestreamProductDtoCopyWithImpl<LivestreamProductDto>(this as LivestreamProductDto, _$identity);

  /// Serializes this LivestreamProductDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivestreamProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.image, image) || other.image == image)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.description, description) || other.description == description)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,image,restaurantId,restaurantName,discountPrice,description,stockQuantity);

@override
String toString() {
  return 'LivestreamProductDto(id: $id, name: $name, price: $price, image: $image, restaurantId: $restaurantId, restaurantName: $restaurantName, discountPrice: $discountPrice, description: $description, stockQuantity: $stockQuantity)';
}


}

/// @nodoc
abstract mixin class $LivestreamProductDtoCopyWith<$Res>  {
  factory $LivestreamProductDtoCopyWith(LivestreamProductDto value, $Res Function(LivestreamProductDto) _then) = _$LivestreamProductDtoCopyWithImpl;
@useResult
$Res call({
 num id, String name, double price, String image,@JsonKey(name: 'restaurant_id') num restaurantId,@JsonKey(name: 'restaurant_name') String restaurantName,@JsonKey(name: 'discount_price') double? discountPrice, String? description,@JsonKey(name: 'stock_quantity') int? stockQuantity
});




}
/// @nodoc
class _$LivestreamProductDtoCopyWithImpl<$Res>
    implements $LivestreamProductDtoCopyWith<$Res> {
  _$LivestreamProductDtoCopyWithImpl(this._self, this._then);

  final LivestreamProductDto _self;
  final $Res Function(LivestreamProductDto) _then;

/// Create a copy of LivestreamProductDto
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


/// Adds pattern-matching-related methods to [LivestreamProductDto].
extension LivestreamProductDtoPatterns on LivestreamProductDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivestreamProductDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivestreamProductDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivestreamProductDto value)  $default,){
final _that = this;
switch (_that) {
case _LivestreamProductDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivestreamProductDto value)?  $default,){
final _that = this;
switch (_that) {
case _LivestreamProductDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num id,  String name,  double price,  String image, @JsonKey(name: 'restaurant_id')  num restaurantId, @JsonKey(name: 'restaurant_name')  String restaurantName, @JsonKey(name: 'discount_price')  double? discountPrice,  String? description, @JsonKey(name: 'stock_quantity')  int? stockQuantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivestreamProductDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num id,  String name,  double price,  String image, @JsonKey(name: 'restaurant_id')  num restaurantId, @JsonKey(name: 'restaurant_name')  String restaurantName, @JsonKey(name: 'discount_price')  double? discountPrice,  String? description, @JsonKey(name: 'stock_quantity')  int? stockQuantity)  $default,) {final _that = this;
switch (_that) {
case _LivestreamProductDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num id,  String name,  double price,  String image, @JsonKey(name: 'restaurant_id')  num restaurantId, @JsonKey(name: 'restaurant_name')  String restaurantName, @JsonKey(name: 'discount_price')  double? discountPrice,  String? description, @JsonKey(name: 'stock_quantity')  int? stockQuantity)?  $default,) {final _that = this;
switch (_that) {
case _LivestreamProductDto() when $default != null:
return $default(_that.id,_that.name,_that.price,_that.image,_that.restaurantId,_that.restaurantName,_that.discountPrice,_that.description,_that.stockQuantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivestreamProductDto extends LivestreamProductDto {
  const _LivestreamProductDto({required this.id, required this.name, required this.price, required this.image, @JsonKey(name: 'restaurant_id') required this.restaurantId, @JsonKey(name: 'restaurant_name') required this.restaurantName, @JsonKey(name: 'discount_price') this.discountPrice, this.description, @JsonKey(name: 'stock_quantity') this.stockQuantity}): super._();
  factory _LivestreamProductDto.fromJson(Map<String, dynamic> json) => _$LivestreamProductDtoFromJson(json);

@override final  num id;
@override final  String name;
@override final  double price;
@override final  String image;
@override@JsonKey(name: 'restaurant_id') final  num restaurantId;
@override@JsonKey(name: 'restaurant_name') final  String restaurantName;
@override@JsonKey(name: 'discount_price') final  double? discountPrice;
@override final  String? description;
@override@JsonKey(name: 'stock_quantity') final  int? stockQuantity;

/// Create a copy of LivestreamProductDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivestreamProductDtoCopyWith<_LivestreamProductDto> get copyWith => __$LivestreamProductDtoCopyWithImpl<_LivestreamProductDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivestreamProductDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivestreamProductDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.image, image) || other.image == image)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&(identical(other.description, description) || other.description == description)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,price,image,restaurantId,restaurantName,discountPrice,description,stockQuantity);

@override
String toString() {
  return 'LivestreamProductDto(id: $id, name: $name, price: $price, image: $image, restaurantId: $restaurantId, restaurantName: $restaurantName, discountPrice: $discountPrice, description: $description, stockQuantity: $stockQuantity)';
}


}

/// @nodoc
abstract mixin class _$LivestreamProductDtoCopyWith<$Res> implements $LivestreamProductDtoCopyWith<$Res> {
  factory _$LivestreamProductDtoCopyWith(_LivestreamProductDto value, $Res Function(_LivestreamProductDto) _then) = __$LivestreamProductDtoCopyWithImpl;
@override @useResult
$Res call({
 num id, String name, double price, String image,@JsonKey(name: 'restaurant_id') num restaurantId,@JsonKey(name: 'restaurant_name') String restaurantName,@JsonKey(name: 'discount_price') double? discountPrice, String? description,@JsonKey(name: 'stock_quantity') int? stockQuantity
});




}
/// @nodoc
class __$LivestreamProductDtoCopyWithImpl<$Res>
    implements _$LivestreamProductDtoCopyWith<$Res> {
  __$LivestreamProductDtoCopyWithImpl(this._self, this._then);

  final _LivestreamProductDto _self;
  final $Res Function(_LivestreamProductDto) _then;

/// Create a copy of LivestreamProductDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? price = null,Object? image = null,Object? restaurantId = null,Object? restaurantName = null,Object? discountPrice = freezed,Object? description = freezed,Object? stockQuantity = freezed,}) {
  return _then(_LivestreamProductDto(
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
