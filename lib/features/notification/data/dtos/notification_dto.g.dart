// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    NotificationDto(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      title: json['title'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      isRead: json['isRead'] as bool?,
      relatedEntityId: (json['relatedEntityId'] as num?)?.toInt(),
      relatedEntityType: json['relatedEntityType'] as String?,
      data: json['data'] as String?,
      sentAt: json['sentAt'] as String?,
      readAt: json['readAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$NotificationDtoToJson(NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'priority': instance.priority,
      'status': instance.status,
      'isRead': instance.isRead,
      'relatedEntityId': instance.relatedEntityId,
      'relatedEntityType': instance.relatedEntityType,
      'data': instance.data,
      'sentAt': instance.sentAt,
      'readAt': instance.readAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
