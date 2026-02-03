// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LivestreamDto _$LivestreamDtoFromJson(Map<String, dynamic> json) =>
    _LivestreamDto(
      id: json['id'] as num,
      title: json['title'] as String,
      streamerId: json['streamer_id'] as String,
      streamerName: json['streamer_name'] as String,
      streamerAvatar: json['streamer_avatar'] as String?,
      channelName: json['channel_name'] as String,
      rtcToken: json['rtc_token'] as String,
      uid: (json['uid'] as num).toInt(),
      description: json['description'] as String,
      viewerCount: (json['viewer_count'] as num).toInt(),
      likeCount: (json['like_count'] as num).toInt(),
      status: json['status'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String?,
      products:
          (json['products'] as List<dynamic>?)
              ?.map(
                (e) => LivestreamProductDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$LivestreamDtoToJson(_LivestreamDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'streamer_id': instance.streamerId,
      'streamer_name': instance.streamerName,
      'streamer_avatar': instance.streamerAvatar,
      'channel_name': instance.channelName,
      'rtc_token': instance.rtcToken,
      'uid': instance.uid,
      'description': instance.description,
      'viewer_count': instance.viewerCount,
      'like_count': instance.likeCount,
      'status': instance.status,
      'thumbnail_url': instance.thumbnailUrl,
      'cover_image_url': instance.coverImageUrl,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'products': instance.products,
    };

_LivestreamProductDto _$LivestreamProductDtoFromJson(
  Map<String, dynamic> json,
) => _LivestreamProductDto(
  id: json['id'] as num,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  image: json['image'] as String,
  restaurantId: json['restaurant_id'] as num,
  restaurantName: json['restaurant_name'] as String,
  discountPrice: (json['discount_price'] as num?)?.toDouble(),
  description: json['description'] as String?,
  stockQuantity: (json['stock_quantity'] as num?)?.toInt(),
);

Map<String, dynamic> _$LivestreamProductDtoToJson(
  _LivestreamProductDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'image': instance.image,
  'restaurant_id': instance.restaurantId,
  'restaurant_name': instance.restaurantName,
  'discount_price': instance.discountPrice,
  'description': instance.description,
  'stock_quantity': instance.stockQuantity,
};
