import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/utils/logger/app_logger.dart';
import '../../services/agora_service.dart';
import '../di/livestream_di_providers.dart';
import '../detail/livestream_detail_notifier.dart';
import 'agora_service_provider.dart';
import 'livestream_viewer_state.dart';

part 'livestream_viewer_notifier.g.dart';

/// Orchestrates the entire viewer join flow:
/// Load Detail → Join API → Init Agora → Join Channel
///
/// Screen only needs: ref.watch(livestreamViewerProvider(id))
@riverpod
class LivestreamViewer extends _$LivestreamViewer {
  StreamSubscription? _remoteUidSubscription;
  StreamSubscription? _errorSubscription;

  @override
  LivestreamViewerState build(num livestreamId) {
    ref.onDispose(_cleanup);

    // Start join flow immediately
    Future.microtask(() => joinLivestream());

    return const LivestreamViewerState.idle();
  }

  /// Full join flow — called once on build, or on manual retry
  Future<void> joinLivestream() async {
    state = const LivestreamViewerState.connecting();

    try {
      // 1. Load livestream detail (metadata)
      await ref
          .read(livestreamDetailProvider(livestreamId).notifier)
          .loadLivestreamDetail(livestreamId);
      if (!ref.mounted) return;

      // 2. Call join API to get Agora token
      final repository = ref.read(livestreamRepositoryProvider);
      final joinResult = await repository.joinLivestream(livestreamId);
      if (!ref.mounted) return;

      joinResult.fold(
        (failure) {
          state = LivestreamViewerState.error(
            failure.message,
          );
        },
        (joinData) async {
          // 3. Initialize Agora service
          final agora =
              ref.read(agoraServiceForViewerProvider(livestreamId));
          final initialized = await agora.initialize();
          if (!ref.mounted) return;

          if (!initialized) {
            state = const LivestreamViewerState.error(
              'Không thể khởi tạo video player',
            );
            return;
          }

          // 4. Join Agora channel with token from backend
          await agora.joinChannel(
            token: joinData.token,
            channelName: joinData.channelName,
            uid: joinData.uid,
          );
          if (!ref.mounted) return;

          // 5. Listen to Agora events
          _listenToAgoraEvents(agora, joinData.channelName);

          // 6. Update viewer count if available
          if (joinData.currentViewers != null) {
            ref
                .read(livestreamDetailProvider(livestreamId).notifier)
                .updateViewerCount(joinData.currentViewers!);
          }

          state = LivestreamViewerState.watching(
            channelName: joinData.channelName,
            remoteUid: agora.remoteUid,
          );
        },
      );
    } catch (e) {
      AppLogger.e('Failed to join livestream', e);
      if (!ref.mounted) return;
      state = LivestreamViewerState.error('Lỗi kết nối: ${e.toString()}');
    }
  }

  /// Listen to Agora remote user changes & errors
  void _listenToAgoraEvents(IAgoraService agora, String channelName) {
    _remoteUidSubscription?.cancel();
    _errorSubscription?.cancel();

    _remoteUidSubscription = agora.onRemoteUserChanged.listen((uid) {
      if (!ref.mounted) return;
      final current = state;
      if (current is LivestreamViewerWatching) {
        state = current.copyWith(remoteUid: uid);
      } else if (uid != null) {
        // Streamer joined — transition to watching
        state = LivestreamViewerState.watching(
          channelName: channelName,
          remoteUid: uid,
        );
      }
    });

    _errorSubscription = agora.onError.listen((error) {
      if (!ref.mounted) return;
      AppLogger.e('Agora error: ${error.message}');
      // Don't transition to error state for non-critical errors
      // Only connection loss should trigger error state
      if (error.code == -2) {
        state = LivestreamViewerState.error(error.message);
      }
    });
  }

  /// Leave livestream gracefully
  Future<void> leaveLivestream() async {
    try {
      final agora = ref.read(agoraServiceForViewerProvider(livestreamId));
      await agora.leaveChannel();
    } catch (e) {
      AppLogger.e('Error leaving livestream', e);
    }
    if (!ref.mounted) return;
    state = const LivestreamViewerState.disconnected();
  }

  /// Cleanup all resources — called by ref.onDispose
  void _cleanup() {
    AppLogger.d('Cleaning up LivestreamViewer for $livestreamId');
    _remoteUidSubscription?.cancel();
    _errorSubscription?.cancel();
    _remoteUidSubscription = null;
    _errorSubscription = null;
  }
}
