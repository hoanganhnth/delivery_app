import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/services/cloudinary_service.dart';
import '../models/chat_message_model.dart';
import '../models/conversation_model.dart';

abstract class SupportRemoteDataSource {
  Future<ConversationModel> getOrCreateConversation(int userId, String userEmail, String? userName);
  Future<ConversationModel> getConversation(String conversationId);
  Stream<List<ChatMessageModel>> streamMessages(String conversationId);
  Future<ChatMessageModel> sendTextMessage(String conversationId, int userId, String content);
  Future<ChatMessageModel> sendMediaMessage(String conversationId, int userId, String filePath, String type);
  Future<void> markMessagesAsRead(String conversationId);
  Future<void> closeConversation(String conversationId);
}

class SupportRemoteDataSourceImpl implements SupportRemoteDataSource {
  final FirebaseFirestore _firestore;
  final CloudinaryService _cloudinaryService;
  final Uuid _uuid = const Uuid();

  SupportRemoteDataSourceImpl({
    FirebaseFirestore? firestore,
    CloudinaryService? cloudinaryService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _cloudinaryService = cloudinaryService ?? CloudinaryService();

  @override
  Future<ConversationModel> getOrCreateConversation(
    int userId,
    String userEmail,
    String? userName,
  ) async {
    try {
      // Check if conversation already exists for this user
      final querySnapshot = await _firestore
          .collection('conversations')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'active')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        AppLogger.i('Found existing conversation for user: $userId');
        return ConversationModel.fromFirestore(querySnapshot.docs.first);
      }

      // Create new conversation
      AppLogger.i('Creating new conversation for user: $userId');
      final conversationRef = _firestore.collection('conversations').doc();
      final now = Timestamp.now();

      final conversationData = {
        'userId': userId,
        'userEmail': userEmail,
        'userName': userName,
        'status': 'active',
        'createdAt': now,
        'updatedAt': now,
        'unreadCount': 0,
      };

      await conversationRef.set(conversationData);

      final doc = await conversationRef.get();
      return ConversationModel.fromFirestore(doc);
    } catch (e, stackTrace) {
      AppLogger.e('Failed to get or create conversation', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<ConversationModel> getConversation(String conversationId) async {
    try {
      final doc = await _firestore.collection('conversations').doc(conversationId).get();

      if (!doc.exists) {
        throw Exception('Conversation not found');
      }

      return ConversationModel.fromFirestore(doc);
    } catch (e, stackTrace) {
      AppLogger.e('Failed to get conversation', e, stackTrace);
      rethrow;
    }
  }

  @override
  Stream<List<ChatMessageModel>> streamMessages(String conversationId) {
    try {
      return _firestore
          .collection('messages')
          .where('conversationId', isEqualTo: conversationId)
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => ChatMessageModel.fromFirestore(doc)).toList();
      });
    } catch (e, stackTrace) {
      AppLogger.e('Failed to stream messages', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<ChatMessageModel> sendTextMessage(
    String conversationId,
    int userId,
    String content,
  ) async {
    try {
      final messageRef = _firestore.collection('messages').doc();
      final now = Timestamp.now();

      final messageData = {
        'conversationId': conversationId,
        'content': content,
        'type': 'text',
        'sender': 'user',
        'timestamp': now,
        'isRead': false,
      };

      await messageRef.set(messageData);

      // Update conversation last message and updatedAt
      await _firestore.collection('conversations').doc(conversationId).update({
        'updatedAt': now,
        'lastMessage': {
          'id': messageRef.id,
          'content': content,
          'type': 'text',
          'sender': 'user',
          'timestamp': now,
          'isRead': false,
        },
      });

      final doc = await messageRef.get();
      return ChatMessageModel.fromFirestore(doc);
    } catch (e, stackTrace) {
      AppLogger.e('Failed to send text message', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<ChatMessageModel> sendMediaMessage(
    String conversationId,
    int userId,
    String filePath,
    String type,
  ) async {
    try {
      AppLogger.d('Uploading media file: $filePath');

      // Upload file to Cloudinary
      final file = File(filePath);
      final publicId = '${conversationId}_${_uuid.v4()}';
      
      String mediaUrl;
      String? thumbnailUrl;
      
      if (type == 'image') {
        final response = await _cloudinaryService.uploadImage(
          file,
          folder: 'support_chat/$conversationId',
          publicId: publicId,
        );
        mediaUrl = response.secureUrl;
        // Get optimized thumbnail
        thumbnailUrl = _cloudinaryService.getOptimizedImageUrl(
          response.publicId,
          width: 400,
          height: 300,
        );
      } else {
        // Video
        final response = await _cloudinaryService.uploadVideo(
          file,
          folder: 'support_chat/$conversationId',
          publicId: publicId,
        );
        mediaUrl = response.secureUrl;
        // Get video thumbnail
        thumbnailUrl = _cloudinaryService.getVideoThumbnailUrl(
          response.publicId,
          width: 400,
          height: 300,
        );
      }

      AppLogger.i('Media uploaded successfully: $mediaUrl');

      // Create message with media URL
      final messageRef = _firestore.collection('messages').doc();
      final now = Timestamp.now();

      final messageData = {
        'conversationId': conversationId,
        'content': type == 'image' ? 'Sent an image' : 'Sent a video',
        'type': type,
        'sender': 'user',
        'mediaUrl': mediaUrl,
        'thumbnailUrl': thumbnailUrl,
        'timestamp': now,
        'isRead': false,
      };

      await messageRef.set(messageData);

      // Update conversation last message
      await _firestore.collection('conversations').doc(conversationId).update({
        'updatedAt': now,
        'lastMessage': {
          'id': messageRef.id,
          'content': messageData['content'],
          'type': type,
          'sender': 'user',
          'mediaUrl': mediaUrl,
          'thumbnailUrl': thumbnailUrl,
          'timestamp': now,
          'isRead': false,
        },
      });

      final doc = await messageRef.get();
      return ChatMessageModel.fromFirestore(doc);
    } catch (e, stackTrace) {
      AppLogger.e('Failed to send media message', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> markMessagesAsRead(String conversationId) async {
    try {
      final batch = _firestore.batch();

      // Get all unread messages from support
      final unreadMessages = await _firestore
          .collection('messages')
          .where('conversationId', isEqualTo: conversationId)
          .where('sender', isEqualTo: 'support')
          .where('isRead', isEqualTo: false)
          .get();

      for (final doc in unreadMessages.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      // Reset unread count
      batch.update(
        _firestore.collection('conversations').doc(conversationId),
        {'unreadCount': 0},
      );

      await batch.commit();
      AppLogger.i('Marked messages as read for conversation: $conversationId');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to mark messages as read', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> closeConversation(String conversationId) async {
    try {
      await _firestore.collection('conversations').doc(conversationId).update({
        'status': 'closed',
        'updatedAt': Timestamp.now(),
      });

      AppLogger.i('Closed conversation: $conversationId');
    } catch (e, stackTrace) {
      AppLogger.e('Failed to close conversation', e, stackTrace);
      rethrow;
    }
  }
}
