import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/repositories/support_repository.dart';
import '../datasources/support_remote_datasource.dart';

class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteDataSource remoteDataSource;

  SupportRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ConversationEntity>> getOrCreateConversation(
    int userId,
    String userEmail,
    String? userName,
  ) async {
    try {
      final model = await remoteDataSource.getOrCreateConversation(userId, userEmail, userName);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to get or create conversation: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> getConversation(String conversationId) async {
    try {
      final model = await remoteDataSource.getConversation(conversationId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to get conversation: ${e.toString()}'));
    }
  }

  @override
  Stream<Either<Failure, List<ChatMessageEntity>>> streamMessages(String conversationId) {
    try {
      return remoteDataSource.streamMessages(conversationId).map(
            (messages) => Right<Failure, List<ChatMessageEntity>>(
              messages.map((m) => m.toEntity()).toList(),
            ),
          );
    } catch (e) {
      return Stream.value(
        Left(ServerFailure('Failed to stream messages: ${e.toString()}')),
      );
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> loadInitialMessages(
    String conversationId, {
    int limit = 25,
  }) async {
    try {
      final models = await remoteDataSource.loadInitialMessages(conversationId, limit: limit);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to load initial messages: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> loadMoreMessages(
    String conversationId,
    DateTime beforeTimestamp, {
    int limit = 50,
  }) async {
    try {
      final models = await remoteDataSource.loadMoreMessages(
        conversationId,
        beforeTimestamp,
        limit: limit,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to load more messages: ${e.toString()}'));
    }
  }

  @override
  Stream<Either<Failure, List<ChatMessageEntity>>> streamNewMessages(
    String conversationId,
    DateTime afterTimestamp,
  ) {
    try {
      return remoteDataSource.streamNewMessages(conversationId, afterTimestamp).map(
            (messages) => Right<Failure, List<ChatMessageEntity>>(
              messages.map((m) => m.toEntity()).toList(),
            ),
          );
    } catch (e) {
      return Stream.value(
        Left(ServerFailure('Failed to stream new messages: ${e.toString()}')),
      );
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendTextMessage(
    String conversationId,
    int userId,
    String content,
  ) async {
    try {
      final model = await remoteDataSource.sendTextMessage(conversationId, userId, content);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to send message: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMediaMessage(
    String conversationId,
    int userId,
    String filePath,
    MessageType type,
  ) async {
    try {
      final typeString = type == MessageType.image ? 'image' : 'video';
      final model = await remoteDataSource.sendMediaMessage(conversationId, userId, filePath, typeString);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to send media: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> markMessagesAsRead(String conversationId) async {
    try {
      await remoteDataSource.markMessagesAsRead(conversationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to mark as read: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> closeConversation(
    String conversationId, {
    String closedBy = 'user',
    String? closeReason,
  }) async {
    try {
      await remoteDataSource.closeConversation(
        conversationId,
        closedBy: closedBy,
        closeReason: closeReason,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to close conversation: ${e.toString()}'));
    }
  }
}
