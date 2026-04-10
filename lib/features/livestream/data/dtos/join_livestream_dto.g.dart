// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_livestream_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JoinLivestreamDto _$JoinLivestreamDtoFromJson(Map<String, dynamic> json) =>
    _JoinLivestreamDto(
      livestreamId: json['livestreamId'] as String,
      channelName: json['channelName'] as String,
      title: json['title'] as String,
      restaurantId: (json['restaurantId'] as num).toInt(),
      token: json['token'] as String,
      uid: (json['uid'] as num).toInt(),
      tokenExpiresAt: json['tokenExpiresAt'] as String?,
      sellerId: (json['sellerId'] as num).toInt(),
      startedAt: json['startedAt'] as String?,
      currentViewers: (json['currentViewers'] as num?)?.toInt(),
    );

Map<String, dynamic> _$JoinLivestreamDtoToJson(_JoinLivestreamDto instance) =>
    <String, dynamic>{
      'livestreamId': instance.livestreamId,
      'channelName': instance.channelName,
      'title': instance.title,
      'restaurantId': instance.restaurantId,
      'token': instance.token,
      'uid': instance.uid,
      'tokenExpiresAt': instance.tokenExpiresAt,
      'sellerId': instance.sellerId,
      'startedAt': instance.startedAt,
      'currentViewers': instance.currentViewers,
    };
