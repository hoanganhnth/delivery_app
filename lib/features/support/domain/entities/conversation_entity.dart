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
  });

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
    );
  }

  bool get isActive => status == ConversationStatus.active;
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
      ];
}
