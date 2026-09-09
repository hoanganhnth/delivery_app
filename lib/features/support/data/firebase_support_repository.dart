import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/contracts/session_contract.dart';
import 'package:delivery_app/features/support/domain/entities/support_conversation.dart';
import 'package:delivery_app/features/support/domain/repositories/support_repository.dart';

final class FirebaseSupportRepository implements SupportRepository {
  FirebaseSupportRepository({
    required Dio dio,
    required SessionPort session,
    this.userEmail,
    this.userName,
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) : _dio = dio,
       _session = session,
       _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final Dio _dio;
  final SessionPort _session;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final String? userEmail;
  final String? userName;

  String get _principalId {
    final value = _session.current.authId;
    if (value == null || value <= 0) {
      throw const SupportBackendUnavailableException();
    }
    return value.toString();
  }

  @override
  Future<SupportConversation> current() async {
    try {
      await _ensureFirebaseSession();
      final snapshot = await _firestore
          .collection('conversations')
          .where('principalId', isEqualTo: _principalId)
          .where('isSupportChat', isEqualTo: true)
          .where('status', isEqualTo: 'open')
          .orderBy('updatedAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return _conversationFrom(snapshot.docs.first);
      }

      final reference = _firestore.collection('conversations').doc();
      final now = Timestamp.now();
      await reference.set({
        'principalId': _principalId,
        'userId': _session.current.profileId,
        'userEmail': userEmail ?? '',
        'userName': userName ?? '',
        'isSupportChat': true,
        'status': 'open',
        'createdAt': now,
        'updatedAt': now,
        'unreadCount': 0,
        'customerUnreadCount': 0,
        'agentUnreadCount': 0,
        'lastMessage': null,
        'closedAt': null,
        'closedBy': null,
        'closeReason': null,
      });
      return SupportConversation.open(const [], id: reference.id);
    } on SupportBackendUnavailableException {
      rethrow;
    } on FirebaseException catch (error) {
      throw SupportBackendUnavailableException(error.message ?? error.code);
    } on DioException catch (error) {
      throw SupportBackendUnavailableException(
        error.message ?? 'Firebase chat token request failed',
      );
    } catch (error) {
      throw SupportBackendUnavailableException(error.toString());
    }
  }

  @override
  Stream<List<SupportMessage>> watchMessages(String conversationId) async* {
    await _ensureFirebaseSession();
    yield* _firestore
        .collection('messages')
        .where('conversationId', isEqualTo: conversationId)
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_messageFrom).toList());
  }

  @override
  Future<void> sendTextMessage(String conversationId, String content) async {
    final normalized = content.trim();
    if (normalized.isEmpty || normalized.length > 2000) {
      throw const SupportChatException('Tin nhắn phải có từ 1 đến 2000 ký tự');
    }

    await _ensureFirebaseSession();
    final conversationReference = _firestore
        .collection('conversations')
        .doc(conversationId);
    final conversation = await conversationReference.get();
    final data = conversation.data();
    if (!conversation.exists || data?['principalId'] != _principalId) {
      throw const SupportChatException(
        'Cuộc hội thoại không thuộc tài khoản này',
      );
    }
    if (data?['status'] != 'open') {
      throw const SupportChatException('Cuộc hội thoại đã đóng');
    }

    final messageReference = _firestore.collection('messages').doc();
    final serverTime = FieldValue.serverTimestamp();
    final batch = _firestore.batch();
    batch.set(messageReference, {
      'conversationId': conversationId,
      'principalId': _principalId,
      'senderPrincipalId': _principalId,
      'senderRole': 'USER',
      'sender': 'user',
      'content': normalized,
      'type': 'text',
      'timestamp': serverTime,
      'isRead': false,
      'readAt': null,
    });
    batch.update(conversationReference, {
      'updatedAt': serverTime,
      'lastMessage': {
        'id': messageReference.id,
        'content': normalized,
        'type': 'text',
        'sender': 'user',
        'senderRole': 'USER',
        'timestamp': serverTime,
      },
      'agentUnreadCount': FieldValue.increment(1),
      'unreadCount': FieldValue.increment(1),
    });
    await batch.commit();
  }

  @override
  Future<void> markConversationRead(String conversationId) async {
    await _ensureFirebaseSession();
    final messages = await _firestore
        .collection('messages')
        .where('conversationId', isEqualTo: conversationId)
        .get();
    final batch = _firestore.batch();
    final readAt = Timestamp.now();
    for (final message in messages.docs) {
      final data = message.data();
      if (data['senderRole'] == 'ADMIN' && data['isRead'] != true) {
        batch.update(message.reference, {'isRead': true, 'readAt': readAt});
      }
    }
    batch.update(_firestore.collection('conversations').doc(conversationId), {
      'updatedAt': readAt,
      'customerUnreadCount': 0,
    });
    await batch.commit();
  }

  @override
  Future<void> closeConversation(
    String conversationId, {
    String? reason,
  }) async {
    await _ensureFirebaseSession();
    final now = Timestamp.now();
    await _firestore.collection('conversations').doc(conversationId).update({
      'status': 'closed',
      'closedAt': now,
      'closedBy': _principalId,
      'closeReason': reason?.trim().isEmpty == true ? null : reason?.trim(),
      'updatedAt': now,
    });
  }

  Future<void> _ensureFirebaseSession() async {
    final expectedUid = _principalId;
    final current = _auth.currentUser;
    if (current?.uid == expectedUid) return;
    if (current != null) await _auth.signOut();

    final response = await _dio.post(ApiConstants.firebaseChatToken);
    final envelope = response.data;
    final payload = envelope is Map ? envelope['data'] : null;
    final token = payload is Map ? payload['token'] : null;
    final principalId = payload is Map ? payload['principalId'] : null;
    if (token is! String ||
        token.trim().isEmpty ||
        _numberAsString(principalId) != expectedUid) {
      throw const SupportBackendUnavailableException();
    }

    final credential = await _auth.signInWithCustomToken(token);
    if (credential.user?.uid != expectedUid) {
      await _auth.signOut();
      throw const SupportBackendUnavailableException();
    }
  }

  SupportConversation _conversationFrom(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    final status = data['status'] == 'closed'
        ? SupportStatus.closed
        : SupportStatus.open;
    return status == SupportStatus.closed
        ? SupportConversation.closed(const [], id: document.id)
        : SupportConversation.open(const [], id: document.id);
  }

  SupportMessage _messageFrom(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    final timestamp = data['timestamp'];
    final sentAt = timestamp is Timestamp
        ? timestamp.toDate().toIso8601String()
        : DateTime.now().toIso8601String();
    return SupportMessage(
      id: document.id,
      body: data['content'] as String? ?? '',
      sentAt: sentAt,
      sender: data['senderRole'] == 'ADMIN' || data['sender'] == 'support'
          ? SupportMessageSender.support
          : SupportMessageSender.customer,
      isRead: data['isRead'] == true,
    );
  }

  String _numberAsString(Object? value) {
    if (value is int) return value.toString();
    if (value is String) return value.trim();
    return '';
  }
}

final class SupportChatException implements Exception {
  const SupportChatException(this.message);

  final String message;

  @override
  String toString() => message;
}
