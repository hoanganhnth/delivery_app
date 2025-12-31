import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/usecases/get_or_create_conversation_usecase.dart';
import '../../domain/usecases/load_initial_messages_usecase.dart';
import '../../domain/usecases/load_more_messages_usecase.dart';
import '../../domain/usecases/send_text_message_usecase.dart';
import '../../domain/usecases/send_media_message_usecase.dart';
import '../../domain/usecases/stream_new_messages_usecase.dart';
import 'chat_state.dart';
import 'support_providers.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final GetOrCreateConversationUseCase _getOrCreateConversationUseCase;
  final LoadInitialMessagesUseCase _loadInitialMessagesUseCase;
  final LoadMoreMessagesUseCase _loadMoreMessagesUseCase;
  final StreamNewMessagesUseCase _streamNewMessagesUseCase;
  final SendTextMessageUseCase _sendTextMessageUseCase;
  final SendMediaMessageUseCase _sendMediaMessageUseCase;

  StreamSubscription<dynamic>? _messagesSubscription;

  ChatNotifier(
    this._getOrCreateConversationUseCase,
    this._loadInitialMessagesUseCase,
    this._loadMoreMessagesUseCase,
    this._streamNewMessagesUseCase,
    this._sendTextMessageUseCase,
    this._sendMediaMessageUseCase,
  ) : super(const ChatState());

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    super.dispose();
  }

  Future<void> initializeChat(int userId, String userEmail, String? userName) async {
    state = state.copyWith(status: ChatStatus.loading);

    try {
      // 1. Get or create conversation
      final result = await _getOrCreateConversationUseCase(userId, userEmail, userName);

      await result.fold(
        (failure) async {
          state = state.copyWith(
            status: ChatStatus.error,
            errorMessage: failure.message,
          );
        },
        (conversation) async {
          state = state.copyWith(conversation: conversation);

          // 2. Load initial messages (50 latest) using UseCase
          final messagesResult = await _loadInitialMessagesUseCase(
            conversation.id,
            limit: state.pageSize,
          );

          messagesResult.fold(
            (failure) {
              AppLogger.e('Failed to load initial messages: ${failure.message}');
              state = state.copyWith(
                status: ChatStatus.error,
                errorMessage: failure.message,
              );
            },
            (messages) {
              final hasMore = messages.length >= state.pageSize;
              
              state = state.copyWith(
                status: ChatStatus.loaded,
                messages: messages,
                hasMoreMessages: hasMore,
              );

              // 3. Start listening to NEW messages only
              if (messages.isNotEmpty) {
                _listenToNewMessages(conversation.id, messages.last.timestamp);
              } else {
                _listenToNewMessages(conversation.id, DateTime.now());
              }
            },
          );
        },
      );
    } catch (e) {
      AppLogger.e('Failed to initialize chat', e);
      state = state.copyWith(
        status: ChatStatus.error,
        errorMessage: 'Failed to initialize chat',
      );
    }
  }

  // ✅ Listen to NEW messages only (real-time)
  void _listenToNewMessages(String conversationId, DateTime afterTimestamp) {
    _messagesSubscription?.cancel();

    AppLogger.d('Listening to new messages after ${afterTimestamp.toIso8601String()}');

    _messagesSubscription = _streamNewMessagesUseCase(conversationId, afterTimestamp).listen(
      (result) {
        result.fold(
          (failure) {
            AppLogger.e('Error streaming new messages: ${failure.message}');
          },
          (newMessages) {
            if (newMessages.isNotEmpty) {
              AppLogger.i('Received ${newMessages.length} new messages');
              
              // Thêm tin nhắn mới vào cuối list
              final updatedMessages = [...state.messages, ...newMessages];
              state = state.copyWith(messages: updatedMessages);
            }
          },
        );
      },
      onError: (error) {
        AppLogger.e('Error streaming new messages', error);
      },
    );
  }

  // ✅ Load more old messages (pagination)
  Future<void> loadMoreMessages() async {
    if (state.isLoadingMore || !state.hasMoreMessages || state.oldestMessage == null) {
      AppLogger.d('Skip load more: isLoading=${state.isLoadingMore}, hasMore=${state.hasMoreMessages}');
      return;
    }

    state = state.copyWith(isLoadingMore: true);
    AppLogger.d('Loading more messages before ${state.oldestMessage!.timestamp.toIso8601String()}');

    final result = await _loadMoreMessagesUseCase(
      state.conversation!.id,
      state.oldestMessage!.timestamp,
      limit: state.pageSize,
    );

    result.fold(
      (failure) {
        AppLogger.e('Error loading more messages: ${failure.message}');
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        );
      },
      (olderMessages) {
        if (olderMessages.isEmpty) {
          // Hết tin nhắn cũ
          AppLogger.i('No more messages to load');
          state = state.copyWith(
            isLoadingMore: false,
            hasMoreMessages: false,
          );
          return;
        }

        // Thêm tin nhắn cũ vào đầu list
        final updatedMessages = [
          ...olderMessages,
          ...state.messages,
        ];
        final hasMore = olderMessages.length >= state.pageSize;

        state = state.copyWith(
          isLoadingMore: false,
          messages: updatedMessages,
          hasMoreMessages: hasMore,
        );

        AppLogger.i('Loaded ${olderMessages.length} more messages. Total: ${updatedMessages.length}');
      },
    );
  }

  Future<void> sendTextMessage(String content) async {
    if (content.trim().isEmpty || state.conversation == null) return;

    state = state.copyWith(isSendingMessage: true);

    try {
      final result = await _sendTextMessageUseCase(
        state.conversation!.id,
        state.conversation!.userId,
        content.trim(),
      );

      result.fold(
        (failure) {
          AppLogger.e('Failed to send message: ${failure.message}');
          state = state.copyWith(
            isSendingMessage: false,
            errorMessage: failure.message,
          );
        },
        (message) {
          state = state.copyWith(isSendingMessage: false);
        },
      );
    } catch (e) {
      AppLogger.e('Error sending message', e);
      state = state.copyWith(
        isSendingMessage: false,
        errorMessage: 'Failed to send message',
      );
    }
  }

  Future<void> sendMediaMessage(String filePath, MessageType type) async {
    if (state.conversation == null) return;

    state = state.copyWith(isSendingMessage: true);

    try {
      final result = await _sendMediaMessageUseCase(
        state.conversation!.id,
        state.conversation!.userId,
        filePath,
        type,
      );

      result.fold(
        (failure) {
          AppLogger.e('Failed to send media: ${failure.message}');
          state = state.copyWith(
            isSendingMessage: false,
            errorMessage: failure.message,
          );
        },
        (message) {
          state = state.copyWith(isSendingMessage: false);
        },
      );
    } catch (e) {
      AppLogger.e('Error sending media', e);
      state = state.copyWith(
        isSendingMessage: false,
        errorMessage: 'Failed to send media',
      );
    }
  }
}

// Provider
final chatNotifierProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(
    ref.watch(getOrCreateConversationUseCaseProvider),
    ref.watch(loadInitialMessagesUseCaseProvider),
    ref.watch(loadMoreMessagesUseCaseProvider),
    ref.watch(streamNewMessagesUseCaseProvider),
    ref.watch(sendTextMessageUseCaseProvider),
    ref.watch(sendMediaMessageUseCaseProvider),
  );
});
