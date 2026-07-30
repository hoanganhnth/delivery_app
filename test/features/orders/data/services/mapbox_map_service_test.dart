import 'package:delivery_app/features/orders/data/services/mapbox_map_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test(
    'directions adapter uses injected token and canonical coordinates',
    () async {
      final dio = Dio();
      final adapter = DioAdapter(dio: dio);
      final service = MapboxMapService(accessToken: 'map.test.token', dio: dio);
      const url =
          'https://api.mapbox.com/directions/v5/mapbox/driving/'
          '106.7,10.77;106.71,10.78?geometries=geojson&access_token=map.test.token';
      adapter.onGet(
        url,
        (server) => server.reply(200, {
          'routes': [
            {
              'geometry': {
                'coordinates': [
                  [106.7, 10.77],
                  [106.71, 10.78],
                ],
              },
            },
          ],
        }),
      );

      final result = await service.getDirections(
        origin: const [106.7, 10.77],
        destination: const [106.71, 10.78],
      );

      expect(result['routes'], isNotEmpty);
    },
  );

  test('directions adapter fails closed without an access token', () async {
    final service = MapboxMapService(accessToken: '');

    expect(
      () => service.getDirections(
        origin: const [106.7, 10.77],
        destination: const [106.71, 10.78],
      ),
      throwsException,
    );
  });
}
