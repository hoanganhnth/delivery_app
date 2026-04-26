/// Domain entity for Notification
class NotificationEntity {
  final int id;
  final int userId;
  final String title;
  final String message;
  final String type;
  final String priority;
  final String status;
  final bool isRead;
  final int? relatedEntityId;
  final String? relatedEntityType;
  final String? data;
  final DateTime? sentAt;
  final DateTime? readAt;
  final DateTime createdAt;

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    required this.status,
    required this.isRead,
    this.relatedEntityId,
    this.relatedEntityType,
    this.data,
    this.sentAt,
    this.readAt,
    required this.createdAt,
  });

  NotificationEntity copyWith({
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
    DateTime? sentAt,
    DateTime? readAt,
    DateTime? createdAt,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      isRead: isRead ?? this.isRead,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
      relatedEntityType: relatedEntityType ?? this.relatedEntityType,
      data: data ?? this.data,
      sentAt: sentAt ?? this.sentAt,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
