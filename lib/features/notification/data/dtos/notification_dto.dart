import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_dto.g.dart';
part 'notification_dto.freezed.dart';

@freezed
sealed class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    int? id,
    int? userId,
    String? title,
    String? message,
    String? type,
    String? priority,
    String? status,
    bool? isRead,
    int? relatedEntityId,
    String? relatedEntityType,
    String? data,
    String? sentAt,
    String? readAt,
    String? createdAt,
    String? updatedAt,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}
