import 'package:equatable/equatable.dart';

enum MessageType {
  text,
  image,
  video,
}

enum MessageSender {
  user,
  support,
}

class ChatMessageEntity extends Equatable {
  final String id;
  final String conversationId;
  final String content;
  final MessageType type;
  final MessageSender sender;
  final String? mediaUrl;
  final String? thumbnailUrl;
  final DateTime timestamp;
  final bool isRead;

  const ChatMessageEntity({
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

  ChatMessageEntity copyWith({
    String? id,
    String? conversationId,
    String? content,
    MessageType? type,
    MessageSender? sender,
    String? mediaUrl,
    String? thumbnailUrl,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      content: content ?? this.content,
      type: type ?? this.type,
      sender: sender ?? this.sender,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  bool get isFromUser => sender == MessageSender.user;
  bool get isFromSupport => sender == MessageSender.support;
  bool get hasMedia => mediaUrl != null && mediaUrl!.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        conversationId,
        content,
        type,
        sender,
        mediaUrl,
        thumbnailUrl,
        timestamp,
        isRead,
      ];
}
