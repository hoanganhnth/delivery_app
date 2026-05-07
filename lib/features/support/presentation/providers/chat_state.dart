import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:delivery_app/core/error/failures.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/conversation_entity.dart';

part 'chat_state.freezed.dart';

@freezed
sealed class ChatState with _$ChatState {
  const ChatState._();

  const factory ChatState.initial() = ChatStateInitial;
  
  const factory ChatState.loading() = ChatStateLoading;
  
  const factory ChatState.loaded({
    required ConversationEntity conversation,
    required List<ChatMessageEntity> messages,
    @Default(false) bool isSendingMessage,
    @Default(false) bool isLoadingMore,
    @Default(true) bool hasMoreMessages,
    @Default(10) int pageSize,
  }) = ChatStateLoaded;
  
  const factory ChatState.error({
    required Failure failure,
    ConversationEntity? conversation,
    @Default([]) List<ChatMessageEntity> messages,
  }) = ChatStateError;

  bool get isLoading => this is ChatStateLoading;
  bool get hasError => this is ChatStateError;
  bool get hasConversation => conversation != null;
  
  ConversationEntity? get conversation => mapOrNull(
    loaded: (s) => s.conversation,
    error: (s) => s.conversation,
  );

  List<ChatMessageEntity> get messages => map(
    initial: (_) => const [],
    loading: (_) => const [],
    loaded: (s) => s.messages,
    error: (s) => s.messages,
  );
  
  ChatMessageEntity? get oldestMessage => messages.isNotEmpty ? messages.first : null;
  ChatMessageEntity? get latestMessage => messages.isNotEmpty ? messages.last : null;
  
  String? get errorMessage => mapOrNull(error: (s) => s.failure.message);
  
  bool get isSendingMessage => maybeMap(
    loaded: (s) => s.isSendingMessage,
    orElse: () => false,
  );
  
  bool get isLoadingMore => maybeMap(
    loaded: (s) => s.isLoadingMore,
    orElse: () => false,
  );
  
  bool get hasMoreMessages => maybeMap(
    loaded: (s) => s.hasMoreMessages,
    orElse: () => false,
  );
  
  int get pageSize => maybeMap(
    loaded: (s) => s.pageSize,
    orElse: () => 10,
  );
}
