import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel {
  final String id;
  final String conversationId;
  final String content;
  final String type; // 'text', 'image', 'video'
  final String sender; // 'user', 'support'
  final String? mediaUrl;
  final String? thumbnailUrl;
  final Timestamp timestamp;
  final bool isRead;

  ChatMessageModel({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.type,
    required this.sender,
    this.mediaUrl,
    this.thumbnailUrl,
    required this.timestamp,
    this.isRead = false,
  });

  factory ChatMessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessageModel(
      id: doc.id,
      conversationId: data['conversationId'] ?? '',
      content: data['content'] ?? '',
      type: data['type'] ?? 'text',
      sender: data['sender'] ?? 'user',
      mediaUrl: data['mediaUrl'],
      thumbnailUrl: data['thumbnailUrl'],
      timestamp: data['timestamp'] ?? Timestamp.now(),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'conversationId': conversationId,
      'content': content,
      'type': type,
      'sender': sender,
      'mediaUrl': mediaUrl,
      'thumbnailUrl': thumbnailUrl,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: id,
      conversationId: conversationId,
      content: content,
      type: _parseMessageType(type),
      sender: _parseMessageSender(sender),
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      timestamp: timestamp.toDate(),
      isRead: isRead,
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      id: entity.id,
      conversationId: entity.conversationId,
      content: entity.content,
      type: _messageTypeToString(entity.type),
      sender: _messageSenderToString(entity.sender),
      mediaUrl: entity.mediaUrl,
      thumbnailUrl: entity.thumbnailUrl,
      timestamp: Timestamp.fromDate(entity.timestamp),
      isRead: entity.isRead,
    );
  }

  static MessageType _parseMessageType(String type) {
    switch (type) {
      case 'image':
        return MessageType.image;
      case 'video':
        return MessageType.video;
      default:
        return MessageType.text;
    }
  }

  static MessageSender _parseMessageSender(String sender) {
    return sender == 'support' ? MessageSender.support : MessageSender.user;
  }

  static String _messageTypeToString(MessageType type) {
    switch (type) {
      case MessageType.image:
        return 'image';
      case MessageType.video:
        return 'video';
      case MessageType.text:
        return 'text';
    }
  }

  static String _messageSenderToString(MessageSender sender) {
    return sender == MessageSender.support ? 'support' : 'user';
  }
}
