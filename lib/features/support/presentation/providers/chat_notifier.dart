import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/usecases/get_or_create_conversation_usecase.dart';
import '../../domain/usecases/stream_messages_usecase.dart';
import '../../domain/usecases/send_text_message_usecase.dart';
import '../../domain/usecases/send_media_message_usecase.dart';
import 'chat_state.dart';
import 'support_providers.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final GetOrCreateConversationUseCase _getOrCreateConversationUseCase;
  final StreamMessagesUseCase _streamMessagesUseCase;
  final SendTextMessageUseCase _sendTextMessageUseCase;
  final SendMediaMessageUseCase _sendMediaMessageUseCase;

  StreamSubscription<dynamic>? _messagesSubscription;

  ChatNotifier(
    this._getOrCreateConversationUseCase,
    this._streamMessagesUseCase,
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
      // Get or create conversation
      final result = await _getOrCreateConversationUseCase(userId, userEmail, userName);

      result.fold(
        (failure) {
          state = state.copyWith(
            status: ChatStatus.error,
            errorMessage: failure.message,
          );
        },
        (conversation) {
          state = state.copyWith(
            status: ChatStatus.loaded,
            conversation: conversation,
          );

          // Start listening to messages
          _listenToMessages(conversation.id);
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

  void _listenToMessages(String conversationId) {
    _messagesSubscription?.cancel();

    _messagesSubscription = _streamMessagesUseCase(conversationId).listen(
      (result) {
        result.fold(
          (failure) {
            AppLogger.e('Failed to stream messages: ${failure.message}');
          },
          (messages) {
            state = state.copyWith(messages: messages);
          },
        );
      },
      onError: (error) {
        AppLogger.e('Error streaming messages', error);
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
    ref.watch(streamMessagesUseCaseProvider),
    ref.watch(sendTextMessageUseCaseProvider),
    ref.watch(sendMediaMessageUseCaseProvider),
  );
});
