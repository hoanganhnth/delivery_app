import '../../domain/entities/notification_entity.dart';
import '../dtos/notification_dto.dart';

const _notificationPriorities = {'HIGH', 'MEDIUM', 'LOW'};
const _notificationStatuses = {
  'PENDING',
  'SENT',
  'DELIVERED',
  'FAILED',
  'READ',
};

extension NotificationDtoMapper on NotificationDto {
  NotificationEntity toEntityStrict() {
    final notificationId = id;
    final ownerId = userId;
    final normalizedTitle = title?.trim();
    final normalizedMessage = message?.trim();
    final normalizedType = type?.trim();
    final normalizedPriority = priority?.trim().toUpperCase();
    final normalizedStatus = status?.trim().toUpperCase();
    final notificationRead = isRead;
    final createdTimestamp = _parseRequiredDate(createdAt, 'createdAt');

    if (notificationId == null || notificationId <= 0) {
      throw const FormatException('Notification id must be positive');
    }
    if (ownerId == null || ownerId <= 0) {
      throw const FormatException('Notification user id must be positive');
    }
    if (normalizedTitle == null || normalizedTitle.isEmpty) {
      throw const FormatException('Notification title is required');
    }
    if (normalizedMessage == null || normalizedMessage.isEmpty) {
      throw const FormatException('Notification message is required');
    }
    if (normalizedType == null || normalizedType.isEmpty) {
      throw const FormatException('Notification type is required');
    }
    if (!_notificationPriorities.contains(normalizedPriority)) {
      throw const FormatException('Unknown notification priority');
    }
    if (!_notificationStatuses.contains(normalizedStatus)) {
      throw const FormatException('Unknown notification status');
    }
    if (notificationRead == null) {
      throw const FormatException('Notification read state is required');
    }
    if (relatedEntityId != null && relatedEntityId! <= 0) {
      throw const FormatException(
        'Related entity id must be positive when present',
      );
    }

    return NotificationEntity(
      id: notificationId,
      userId: ownerId,
      title: normalizedTitle,
      message: normalizedMessage,
      type: normalizedType,
      priority: normalizedPriority!,
      status: normalizedStatus!,
      isRead: notificationRead,
      relatedEntityId: relatedEntityId,
      relatedEntityType: _optionalTrimmed(relatedEntityType),
      data: data,
      sentAt: _parseOptionalDate(sentAt, 'sentAt'),
      readAt: _parseOptionalDate(readAt, 'readAt'),
      createdAt: createdTimestamp,
    );
  }
}

String? _optionalTrimmed(String? value) {
  final normalized = value?.trim();
  return normalized == null || normalized.isEmpty ? null : normalized;
}

DateTime? _parseOptionalDate(String? value, String field) {
  return value == null ? null : _parseRequiredDate(value, field);
}

DateTime _parseRequiredDate(String? value, String field) {
  final parsed = value == null ? null : DateTime.tryParse(value);
  if (parsed == null) {
    throw FormatException('$field must be an ISO-8601 timestamp');
  }
  return parsed;
}
