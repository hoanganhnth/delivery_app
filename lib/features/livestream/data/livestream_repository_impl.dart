import '../domain/entities/livestream.dart';
import '../domain/entities/livestream_join_session.dart';
import '../domain/repositories/livestream_repository.dart';
import 'livestream_gateway.dart';

final class LivestreamRepositoryImpl implements LivestreamRepository {
  const LivestreamRepositoryImpl(this._gateway);
  final LivestreamGateway _gateway;

  @override
  Future<List<Livestream>> getActive() => _gateway.getActive();

  @override
  Future<LivestreamJoinSession> join(String livestreamId) =>
      _gateway.join(livestreamId);

  @override
  Future<String> renewToken(LivestreamJoinSession session) =>
      _gateway.renewToken(session);
}
