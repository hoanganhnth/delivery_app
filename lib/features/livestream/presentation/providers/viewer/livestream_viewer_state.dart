import 'package:freezed_annotation/freezed_annotation.dart';

part 'livestream_viewer_state.freezed.dart';

/// Viewer session state — Freezed sealed class for exhaustive switch
@freezed
sealed class LivestreamViewerState with _$LivestreamViewerState {
  /// Initial state before any action
  const factory LivestreamViewerState.idle() = LivestreamViewerIdle;

  /// Connecting to Agora (init engine + join API + join channel)
  const factory LivestreamViewerState.connecting() = LivestreamViewerConnecting;

  /// Actively watching the livestream
  const factory LivestreamViewerState.watching({
    required String channelName,
    int? remoteUid,
  }) = LivestreamViewerWatching;

  /// Error occurred during connection or streaming
  const factory LivestreamViewerState.error(String message) = LivestreamViewerError;

  /// Disconnected from the livestream
  const factory LivestreamViewerState.disconnected() = LivestreamViewerDisconnected;
}
