// Firestore exposes sealed/immutable SDK interfaces; these test-only fakes
// capture boundary operations without a Firebase instance or emulator.
// ignore_for_file: subtype_of_sealed_class, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/contracts/session_contract.dart';
import 'package:delivery_app/features/support/data/firebase_support_repository.dart';
import 'package:delivery_app/features/support/domain/entities/support_conversation.dart';
import 'package:delivery_app/features/support/domain/repositories/support_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class _Session extends Fake implements SessionPort {
  int? id = 42;
  @override
  SessionSnapshot get current =>
      SessionSnapshot(isAuthenticated: true, authId: id, profileId: 7);
}

class _User extends Fake implements User {
  _User(this.uid);
  @override
  final String uid;
}

class _Credential extends Fake implements UserCredential {
  _Credential(this.user);
  @override
  final User? user;
}

class _Auth extends Fake implements FirebaseAuth {
  User? user = _User('42');
  String signedInUid = '42';
  String? token;
  int signOuts = 0;
  @override
  User? get currentUser => user;
  @override
  Future<void> signOut() async {
    signOuts++;
    user = null;
  }

  @override
  Future<UserCredential> signInWithCustomToken(String token) async {
    this.token = token;
    user = _User(signedInUid);
    return _Credential(user);
  }
}

class _Document extends Fake
    implements QueryDocumentSnapshot<Map<String, dynamic>> {
  _Document(this.id, this.values, this.reference);
  @override
  final String id;
  final Map<String, dynamic> values;
  @override
  final DocumentReference<Map<String, dynamic>> reference;
  @override
  Map<String, dynamic> data() => values;
  @override
  bool get exists => values.isNotEmpty;
}

class _Snapshot extends Fake implements QuerySnapshot<Map<String, dynamic>> {
  _Snapshot(this.docs);
  @override
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;
}

class _Reference extends Fake
    implements DocumentReference<Map<String, dynamic>> {
  _Reference(this.parentCollection, this.id);
  final _Collection parentCollection;
  @override
  final String id;
  @override
  Future<void> set(Map<String, dynamic> data, [SetOptions? options]) async {
    parentCollection.records[id] = data;
  }

  @override
  Future<void> update(Map<Object, Object?> data) async {
    parentCollection.records[id]!.addAll(data.cast<String, dynamic>());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> get([
    GetOptions? options,
  ]) async => _Document(id, parentCollection.records[id] ?? {}, this);
}

class _Collection extends Fake
    implements CollectionReference<Map<String, dynamic>> {
  final records = <String, Map<String, dynamic>>{};
  final filters = <String, Object?>{};
  final orders = <String, bool>{};
  int? max;
  Object? failure;
  @override
  DocumentReference<Map<String, dynamic>> doc([String? path]) =>
      _Reference(this, path ?? 'new-${records.length}');
  @override
  Query<Map<String, dynamic>> where(
    Object field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    Iterable<Object?>? arrayContainsAny,
    Iterable<Object?>? whereIn,
    Iterable<Object?>? whereNotIn,
    bool? isNull,
  }) {
    filters[field as String] = isEqualTo;
    return this;
  }

  @override
  Query<Map<String, dynamic>> orderBy(Object field, {bool descending = false}) {
    orders[field as String] = descending;
    return this;
  }

  @override
  Query<Map<String, dynamic>> limit(int limit) {
    max = limit;
    return this;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> get([GetOptions? options]) async {
    if (failure != null) throw failure!;
    final docs = records.entries
        .where((e) => filters.entries.every((f) => e.value[f.key] == f.value))
        .map((e) => _Document(e.key, e.value, doc(e.key)))
        .toList();
    return _Snapshot(max == null ? docs : docs.take(max!).toList());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> snapshots({
    bool includeMetadataChanges = false,
    ListenSource source = ListenSource.defaultSource,
  }) => Stream.fromFuture(get());
}

class _Batch extends Fake implements WriteBatch {
  final writes =
      <(DocumentReference<Map<String, dynamic>>, Map<String, dynamic>)>[];
  final updates =
      <(DocumentReference<Map<String, dynamic>>, Map<String, dynamic>)>[];
  @override
  void set<T>(DocumentReference<T> reference, T data, [SetOptions? options]) {
    writes.add((
      reference as DocumentReference<Map<String, dynamic>>,
      data as Map<String, dynamic>,
    ));
  }

  @override
  void update(DocumentReference reference, Map<Object, Object?> data) {
    updates.add((
      reference as DocumentReference<Map<String, dynamic>>,
      data.map((key, value) => MapEntry(key.toString(), value)),
    ));
  }

  @override
  Future<void> commit() async {
    for (final (ref, data) in writes) {
      await ref.set(data);
    }
    for (final (ref, data) in updates) {
      await ref.update(data);
    }
  }
}

class _Firestore extends Fake implements FirebaseFirestore {
  final conversations = _Collection();
  final messages = _Collection();
  _Batch? lastBatch;
  @override
  CollectionReference<Map<String, dynamic>> collection(String path) {
    expect(path, anyOf('conversations', 'messages'));
    return path == 'conversations' ? conversations : messages;
  }

  @override
  WriteBatch batch() => lastBatch = _Batch();
}

void main() {
  late _Auth auth;
  late _Firestore store;
  late _Session session;
  late Dio dio;
  late DioAdapter adapter;
  late FirebaseSupportRepository repository;
  setUp(() {
    auth = _Auth();
    store = _Firestore();
    session = _Session();
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    repository = FirebaseSupportRepository(
      dio: dio,
      session: session,
      auth: auth,
      firestore: store,
      userEmail: 'a@test',
      userName: 'Customer',
    );
  });
  tearDown(() => dio.close());
  void tokenReply(Object? payload) {
    adapter.onPost(
      '/auth/firebase/chat-token',
      (server) => server.reply(200, payload),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          expect(options.method, 'POST');
          expect(options.data, isNull);
          expect(options.queryParameters, isEmpty);
          handler.next(options);
        },
      ),
    );
  }

  test(
    'creates an open conversation with auth principal and profile identity',
    () async {
      final result = await repository.current();
      expect(result.status, SupportStatus.open);
      expect(result.id, 'new-0');
      final data = store.conversations.records[result.id]!;
      expect(data, containsPair('principalId', '42'));
      expect(data, containsPair('userId', 7));
      expect(data, containsPair('userEmail', 'a@test'));
      expect(data, containsPair('userName', 'Customer'));
      expect(data, containsPair('isSupportChat', true));
      expect(data, containsPair('customerUnreadCount', 0));
      expect(data['createdAt'], isA<Timestamp>());
      expect(store.conversations.filters, {
        'principalId': '42',
        'isSupportChat': true,
        'status': 'open',
      });
      expect(store.conversations.orders, {'updatedAt': true});
      expect(store.conversations.max, 1);
    },
  );
  test('reuses matching conversation without creating another', () async {
    store.conversations.records['existing'] = {
      'principalId': '42',
      'isSupportChat': true,
      'status': 'open',
    };
    expect((await repository.current()).id, 'existing');
    expect(store.conversations.records, hasLength(1));
  });
  test(
    'switches Firebase accounts using the canonical token envelope',
    () async {
      auth.user = _User('old');
      tokenReply({
        'status': 1,
        'message': 'ok',
        'data': {'token': 'custom', 'principalId': 42},
      });
      await repository.current();
      expect(auth.token, 'custom');
      expect(auth.signOuts, 1);
    },
  );
  test(
    'rejects token data carried by a failed envelope',
    () async {
      auth.user = null;
      tokenReply({
        'status': 0,
        'message': 'failed',
        'data': {'token': 'custom', 'principalId': 42},
      });
      await expectLater(
        repository.current(),
        throwsA(isA<SupportBackendUnavailableException>()),
      );
      expect(auth.token, isNull);
    },
  );
  test('accepts trimmed string principal from token response', () async {
    auth.user = null;
    tokenReply({
      'status': 1,
      'data': {'token': 'custom', 'principalId': ' 42 '},
    });
    await repository.current();
    expect(auth.token, 'custom');
  });
  for (final payload in [
    null,
    'raw',
    {'data': null},
    {
      'data': {'token': '', 'principalId': 42},
    },
    {
      'data': {'token': 'x', 'principalId': 1},
    },
    {
      'data': {'token': 'x', 'principalId': 42.0},
    },
  ]) {
    test('rejects malformed or mismatched Firebase token $payload', () async {
      auth.user = null;
      tokenReply(payload);
      await expectLater(
        repository.current(),
        throwsA(isA<SupportBackendUnavailableException>()),
      );
      expect(auth.token, isNull);
      expect(store.conversations.records, isEmpty);
    });
  }
  test('signs out if custom token authenticates another principal', () async {
    auth.user = null;
    auth.signedInUid = 'wrong';
    tokenReply({
      'status': 1,
      'data': {'token': 'x', 'principalId': 42},
    });
    await expectLater(
      repository.current(),
      throwsA(isA<SupportBackendUnavailableException>()),
    );
    expect(auth.signOuts, 1);
  });
  test('rejects missing session principal before contacting backend', () async {
    session.id = 0;
    await expectLater(
      repository.current(),
      throwsA(isA<SupportBackendUnavailableException>()),
    );
  });
  for (final status in [403, 500]) {
    test('maps token HTTP $status to support unavailable', () async {
      auth.user = null;
      adapter.onPost(
        '/auth/firebase/chat-token',
        (server) => server.reply(status, {'message': 'failure'}),
      );
      await expectLater(
        repository.current(),
        throwsA(isA<SupportBackendUnavailableException>()),
      );
    });
  }
  test('maps token timeout to support unavailable', () async {
    auth.user = null;
    adapter.onPost(
      '/auth/firebase/chat-token',
      (server) => server.throws(
        408,
        DioException(
          requestOptions: RequestOptions(path: '/auth/firebase/chat-token'),
          type: DioExceptionType.receiveTimeout,
        ),
      ),
    );
    await expectLater(
      repository.current(),
      throwsA(isA<SupportBackendUnavailableException>()),
    );
  });
  test('maps Firebase and unexpected read errors', () async {
    for (final error in [
      FirebaseException(
        plugin: 'firestore',
        code: 'denied',
        message: 'No access',
      ),
      StateError('broken'),
    ]) {
      store.conversations.failure = error;
      await expectLater(
        repository.current(),
        throwsA(isA<SupportBackendUnavailableException>()),
      );
    }
  });
  test('maps ordered messages and sender/read state', () async {
    final time = Timestamp.fromDate(DateTime.utc(2026));
    store.messages.records.addAll({
      'admin': {
        'conversationId': 'c',
        'content': 'reply',
        'senderRole': 'ADMIN',
        'timestamp': time,
        'isRead': true,
      },
      'legacy': {'conversationId': 'c', 'sender': 'support'},
      'customer': {'conversationId': 'c', 'content': 'hello'},
      'other': {'conversationId': 'other'},
    });
    final messages = await repository.watchMessages('c').first;
    expect(messages.map((m) => m.id), ['admin', 'legacy', 'customer']);
    expect(messages.first.body, 'reply');
    expect(messages.first.sentAt, time.toDate().toIso8601String());
    expect(messages.first.isRead, isTrue);
    expect(messages[1].body, '');
    expect(messages[1].sender, SupportMessageSender.support);
    expect(messages.last.sender, SupportMessageSender.customer);
    expect(DateTime.tryParse(messages.last.sentAt), isNotNull);
    expect(store.messages.orders, {'timestamp': false});
  });
  test(
    'sends trimmed text and updates last message/unread counters atomically',
    () async {
      store.conversations.records['c'] = {
        'principalId': '42',
        'status': 'open',
      };
      await repository.sendTextMessage('c', ' hello ');
      final message = store.messages.records.values.single;
      expect(message, containsPair('content', 'hello'));
      expect(message, containsPair('conversationId', 'c'));
      expect(message, containsPair('senderPrincipalId', '42'));
      expect(message, containsPair('senderRole', 'USER'));
      expect(message, containsPair('isRead', false));
      expect(message['timestamp'], FieldValue.serverTimestamp());
      final update = store.lastBatch!.updates.single.$2;
      expect(update['agentUnreadCount'], FieldValue.increment(1));
      expect(update['unreadCount'], FieldValue.increment(1));
      expect((update['lastMessage'] as Map)['content'], 'hello');
    },
  );
  test(
    'rejects blank, oversized, missing, foreign and closed conversations',
    () async {
      for (final content in ['  ', 'x' * 2001]) {
        await expectLater(
          repository.sendTextMessage('c', content),
          throwsA(isA<SupportChatException>()),
        );
      }
      for (final data in [
        <String, dynamic>{},
        {'principalId': 'other', 'status': 'open'},
        {'principalId': '42', 'status': 'closed'},
      ]) {
        store.conversations.records['c'] = data;
        await expectLater(
          repository.sendTextMessage('c', 'hello'),
          throwsA(isA<SupportChatException>()),
        );
      }
      expect(store.messages.records, isEmpty);
      expect(const SupportChatException('message').toString(), 'message');
    },
  );
  test(
    'marks only unread admin messages and clears customer counter',
    () async {
      store.conversations.records['c'] = {};
      store.messages.records.addAll({
        'admin': {
          'conversationId': 'c',
          'senderRole': 'ADMIN',
          'isRead': false,
        },
        'read': {'conversationId': 'c', 'senderRole': 'ADMIN', 'isRead': true},
        'user': {'conversationId': 'c', 'senderRole': 'USER', 'isRead': false},
      });
      await repository.markConversationRead('c');
      expect(store.messages.records['admin']!['isRead'], true);
      expect(store.messages.records['admin']!['readAt'], isA<Timestamp>());
      expect(store.messages.records['user']!['isRead'], false);
      expect(store.lastBatch!.updates, hasLength(2));
      expect(store.conversations.records['c']!['customerUnreadCount'], 0);
    },
  );
  test('closes with principal and normalized optional reason', () async {
    store.conversations.records['c'] = {};
    for (final reason in [' resolved ', ' ', null]) {
      await repository.closeConversation('c', reason: reason);
      final data = store.conversations.records['c']!;
      expect(data['status'], 'closed');
      expect(data['closedBy'], '42');
      expect(data['closedAt'], isA<Timestamp>());
      expect(data['closeReason'], reason == ' resolved ' ? 'resolved' : null);
    }
  });
}
