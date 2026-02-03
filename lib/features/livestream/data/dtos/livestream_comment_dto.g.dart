// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LivestreamCommentDto _$LivestreamCommentDtoFromJson(
  Map<String, dynamic> json,
) => _LivestreamCommentDto(
  id: json['id'] as String,
  livestreamId: json['livestream_id'] as num,
  userId: json['user_id'] as String,
  userName: json['user_name'] as String,
  userAvatar: json['user_avatar'] as String?,
  message: json['message'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
);

Map<String, dynamic> _$LivestreamCommentDtoToJson(
  _LivestreamCommentDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'livestream_id': instance.livestreamId,
  'user_id': instance.userId,
  'user_name': instance.userName,
  'user_avatar': instance.userAvatar,
  'message': instance.message,
  'timestamp': instance.timestamp,
};

_LivestreamLikeDto _$LivestreamLikeDtoFromJson(Map<String, dynamic> json) =>
    _LivestreamLikeDto(
      id: json['id'] as String,
      livestreamId: json['livestream_id'] as num,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String?,
      userAvatar: json['user_avatar'] as String?,
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$LivestreamLikeDtoToJson(_LivestreamLikeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'livestream_id': instance.livestreamId,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_avatar': instance.userAvatar,
      'timestamp': instance.timestamp,
    };
