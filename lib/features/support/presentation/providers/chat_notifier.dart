import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/error/failures.dart';
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
    return const ChatState.initial();
  }

  Future<void> initializeChat(int userId, String userEmail, String? userName) async {
    state = const ChatState.loading();

    try {
      final getOrCreateConversationUseCase = ref.read(getOrCreateConversationUseCaseProvider);
      final result = await getOrCreateConversationUseCase(userId, userEmail, userName);

      if (!ref.mounted) return;

      await result.fold(
        (failure) async {
          state = ChatState.error(failure: failure);
        },
        (conversation) async {
          state = ChatState.loaded(
            conversation: conversation,
            messages: [],
          );

          final loadInitialMessagesUseCase = ref.read(loadInitialMessagesUseCaseProvider);
          final messagesResult = await loadInitialMessagesUseCase(
            conversation.id,
            limit: state.pageSize,
          );

          if (!ref.mounted) return;

          messagesResult.fold(
            (failure) {
              AppLogger.e('Failed to load initial messages: ${failure.message}');
              state = ChatState.error(
                failure: failure,
                conversation: conversation,
              );
            },
            (messages) {
              final hasMore = messages.length >= state.pageSize;
              
              state = ChatState.loaded(
                conversation: conversation,
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
      if (!ref.mounted) return;
      state = const ChatState.error(
        failure: ServerFailure('Failed to initialize chat'),
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
        if (!ref.mounted) return;
        
        result.fold(
          (failure) {
            AppLogger.e('Error streaming new messages: ${failure.message}');
          },
          (newMessages) {
            if (newMessages.isNotEmpty) {
              AppLogger.i('Received ${newMessages.length} new messages');
              
              final currentState = state;
              if (currentState is ChatStateLoaded) {
                final updatedMessages = [...currentState.messages, ...newMessages];
                state = currentState.copyWith(messages: updatedMessages);
              } else if (currentState is ChatStateError && currentState.conversation != null) {
                // If we were in an error state but received messages, recover
                state = ChatState.loaded(
                  conversation: currentState.conversation!,
                  messages: [...currentState.messages, ...newMessages],
                );
              }
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
    final currentState = state;
    if (currentState is! ChatStateLoaded) return;
    
    if (currentState.isLoadingMore || !currentState.hasMoreMessages || currentState.messages.isEmpty) {
      AppLogger.d('Skip load more: isLoading=${currentState.isLoadingMore}, hasMore=${currentState.hasMoreMessages}');
      return;
    }

    state = currentState.copyWith(isLoadingMore: true);
    
    final oldestMsg = currentState.messages.first;
    AppLogger.d('Loading more messages before ${oldestMsg.timestamp.toIso8601String()}');

    final loadMoreMessagesUseCase = ref.read(loadMoreMessagesUseCaseProvider);
    final result = await loadMoreMessagesUseCase(
      currentState.conversation.id,
      oldestMsg.timestamp,
      limit: currentState.pageSize,
    );

    if (!ref.mounted) return;

    result.fold(
      (failure) {
        AppLogger.e('Error loading more messages: ${failure.message}');
        // Transition to error but keep conversation/messages
        state = ChatState.error(
          failure: failure,
          conversation: currentState.conversation,
          messages: currentState.messages,
        );
      },
      (olderMessages) {
        if (olderMessages.isEmpty) {
          // Hết tin nhắn cũ
          AppLogger.i('No more messages to load');
          state = currentState.copyWith(
            isLoadingMore: false,
            hasMoreMessages: false,
          );
          return;
        }

        // Thêm tin nhắn cũ vào đầu list
        final updatedMessages = [
          ...olderMessages,
          ...currentState.messages,
        ];
        final hasMore = olderMessages.length >= currentState.pageSize;

        state = currentState.copyWith(
          isLoadingMore: false,
          messages: updatedMessages,
          hasMoreMessages: hasMore,
        );

        AppLogger.i('Loaded ${olderMessages.length} more messages. Total: ${updatedMessages.length}');
      },
    );
  }

  Future<void> sendTextMessage(String content) async {
    final currentState = state;
    if (currentState is! ChatStateLoaded) return;
    if (content.trim().isEmpty) return;

    state = currentState.copyWith(isSendingMessage: true);

    try {
      final sendTextMessageUseCase = ref.read(sendTextMessageUseCaseProvider);
      final result = await sendTextMessageUseCase(
        currentState.conversation.id,
        currentState.conversation.userId,
        content.trim(),
      );

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          AppLogger.e('Failed to send message: ${failure.message}');
          state = ChatState.error(
            failure: failure,
            conversation: currentState.conversation,
            messages: currentState.messages,
          );
        },
        (message) {
          // Recovery from error to loaded is handled by the subscription stream
          state = currentState.copyWith(isSendingMessage: false);
        },
      );
    } catch (e) {
      AppLogger.e('Error sending message', e);
      if (!ref.mounted) return;
      state = ChatState.error(
        failure: const ServerFailure('Failed to send message'),
        conversation: currentState.conversation,
        messages: currentState.messages,
      );
    }
  }

  Future<void> sendMediaMessage(String filePath, MessageType type) async {
    final currentState = state;
    if (currentState is! ChatStateLoaded) return;

    state = currentState.copyWith(isSendingMessage: true);

    try {
      final sendMediaMessageUseCase = ref.read(sendMediaMessageUseCaseProvider);
      final result = await sendMediaMessageUseCase(
        currentState.conversation.id,
        currentState.conversation.userId,
        filePath,
        type,
      );

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          AppLogger.e('Failed to send media: ${failure.message}');
          state = ChatState.error(
            failure: failure,
            conversation: currentState.conversation,
            messages: currentState.messages,
          );
        },
        (message) {
          state = currentState.copyWith(isSendingMessage: false);
        },
      );
    } catch (e) {
      AppLogger.e('Error sending media', e);
      if (!ref.mounted) return;
      state = ChatState.error(
        failure: const ServerFailure('Failed to send media'),
        conversation: currentState.conversation,
        messages: currentState.messages,
      );
    }
  }

  // ✅ Thêm method đóng conversation
  Future<void> closeConversation({String? reason}) async {
    final currentState = state;
    if (currentState is! ChatStateLoaded) return;

    try {
      AppLogger.d('Closing conversation: ${currentState.conversation.id}');
      
      final closeConversationUseCase = ref.read(closeConversationUseCaseProvider);
      final result = await closeConversationUseCase(
        currentState.conversation.id,
        closeReason: reason ?? 'Đã giải quyết xong',
      );

      if (!ref.mounted) return;

      result.fold(
        (failure) {
          AppLogger.e('Failed to close conversation: ${failure.message}');
          state = ChatState.error(
            failure: failure,
            conversation: currentState.conversation,
            messages: currentState.messages,
          );
        },
        (_) {
          AppLogger.i('Successfully closed conversation');
          
          // Update conversation status locally
          final updatedConversation = currentState.conversation.copyWith(
            status: ConversationStatus.closed,
            updatedAt: DateTime.now(),
            closedAt: DateTime.now(),
            closedBy: 'user',
            closeReason: reason ?? 'Đã giải quyết xong',
          );
          
          state = currentState.copyWith(conversation: updatedConversation);
          
          // Cancel message subscription
          _messagesSubscription?.cancel();
        },
      );
    } catch (e) {
      AppLogger.e('Error closing conversation', e);
      if (!ref.mounted) return;
      state = ChatState.error(
        failure: const ServerFailure('Không thể đóng cuộc hội thoại'),
        conversation: currentState.conversation,
        messages: currentState.messages,
      );
    }
  }

  // ✅ Thêm method tạo conversation mới (reopen)
  Future<void> startNewConversation(int userId, String userEmail, String? userName) async {
    // Reset state
    state = const ChatState.initial();
    
    // Cancel old subscription
    _messagesSubscription?.cancel();
    
    // Initialize new chat
    await initializeChat(userId, userEmail, userName);
  }
}
