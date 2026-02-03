import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../../../../core/config/agora_config.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/livestream_entity.dart';

/// Service quản lý Agora RTC Engine
class AgoraService {
  RtcEngine? _engine;
  bool _isInitialized = false;
  bool _isJoined = false;

  final StreamController<bool> _joinController = StreamController.broadcast();
  final StreamController<AgoraError> _errorController = StreamController.broadcast();

  Stream<bool> get onJoinChannel => _joinController.stream;
  Stream<AgoraError> get onError => _errorController.stream;

  bool get isJoined => _isJoined;
  bool get isInitialized => _isInitialized;
  RtcEngine? get engine => _engine;

  /// Initialize Agora RTC Engine
  Future<bool> initialize() async {
    if (_isInitialized) {
      AppLogger.w('Agora already initialized');
      return true;
    }

    try {
      AppLogger.d('Initializing Agora RTC Engine');
      
      _engine = createAgoraRtcEngine();
      await _engine!.initialize(
        RtcEngineContext(
          appId: AgoraConfig.appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      // Set client role to audience (viewer)
      await _engine!.setClientRole(role: ClientRoleType.clientRoleAudience);

      // Register event handlers
      _registerEventHandlers();

      // Apply video encoding configs
      await _engine!.setVideoEncoderConfiguration(
        VideoEncoderConfiguration(
          dimensions: VideoDimensions(
            width: AgoraConfig.videoWidth,
            height: AgoraConfig.videoHeight,
          ),
          frameRate: AgoraConfig.videoFrameRate,
          bitrate: AgoraConfig.videoBitrate,
        ),
      );

      _isInitialized = true;
      AppLogger.i('Agora RTC Engine initialized successfully');
      return true;
    } catch (e) {
      AppLogger.e('Failed to initialize Agora RTC Engine', e);
      _errorController.add(AgoraError(
        code: -1,
        message: 'Không thể khởi tạo Agora: ${e.toString()}',
      ));
      return false;
    }
  }

  /// Register event handlers
  void _registerEventHandlers() {
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          AppLogger.i('Joined channel: ${connection.channelId}');
          _isJoined = true;
          _joinController.add(true);
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          AppLogger.i('Left channel: ${connection.channelId}');
          _isJoined = false;
          _joinController.add(false);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          AppLogger.d('Remote user joined: $remoteUid');
        },
        onUserOffline: (
          RtcConnection connection,
          int remoteUid,
          UserOfflineReasonType reason,
        ) {
          AppLogger.d('Remote user offline: $remoteUid, reason: $reason');
        },
        onError: (ErrorCodeType err, String msg) {
          AppLogger.e('Agora error: $err - $msg');
          _errorController.add(AgoraError(
            code: err.value(),
            message: msg,
          ));
        },
        onConnectionLost: (RtcConnection connection) {
          AppLogger.w('Connection lost');
          _errorController.add(AgoraError(
            code: -2,
            message: 'Mất kết nối với livestream',
          ));
        },
        onConnectionStateChanged: (
          RtcConnection connection,
          ConnectionStateType state,
          ConnectionChangedReasonType reason,
        ) {
          AppLogger.d('Connection state changed: $state, reason: $reason');
        },
      ),
    );
  }

  /// Join Agora channel
  Future<bool> joinChannel(LivestreamEntity livestream) async {
    if (!_isInitialized) {
      AppLogger.e('Agora not initialized, cannot join channel');
      return false;
    }

    if (_isJoined) {
      AppLogger.w('Already joined a channel');
      return true;
    }

    try {
      AppLogger.d('Joining channel: ${livestream.channelName}');
      
      await _engine!.joinChannel(
        token: livestream.rtcToken,
        channelId: livestream.channelName,
        uid: 0, // 0 means auto-generate UID
        options: const ChannelMediaOptions(
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
          clientRoleType: ClientRoleType.clientRoleAudience,
        ),
      );

      return true;
    } catch (e) {
      AppLogger.e('Failed to join channel', e);
      _errorController.add(AgoraError(
        code: -3,
        message: 'Không thể tham gia livestream: ${e.toString()}',
      ));
      return false;
    }
  }

  /// Leave channel
  Future<void> leaveChannel() async {
    if (!_isJoined) {
      AppLogger.w('Not joined any channel');
      return;
    }

    try {
      AppLogger.d('Leaving channel');
      await _engine?.leaveChannel();
      _isJoined = false;
    } catch (e) {
      AppLogger.e('Failed to leave channel', e);
    }
  }

  /// Dispose service and release resources
  Future<void> dispose() async {
    AppLogger.d('Disposing Agora service');
    
    await leaveChannel();
    await _engine?.release();
    
    await _joinController.close();
    await _errorController.close();
    
    _engine = null;
    _isInitialized = false;
    _isJoined = false;
    
    AppLogger.i('Agora service disposed');
  }
}

/// Agora error model
class AgoraError {
  final int code;
  final String message;

  AgoraError({required this.code, required this.message});

  @override
  String toString() => 'AgoraError(code: $code, message: $message)';
}
