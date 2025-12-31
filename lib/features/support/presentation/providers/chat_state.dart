import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/conversation_entity.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
  error,
  sending,
}

class ChatState extends Equatable {
  final ChatStatus status;
  final ConversationEntity? conversation;
  final List<ChatMessageEntity> messages;
  final String? errorMessage;
  final bool isSendingMessage;
  
  // ✅ Pagination fields
  final bool isLoadingMore;
  final bool hasMoreMessages;
  final int pageSize;

  const ChatState({
    this.status = ChatStatus.initial,
    this.conversation,
    this.messages = const [],
    this.errorMessage,
    this.isSendingMessage = false,
    this.isLoadingMore = false,
    this.hasMoreMessages = true,
    this.pageSize = 10,
  });

  ChatState copyWith({
    ChatStatus? status,
    ConversationEntity? conversation,
    List<ChatMessageEntity>? messages,
    String? errorMessage,
    bool? isSendingMessage,
    bool? isLoadingMore,
    bool? hasMoreMessages,
  }) {
    return ChatState(
      status: status ?? this.status,
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      errorMessage: errorMessage,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreMessages: hasMoreMessages ?? this.hasMoreMessages,
    );
  }

  bool get isLoading => status == ChatStatus.loading;
  bool get hasError => status == ChatStatus.error;
  bool get hasConversation => conversation != null;
  ChatMessageEntity? get oldestMessage => messages.isNotEmpty ? messages.first : null;
  ChatMessageEntity? get latestMessage => messages.isNotEmpty ? messages.last : null;

  @override
  List<Object?> get props => [
        status,
        conversation,
        messages,
        errorMessage,
        isSendingMessage,
        isLoadingMore,
        hasMoreMessages,
      ];
}
