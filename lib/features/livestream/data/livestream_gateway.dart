import 'package:dio/dio.dart';

import '../domain/entities/livestream_join_session.dart';

final class LivestreamGateway {
  const LivestreamGateway(this._dio);
  final Dio _dio;

  Future<LivestreamJoinSession> join(String livestreamId) async {
    if (!_uuid.hasMatch(livestreamId)) {
      throw const FormatException('Invalid livestream identity');
    }
    final response = await _dio.post<Map<String, dynamic>>(
      '/livestreams/$livestreamId/join',
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
}

final _uuid = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
);
