import 'package:delivery_app/features/livestream/domain/entities/livestream.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream_join_session.dart';
import 'package:delivery_app/features/livestream/domain/repositories/livestream_repository.dart';
import 'package:delivery_app/features/livestream/domain/usecases/join_livestream_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('joins only through the repository boundary', () async {
    final repository = _FakeLivestreamRepository();
    final useCase = JoinLivestreamUseCase(repository);

    final session = await useCase('00000000-0000-4000-8000-000000000001');

    expect(repository.joinedId, '00000000-0000-4000-8000-000000000001');
    expect(session.channelName, 'server-channel');
  });
}

final class _FakeLivestreamRepository implements LivestreamRepository {
  String? joinedId;

  @override
  Future<List<Livestream>> getActive() async => const [];

  @override
  Future<Livestream> getById(String livestreamId) => throw UnimplementedError();

  @override
  Future<LivestreamJoinSession> join(String livestreamId) async {
    joinedId = livestreamId;
    return LivestreamJoinSession(
      livestreamId: livestreamId,
      channelName: 'server-channel',
      token: 'server-token',
      uid: 10,
      expiresAt: DateTime.utc(2027),
      title: 'Server title',
      restaurantId: 42,
    );
  }

  @override
  Future<String> renewToken(LivestreamJoinSession session) async =>
      'renewed-server-token';
}
