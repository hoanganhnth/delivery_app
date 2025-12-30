import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/conversation_entity.dart';
import 'chat_message_model.dart';

class ConversationModel {
  final String id;
  final int userId;
  final String userEmail;
  final String? userName;
  final String status; // 'active', 'closed'
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final Map<String, dynamic>? lastMessage;
  final int unreadCount;

  ConversationModel({
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

  factory ConversationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ConversationModel(
      id: doc.id,
      userId: data['userId'] ?? 0,
      userEmail: data['userEmail'] ?? '',
      userName: data['userName'],
      status: data['status'] ?? 'active',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
      lastMessage: data['lastMessage'],
      unreadCount: data['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userName': userName,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lastMessage': lastMessage,
      'unreadCount': unreadCount,
    };
  }

  ConversationEntity toEntity() {
    return ConversationEntity(
      id: id,
      userId: userId,
      userEmail: userEmail,
      userName: userName,
      status: status == 'closed' ? ConversationStatus.closed : ConversationStatus.active,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
      lastMessage: lastMessage != null
          ? ChatMessageModel(
              id: lastMessage!['id'] ?? '',
              conversationId: id,
              content: lastMessage!['content'] ?? '',
              type: lastMessage!['type'] ?? 'text',
              sender: lastMessage!['sender'] ?? 'user',
              mediaUrl: lastMessage!['mediaUrl'],
              thumbnailUrl: lastMessage!['thumbnailUrl'],
              timestamp: lastMessage!['timestamp'] ?? Timestamp.now(),
              isRead: lastMessage!['isRead'] ?? false,
            ).toEntity()
          : null,
      unreadCount: unreadCount,
    );
  }
}
