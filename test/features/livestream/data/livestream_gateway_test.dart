import 'package:delivery_app/features/livestream/data/livestream_gateway.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('parses only a server-issued UUID, token, channel, and expiry', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    const id = '00000000-0000-4000-8000-000000000001';
    adapter.onPost('/livestreams/$id/join', (server) => server.reply(200, {
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
        }));

    final session = await LivestreamGateway(dio).join(id);

    expect(session.livestreamId, id);
    expect(session.channelName, 'server-channel');
    expect(session.token, 'server-token');
    expect(session.uid, 501);
  });

  test('rejects a malformed or caller-mismatched join response', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://gateway.example.test/api'));
    final adapter = DioAdapter(dio: dio);
    const id = '00000000-0000-4000-8000-000000000001';
    adapter.onPost('/livestreams/$id/join', (server) => server.reply(200, {
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
        }));

    expect(() => LivestreamGateway(dio).join(id), throwsFormatException);
  });
}
