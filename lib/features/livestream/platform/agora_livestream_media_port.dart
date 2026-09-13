import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

import '../application/livestream_media_port.dart';
import '../domain/entities/livestream_join_session.dart';
import 'agora_media_operation_queue.dart';
import 'agora_token_renewal.dart';

/// Agora RTC 6.x audience adapter for the customer livestream viewer.
///
/// The App ID is public project configuration. Channel tokens continue to come
/// from the authenticated backend join endpoint; an App Certificate must never
/// be shipped in this app.
final class AgoraLivestreamMediaPort implements LivestreamMediaPort {
  AgoraLivestreamMediaPort({required String appId}) : _appId = appId.trim();

  final String _appId;
  final ValueNotifier<_RemoteVideoState> _videoState = ValueNotifier(
    const _RemoteVideoState.waiting(),
  );
  RtcEngine? _engine;
  LivestreamJoinSession? _session;
  AgoraTokenRenewal? _tokenRenewal;
  final AgoraMediaOperationQueue _operations = AgoraMediaOperationQueue();

  @override
  Future<void> join(
    LivestreamJoinSession session, {
    required Future<String> Function() renewToken,
  }) => _operations.run(() => _join(session, renewToken: renewToken));

  Future<void> _join(
    LivestreamJoinSession session, {
    required Future<String> Function() renewToken,
  }) async {
    if (!_agoraAppId.hasMatch(_appId)) {
      throw const LivestreamMediaUnavailableException(
        'Thiếu cấu hình AGORA_APP_ID cho ứng dụng',
      );
    }

    await _leaveCurrent();
    _session = session;
    _videoState.value = const _RemoteVideoState.waiting();
    final engine = createAgoraRtcEngine();
    _engine = engine;
    final tokenRenewal = AgoraTokenRenewal(
      fetchToken: renewToken,
      applyToken: engine.renewToken,
      onFailure: () {
        if (_engine == engine) {
          _videoState.value = const _RemoteVideoState.failed(
            'Không thể gia hạn phiên xem. Vui lòng kết nối lại.',
          );
        }
      },
    );
    _tokenRenewal = tokenRenewal;

    try {
      await engine.initialize(
        RtcEngineContext(
          appId: _appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );
      engine.registerEventHandler(
        RtcEngineEventHandler(
          onUserJoined: (connection, remoteUid, elapsed) {
            if (_engine == engine &&
                connection.channelId == session.channelName &&
                _videoState.value.remoteUid == null) {
              _videoState.value = _RemoteVideoState.remote(remoteUid);
            }
          },
          onUserOffline: (connection, remoteUid, reason) {
            if (_engine == engine &&
                connection.channelId == session.channelName &&
                _videoState.value.remoteUid == remoteUid) {
              _videoState.value = const _RemoteVideoState.waiting();
            }
          },
          onError: (error, message) {
            if (_engine == engine) {
              _videoState.value = const _RemoteVideoState.failed(
                'Kết nối phát trực tiếp gặp lỗi. Vui lòng thử lại.',
              );
            }
          },
          onRequestToken: (connection) {
            if (connection.channelId == session.channelName &&
                _engine == engine) {
              tokenRenewal.request();
            }
          },
          onTokenPrivilegeWillExpire: (connection, token) {
            if (connection.channelId == session.channelName &&
                _engine == engine) {
              tokenRenewal.request();
            }
          },
        ),
      );
      await engine.enableVideo();
      await engine.joinChannel(
        token: session.token,
        channelId: session.channelName,
        uid: session.uid,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
          clientRoleType: ClientRoleType.clientRoleAudience,
          audienceLatencyLevel:
              AudienceLatencyLevelType.audienceLatencyLevelLowLatency,
          publishCameraTrack: false,
          publishMicrophoneTrack: false,
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
        ),
      );
    } catch (_) {
      await _leaveCurrent();
      throw const LivestreamMediaUnavailableException(
        'Không thể khởi tạo trình phát livestream',
      );
    }
  }

  @override
  Widget buildVideoView() => ValueListenableBuilder<_RemoteVideoState>(
    valueListenable: _videoState,
    builder: (context, state, _) {
      final engine = _engine;
      final session = _session;
      final remoteUid = state.remoteUid;
      if (state.message case final message?) {
        return _VideoStatus(message: message, isError: true);
      }
      if (engine == null || session == null || remoteUid == null) {
        return const _VideoStatus(message: 'Đang chờ nhà hàng bắt đầu phát...');
      }
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine,
          canvas: VideoCanvas(
            uid: remoteUid,
            renderMode: RenderModeType.renderModeHidden,
          ),
          connection: RtcConnection(channelId: session.channelName),
        ),
      );
    },
  );

  @override
  Future<void> leave() => _operations.run(_leaveCurrent);

  Future<void> _leaveCurrent() async {
    final engine = _engine;
    _tokenRenewal?.dispose();
    _tokenRenewal = null;
    _engine = null;
    _session = null;
    _videoState.value = const _RemoteVideoState.waiting();
    if (engine == null) return;
    try {
      await engine.leaveChannel();
    } finally {
      await engine.release();
    }
  }
}

final _agoraAppId = RegExp(r'^[0-9a-fA-F]{32}$');

final class _RemoteVideoState {
  const _RemoteVideoState._({this.remoteUid, this.message});
  const _RemoteVideoState.waiting() : this._();
  const _RemoteVideoState.remote(int uid) : this._(remoteUid: uid);
  const _RemoteVideoState.failed(String message) : this._(message: message);

  final int? remoteUid;
  final String? message;
}

class _VideoStatus extends StatelessWidget {
  const _VideoStatus({required this.message, this.isError = false});

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isError ? Icons.videocam_off_outlined : Icons.live_tv_outlined,
            color: Colors.white70,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
