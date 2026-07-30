import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/utils/logger/app_logger.dart';

abstract interface class DirectionsPort {
  Future<Map<String, dynamic>> getDirections({
    required List<double> origin,
    required List<double> destination,
    String geometries,
  });
}

final mapboxAccessTokenProvider = Provider<String>(
  (ref) => dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '',
);

final mapboxMapServiceProvider = Provider<DirectionsPort>((ref) {
  return MapboxMapService(accessToken: ref.watch(mapboxAccessTokenProvider));
});

class MapboxMapService implements DirectionsPort {
  final Dio _dio;
  final String _accessToken;
  final String _baseUrl = 'https://api.mapbox.com/directions/v5/mapbox/driving';

  MapboxMapService({required String accessToken, Dio? dio})
    : _accessToken = accessToken,
      _dio = dio ?? Dio();

  /// Fetch directions from Mapbox Directions API
  /// [origin] and [destination] must be in [longitude, latitude] format
  /// Returns raw JSON data from Mapbox
  @override
  Future<Map<String, dynamic>> getDirections({
    required List<double> origin,
    required List<double> destination,
    String geometries = 'geojson',
  }) async {
    if (_accessToken.isEmpty) {
      AppLogger.e('MAPBOX_ACCESS_TOKEN is missing in .env file');
      throw Exception('Mapbox access token is missing');
    }

    // Format: longitude,latitude
    final originStr = '${origin[0]},${origin[1]}';
    final destStr = '${destination[0]},${destination[1]}';

    final url =
        '$_baseUrl/$originStr;$destStr?geometries=$geometries&access_token=$_accessToken';

    AppLogger.i('Fetching directions from Mapbox');

    try {
      final response = await _dio.get(url);
      return response.data as Map<String, dynamic>;
    } catch (_) {
      AppLogger.e('Failed to get directions from Mapbox');
      throw Exception('Failed to get directions');
    }
  }
}
