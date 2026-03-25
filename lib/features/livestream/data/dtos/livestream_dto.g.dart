// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LivestreamDto _$LivestreamDtoFromJson(Map<String, dynamic> json) =>
    _LivestreamDto(
      id: json['id'] as num,
      title: json['title'] as String,
      streamerId: json['streamerId'] as String,
      streamerName: json['streamerName'] as String,
      streamerAvatar: json['streamerAvatar'] as String?,
      channelName: json['channelName'] as String,
      rtcToken: json['rtcToken'] as String,
      uid: (json['uid'] as num).toInt(),
      description: json['description'] as String,
      viewerCount: (json['viewerCount'] as num).toInt(),
      likeCount: (json['likeCount'] as num).toInt(),
      status: json['status'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => LivestreamProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LivestreamDtoToJson(_LivestreamDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'streamerId': instance.streamerId,
      'streamerName': instance.streamerName,
      'streamerAvatar': instance.streamerAvatar,
      'channelName': instance.channelName,
      'rtcToken': instance.rtcToken,
      'uid': instance.uid,
      'description': instance.description,
      'viewerCount': instance.viewerCount,
      'likeCount': instance.likeCount,
      'status': instance.status,
      'thumbnailUrl': instance.thumbnailUrl,
      'coverImageUrl': instance.coverImageUrl,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'products': instance.products,
    };

_LivestreamProductDto _$LivestreamProductDtoFromJson(
  Map<String, dynamic> json,
) => _LivestreamProductDto(
  id: json['id'] as num,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
  image: json['image'] as String,
  restaurantId: json['restaurantId'] as num,
  restaurantName: json['restaurantName'] as String,
  discountPrice: (json['discountPrice'] as num?)?.toDouble(),
  description: json['description'] as String?,
  stockQuantity: (json['stockQuantity'] as num?)?.toInt(),
);

Map<String, dynamic> _$LivestreamProductDtoToJson(
  _LivestreamProductDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'image': instance.image,
  'restaurantId': instance.restaurantId,
  'restaurantName': instance.restaurantName,
  'discountPrice': instance.discountPrice,
  'description': instance.description,
  'stockQuantity': instance.stockQuantity,
};
