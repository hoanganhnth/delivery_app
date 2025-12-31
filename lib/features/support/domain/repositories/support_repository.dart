import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../entities/conversation_entity.dart';

abstract class SupportRepository {
  /// Get or create conversation for current user
  Future<Either<Failure, ConversationEntity>> getOrCreateConversation(int userId, String userEmail, String? userName);

  /// Get conversation by ID
  Future<Either<Failure, ConversationEntity>> getConversation(String conversationId);

  /// Stream messages for a conversation
  Stream<Either<Failure, List<ChatMessageEntity>>> streamMessages(String conversationId);

  /// Load initial messages with pagination
  Future<Either<Failure, List<ChatMessageEntity>>> loadInitialMessages(
    String conversationId, {
    int limit = 50,
  });

  /// Load more messages (older messages)
  Future<Either<Failure, List<ChatMessageEntity>>> loadMoreMessages(
    String conversationId,
    DateTime beforeTimestamp, {
    int limit = 50,
  });

  /// Stream only new messages after a timestamp
  Stream<Either<Failure, List<ChatMessageEntity>>> streamNewMessages(
    String conversationId,
    DateTime afterTimestamp,
  );

  /// Send text message
  Future<Either<Failure, ChatMessageEntity>> sendTextMessage(
    String conversationId,
    int userId,
    String content,
  );

  /// Send media message (image/video)
  Future<Either<Failure, ChatMessageEntity>> sendMediaMessage(
    String conversationId,
    int userId,
    String filePath,
    MessageType type,
  );

  /// Mark messages as read
  Future<Either<Failure, void>> markMessagesAsRead(String conversationId);

  /// Close conversation
  Future<Either<Failure, void>> closeConversation(String conversationId);
}
