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

  const ChatState({
    this.status = ChatStatus.initial,
    this.conversation,
    this.messages = const [],
    this.errorMessage,
    this.isSendingMessage = false,
  });

  ChatState copyWith({
    ChatStatus? status,
    ConversationEntity? conversation,
    List<ChatMessageEntity>? messages,
    String? errorMessage,
    bool? isSendingMessage,
  }) {
    return ChatState(
      status: status ?? this.status,
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      errorMessage: errorMessage,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
    );
  }

  bool get isLoading => status == ChatStatus.loading;
  bool get hasError => status == ChatStatus.error;
  bool get hasConversation => conversation != null;

  @override
  List<Object?> get props => [status, conversation, messages, errorMessage, isSendingMessage];
}
