import 'package:equatable/equatable.dart';
import 'chat_message_entity.dart';

enum ConversationStatus {
  active,
  closed,
}

class ConversationEntity extends Equatable {
  final String id;
  final int userId;
  final String userEmail;
  final String? userName;
  final ConversationStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ChatMessageEntity? lastMessage;
  final int unreadCount;
  final DateTime? closedAt; // ✅ Thêm
  final String? closedBy; // ✅ Thêm: 'user' hoặc 'support'
  final String? closeReason; // ✅ Thêm

  const ConversationEntity({
    required this.id,
    required this.userId,
    required this.userEmail,
    this.userName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
    this.unreadCount = 0,
    this.closedAt, // ✅ Thêm
    this.closedBy, // ✅ Thêm
    this.closeReason, // ✅ Thêm
  });

  // ✅ Thêm helper methods
  bool get isActive => status == ConversationStatus.active;
  bool get isClosed => status == ConversationStatus.closed;

  ConversationEntity copyWith({
    String? id,
    int? userId,
    String? userEmail,
    String? userName,
    ConversationStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    ChatMessageEntity? lastMessage,
    int? unreadCount,
    DateTime? closedAt, // ✅ Thêm
    String? closedBy, // ✅ Thêm
    String? closeReason, // ✅ Thêm
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      closedAt: closedAt ?? this.closedAt, // ✅ Thêm
      closedBy: closedBy ?? this.closedBy, // ✅ Thêm
      closeReason: closeReason ?? this.closeReason, // ✅ Thêm
    );
  }

  bool get hasUnread => unreadCount > 0;

  @override
  List<Object?> get props => [
        id,
        userId,
        userEmail,
        userName,
        status,
        createdAt,
        updatedAt,
        lastMessage,
        unreadCount,
        closedAt, // ✅ Thêm
        closedBy, // ✅ Thêm
        closeReason, // ✅ Thêm
      ];
}
