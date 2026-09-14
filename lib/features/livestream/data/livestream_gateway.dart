import 'package:dio/dio.dart';

import '../domain/entities/livestream.dart';
import '../domain/entities/livestream_join_session.dart';

final class LivestreamGateway {
  const LivestreamGateway(this._dio);
  final Dio _dio;

  Future<Livestream> getById(String livestreamId) async {
    if (!_uuid.hasMatch(livestreamId)) {
      throw const FormatException('Invalid livestream identity');
    }
    final response = await _request(
      () => _dio.get<Map<String, dynamic>>('/livestreams/$livestreamId'),
    );
    final envelope = response.data;
    if (envelope == null ||
        envelope['status'] != 1 ||
        envelope['data'] is! Map) {
      throw const FormatException('Invalid livestream detail envelope');
    }
    final room = Livestream.fromJson(
      Map<String, dynamic>.from(envelope['data'] as Map),
    );
    if (room.id != livestreamId) {
      throw const FormatException('Mismatched livestream identity');
    }
    return room;
  }

  Future<List<Livestream>> getActive() async {
    final response = await _request(
      () => _dio.get<Map<String, dynamic>>('/livestreams/active'),
    );
    final envelope = response.data;
    if (envelope == null ||
        envelope['status'] != 1 ||
        envelope['data'] is! List) {
      throw const FormatException('Invalid active livestream envelope');
    }

    final rooms = (envelope['data'] as List)
        .map((item) {
          if (item is! Map<String, dynamic>) {
            throw const FormatException('Invalid active livestream row');
          }
          final room = Livestream.fromJson(item);
          if (room.status != LivestreamStatus.live) {
            throw const FormatException('Active livestream is not live');
          }
          return room;
        })
        .toList(growable: false);
    return List.unmodifiable(rooms);
  }

  Future<LivestreamJoinSession> join(String livestreamId) async {
    if (!_uuid.hasMatch(livestreamId)) {
      throw const FormatException('Invalid livestream identity');
    }
    final response = await _request(
      () => _dio.post<Map<String, dynamic>>(
        '/livestreams/$livestreamId/join',
      ),
    );
    final envelope = response.data;
    if (envelope == null ||
        envelope['status'] != 1 ||
        envelope['data'] is! Map) {
      throw const FormatException('Invalid livestream join envelope');
    }
    final data = Map<String, dynamic>.from(envelope['data'] as Map);
    final id = data['livestreamId'];
    final channel = data['channelName'];
    final token = data['token'];
    final uid = data['uid'];
    final expiresAt = data['tokenExpiresAt'];
    final title = data['title'];
    final restaurantId = data['restaurantId'];
    final parsedExpiry = expiresAt is String
        ? DateTime.tryParse(expiresAt)?.toUtc()
        : null;
    if (id is! String ||
        id != livestreamId ||
        !_uuid.hasMatch(id) ||
        channel is! String ||
        channel.trim().isEmpty ||
        token is! String ||
        token.trim().isEmpty ||
        uid is! num ||
        uid.toInt() <= 0 ||
        parsedExpiry == null ||
        !parsedExpiry.isAfter(DateTime.now().toUtc()) ||
        title is! String ||
        title.trim().isEmpty ||
        restaurantId is! num ||
        restaurantId.toInt() <= 0) {
      throw const FormatException('Invalid livestream join response');
    }
    return LivestreamJoinSession(
      livestreamId: id,
      channelName: channel.trim(),
      token: token.trim(),
      uid: uid.toInt(),
      expiresAt: parsedExpiry,
      title: title.trim(),
      restaurantId: restaurantId.toInt(),
    );
  }

  Future<String> renewToken(LivestreamJoinSession session) async {
    final response = await _request(
      () => _dio.post<Map<String, dynamic>>(
        '/livestreams/${session.livestreamId}/token/renew',
      ),
    );
    final envelope = response.data;
    if (envelope == null ||
        envelope['status'] != 1 ||
        envelope['data'] is! Map) {
      throw const FormatException('Invalid livestream token renewal envelope');
    }
    final data = Map<String, dynamic>.from(envelope['data'] as Map);
    final id = data['livestreamId'];
    final channel = data['channelName'];
    final token = data['token'];
    final uid = data['uid'];
    final role = data['role'];
    final expiresAt = data['tokenExpiresAt'];
    final parsedExpiry = expiresAt is String
        ? DateTime.tryParse(expiresAt)?.toUtc()
        : null;
    if (id != session.livestreamId ||
        channel != session.channelName ||
        uid is! int ||
        uid != session.uid ||
        role != 'VIEWER' ||
        token is! String ||
        token.trim().isEmpty ||
        parsedExpiry == null ||
        !parsedExpiry.isAfter(DateTime.now().toUtc())) {
      throw const FormatException('Invalid livestream token renewal response');
    }
    return token.trim();
  }

  Future<Response<Map<String, dynamic>>> _request(
    Future<Response<Map<String, dynamic>>> Function() send,
  ) async {
    try {
      return await send();
    } on DioException catch (error) {
      final apiError = LivestreamApiException.tryParse(error);
      if (apiError != null) throw apiError;
      rethrow;
    }
  }
}

final class LivestreamApiException implements Exception {
  const LivestreamApiException({
    required this.status,
    required this.code,
    required this.message,
    this.details,
  });

  final int status;
  final String code;
  final String message;
  final Object? details;

  static LivestreamApiException? tryParse(DioException exception) {
    final payload = exception.response?.data;
    if (payload is! Map) return null;
    final rawError = payload['error'];
    if (rawError is! Map) return null;
    final code = rawError['code'];
    if (code is! String || code.trim().isEmpty) return null;
    final message = payload['message'];
    return LivestreamApiException(
      status: exception.response?.statusCode ?? 0,
      code: code.trim(),
      message: message is String && message.trim().isNotEmpty
          ? message.trim()
          : 'Livestream request failed',
      details: rawError['details'],
    );
  }

  @override
  String toString() => '$code: $message';
}

final _uuid = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
);
