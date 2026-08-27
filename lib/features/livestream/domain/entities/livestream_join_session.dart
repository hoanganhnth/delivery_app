final class LivestreamJoinSession {
  const LivestreamJoinSession({
    required this.livestreamId,
    required this.channelName,
    required this.token,
    required this.uid,
    required this.expiresAt,
    required this.title,
    required this.restaurantId,
  });

  final String livestreamId;
  final String channelName;
  final String token;
  final int uid;
  final DateTime expiresAt;
  final String title;
  final int restaurantId;
}
