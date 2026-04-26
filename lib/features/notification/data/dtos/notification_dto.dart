import 'package:json_annotation/json_annotation.dart';

part 'notification_dto.g.dart';

@JsonSerializable()
class NotificationDto {
  final int? id;
  final int? userId;
  final String? title;
  final String? message;
  final String? type;
  final String? priority;
  final String? status;
  final bool? isRead;
  final int? relatedEntityId;
  final String? relatedEntityType;
  final String? data;
  final String? sentAt;
  final String? readAt;
  final String? createdAt;
  final String? updatedAt;

  const NotificationDto({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.type,
    this.priority,
    this.status,
    this.isRead,
    this.relatedEntityId,
    this.relatedEntityType,
    this.data,
    this.sentAt,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);
}
