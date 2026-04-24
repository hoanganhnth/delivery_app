import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/conversation_entity.dart';
import 'chat_state.dart';
import 'support_providers.dart';

part 'chat_notifier.g.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  StreamSubscription<dynamic>? _messagesSubscription;

  @override
  ChatState build() {
    ref.onDispose(() {
      _messagesSubscription?.cancel();
    });
    return const ChatState();
  }

  Future<void> initializeChat(int userId, String userEmail, String? userName) async {
    state = state.copyWith(status: ChatStatus.loading);

    try {
      final getOrCreateConversationUseCase = ref.read(getOrCreateConversationUseCaseProvider);
      final result = await getOrCreateConversationUseCase(userId, userEmail, userName);

      await result.fold(
        (failure) async {
          state = state.copyWith(
            status: ChatStatus.error,
            errorMessage: failure.message,
          );
        },
        (conversation) async {
          state = state.copyWith(conversation: conversation);

          final loadInitialMessagesUseCase = ref.read(loadInitialMessagesUseCaseProvider);
          final messagesResult = await loadInitialMessagesUseCase(
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

    final streamNewMessagesUseCase = ref.read(streamNewMessagesUseCaseProvider);
    _messagesSubscription = streamNewMessagesUseCase(conversationId, afterTimestamp).listen(
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

    final loadMoreMessagesUseCase = ref.read(loadMoreMessagesUseCaseProvider);
    final result = await loadMoreMessagesUseCase(
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
      final sendTextMessageUseCase = ref.read(sendTextMessageUseCaseProvider);
      final result = await sendTextMessageUseCase(
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
      final sendMediaMessageUseCase = ref.read(sendMediaMessageUseCaseProvider);
      final result = await sendMediaMessageUseCase(
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

  // ✅ Thêm method đóng conversation
  Future<void> closeConversation({String? reason}) async {
    if (state.conversation == null) return;

    try {
      AppLogger.d('Closing conversation: ${state.conversation!.id}');
      
      final closeConversationUseCase = ref.read(closeConversationUseCaseProvider);
      final result = await closeConversationUseCase(
        state.conversation!.id,
        closeReason: reason ?? 'Đã giải quyết xong',
      );

      result.fold(
        (failure) {
          AppLogger.e('Failed to close conversation: ${failure.message}');
          state = state.copyWith(errorMessage: failure.message);
        },
        (_) {
          AppLogger.i('Successfully closed conversation');
          
          // Update conversation status locally
          final updatedConversation = state.conversation!.copyWith(
            status: ConversationStatus.closed,
            updatedAt: DateTime.now(),
            closedAt: DateTime.now(),
            closedBy: 'user',
            closeReason: reason ?? 'Đã giải quyết xong',
          );
          
          state = state.copyWith(conversation: updatedConversation);
          
          // Cancel message subscription
          _messagesSubscription?.cancel();
        },
      );
    } catch (e) {
      AppLogger.e('Error closing conversation', e);
      state = state.copyWith(errorMessage: 'Không thể đóng cuộc hội thoại');
    }
  }

  // ✅ Thêm method tạo conversation mới (reopen)
  Future<void> startNewConversation(int userId, String userEmail, String? userName) async {
    // Reset state
    state = const ChatState();
    
    // Cancel old subscription
    _messagesSubscription?.cancel();
    
    // Initialize new chat
    await initializeChat(userId, userEmail, userName);
  }
}
