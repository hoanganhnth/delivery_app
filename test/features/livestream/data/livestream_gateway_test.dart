import 'package:delivery_app/features/livestream/data/livestream_gateway.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream_join_session.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('preserves structured backend error codes without parsing messages', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    adapter.onGet(
      '/livestreams/active',
      (server) => server.reply(404, {
        'status': 0,
        'message': 'Nội dung hiển thị có thể thay đổi',
        'data': null,
        'error': {
          'code': 'LIVESTREAM_DISABLED',
          'details': {'retryable': false},
        },
      }),
    );

    await expectLater(
      LivestreamGateway(dio).getActive(),
      throwsA(
        isA<LivestreamApiException>()
            .having((error) => error.status, 'status', 404)
            .having(
              (error) => error.code,
              'code',
              'LIVESTREAM_DISABLED',
            )
            .having(
              (error) => error.details,
              'details',
              {'retryable': false},
            ),
      ),
    );
  });

  test('loads a matching room detail with pinned products', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    const id = '00000000-0000-4000-8000-000000000001';
    adapter.onGet(
      '/livestreams/$id',
      (server) => server.reply(200, {
        'status': 1,
        'data': {
          'id': id,
          'sellerId': 7,
          'restaurantId': 42,
          'title': 'Bếp đang live',
          'status': 'LIVE',
          'streamProvider': 'AGORA',
          'roomId': 'room-$id',
          'channelName': 'channel-$id',
          'viewCount': 12,
          'pinnedProducts': [
            {
              'id': 91,
              'livestreamId': id,
              'productId': 501,
              'productName': 'Món live',
              'restaurantId': 42,
              'restaurantName': 'Bếp đang live',
              'priceAtLive': 42000,
              'isPinned': true,
            },
          ],
        },
      }),
    );

    final room = await LivestreamGateway(dio).getById(id);

    expect(room.id, id);
    expect(room.pinnedProducts.single.productId, 501);
  });

  test('loads active rooms from the authenticated active endpoint', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    const id = '00000000-0000-4000-8000-000000000001';
    adapter.onGet(
      '/livestreams/active',
      (server) => server.reply(200, {
        'status': 1,
        'data': [
          {
            'id': id,
            'sellerId': 7,
            'restaurantId': 42,
            'title': 'Bếp đang live',
            'description': 'Món nóng vừa ra lò',
            'status': 'LIVE',
            'streamProvider': 'AGORA',
            'roomId': 'room-$id',
            'channelName': 'channel-$id',
            'startedAt': '2099-01-01T00:00:00Z',
            'endedAt': null,
            'viewCount': 12,
            'createdAt': '2099-01-01T00:00:00Z',
            'updatedAt': '2099-01-01T00:00:00Z',
            'pinnedProducts': <Object>[],
          },
        ],
      }),
    );

    final rooms = await LivestreamGateway(dio).getActive();

    expect(rooms, hasLength(1));
    expect(rooms.single.id, id);
    expect(rooms.single.title, 'Bếp đang live');
  });

  test('rejects non-live rows returned by the active endpoint', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    adapter.onGet(
      '/livestreams/active',
      (server) => server.reply(200, {
        'status': 1,
        'data': [
          {
            'id': '00000000-0000-4000-8000-000000000001',
            'sellerId': 7,
            'restaurantId': 42,
            'title': 'Phòng chưa bắt đầu',
            'status': 'CREATED',
            'streamProvider': 'AGORA',
            'roomId': 'room-created',
            'channelName': 'channel-created',
            'startedAt': null,
            'endedAt': null,
            'viewCount': 0,
            'createdAt': '2099-01-01T00:00:00Z',
            'updatedAt': '2099-01-01T00:00:00Z',
            'pinnedProducts': <Object>[],
          },
        ],
      }),
    );

    await expectLater(
      LivestreamGateway(dio).getActive(),
      throwsFormatException,
    );
  });

  test(
    'parses only a server-issued UUID, token, channel, and expiry',
    () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
      final adapter = DioAdapter(dio: dio);
      const id = '00000000-0000-4000-8000-000000000001';
      adapter.onPost(
        '/livestreams/$id/join',
        (server) => server.reply(200, {
          'status': 1,
          'data': {
            'livestreamId': id,
            'channelName': 'server-channel',
            'token': 'server-token',
            'uid': 501,
            'tokenExpiresAt': '2099-01-01T00:00:00Z',
            'title': 'Live kitchen',
            'restaurantId': 42,
          },
        }),
      );

      final session = await LivestreamGateway(dio).join(id);

      expect(session.livestreamId, id);
      expect(session.channelName, 'server-channel');
      expect(session.token, 'server-token');
      expect(session.uid, 501);
    },
  );

  test('rejects a malformed or caller-mismatched join response', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    const id = '00000000-0000-4000-8000-000000000001';
    adapter.onPost(
      '/livestreams/$id/join',
      (server) => server.reply(200, {
        'status': 1,
        'data': {
          'livestreamId': '00000000-0000-4000-8000-000000000002',
          'channelName': 'server-channel',
          'token': 'server-token',
          'uid': 501,
          'tokenExpiresAt': '2099-01-01T00:00:00Z',
          'title': 'Live kitchen',
          'restaurantId': 42,
        },
      }),
    );

    expect(() => LivestreamGateway(dio).join(id), throwsFormatException);
  });

  test('renews only a matching viewer token through the exact route', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    const id = '00000000-0000-4000-8000-000000000001';
    final session = LivestreamJoinSession(
      livestreamId: id,
      channelName: 'server-channel',
      token: 'server-token',
      uid: 501,
      expiresAt: DateTime.utc(2099),
      title: 'Live kitchen',
      restaurantId: 42,
    );
    adapter.onPost(
      '/livestreams/$id/token/renew',
      (server) => server.reply(200, {
        'status': 1,
        'data': {
          'livestreamId': id,
          'channelName': 'server-channel',
          'token': 'renewed-viewer-token',
          'uid': 501,
          'role': 'VIEWER',
          'tokenExpiresAt': '2099-01-01T01:00:00Z',
        },
      }),
    );

    await expectLater(
      LivestreamGateway(dio).renewToken(session),
      completion('renewed-viewer-token'),
    );
  });

  test('rejects renewal for a different media identity', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    const id = '00000000-0000-4000-8000-000000000001';
    final session = LivestreamJoinSession(
      livestreamId: id,
      channelName: 'server-channel',
      token: 'server-token',
      uid: 501,
      expiresAt: DateTime.utc(2099),
      title: 'Live kitchen',
      restaurantId: 42,
    );
    adapter.onPost(
      '/livestreams/$id/token/renew',
      (server) => server.reply(200, {
        'status': 1,
        'data': {
          'livestreamId': id,
          'channelName': 'server-channel',
          'token': 'host-token',
          'uid': 501,
          'role': 'HOST',
          'tokenExpiresAt': '2099-01-01T01:00:00Z',
        },
      }),
    );

    await expectLater(
      LivestreamGateway(dio).renewToken(session),
      throwsFormatException,
    );
  });
}
