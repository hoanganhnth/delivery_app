// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LivestreamCommentDto _$LivestreamCommentDtoFromJson(
  Map<String, dynamic> json,
) => _LivestreamCommentDto(
  id: json['id'] as String,
  livestreamId: json['livestreamId'] as num,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  userAvatar: json['userAvatar'] as String?,
  message: json['message'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
);

Map<String, dynamic> _$LivestreamCommentDtoToJson(
  _LivestreamCommentDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'livestreamId': instance.livestreamId,
  'userId': instance.userId,
  'userName': instance.userName,
  'userAvatar': instance.userAvatar,
  'message': instance.message,
  'timestamp': instance.timestamp,
};

_LivestreamLikeDto _$LivestreamLikeDtoFromJson(Map<String, dynamic> json) =>
    _LivestreamLikeDto(
      id: json['id'] as String,
      livestreamId: json['livestreamId'] as num,
      userId: json['userId'] as String,
      userName: json['userName'] as String?,
      userAvatar: json['userAvatar'] as String?,
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$LivestreamLikeDtoToJson(_LivestreamLikeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'livestreamId': instance.livestreamId,
      'userId': instance.userId,
      'userName': instance.userName,
      'userAvatar': instance.userAvatar,
      'timestamp': instance.timestamp,
    };
