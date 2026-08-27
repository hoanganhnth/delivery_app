import '../entities/livestream_join_session.dart';

abstract interface class LivestreamRepository {
  Future<LivestreamJoinSession> join(String livestreamId);
}
