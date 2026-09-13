import 'package:flutter/widgets.dart';

import '../domain/entities/livestream_join_session.dart';

abstract interface class LivestreamMediaPort {
  Future<void> join(
    LivestreamJoinSession session, {
    required Future<String> Function() renewToken,
  });
  Future<void> leave();
  Widget buildVideoView();
}

/// Used when real playback cannot start. The message is safe to show to users
/// and deliberately does not include an Agora token or low-level SDK details.
final class LivestreamMediaUnavailableException implements Exception {
  const LivestreamMediaUnavailableException([
    this.message = 'Phát livestream tạm thời chưa khả dụng',
  ]);

  final String message;
}

/// A non-playing fallback for tests and explicitly unsupported platforms.
final class UnsupportedLivestreamMediaPort implements LivestreamMediaPort {
  const UnsupportedLivestreamMediaPort();

  @override
  Future<void> join(
    LivestreamJoinSession session, {
    required Future<String> Function() renewToken,
  }) => Future.error(const LivestreamMediaUnavailableException());

  @override
  Future<void> leave() async {}

  @override
  Widget buildVideoView() => const SizedBox.shrink();
}
