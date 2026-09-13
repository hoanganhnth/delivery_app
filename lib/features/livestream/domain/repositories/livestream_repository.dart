import '../entities/livestream.dart';
import '../entities/livestream_join_session.dart';

abstract interface class LivestreamRepository {
  Future<List<Livestream>> getActive();
  Future<LivestreamJoinSession> join(String livestreamId);
  Future<String> renewToken(LivestreamJoinSession session);
}
