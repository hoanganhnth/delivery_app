import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/generated/l10n.dart';
import '../services/agora_service.dart';

class LivestreamVideoView extends StatelessWidget {
  final IAgoraService agoraService;
  final int? remoteUid;

  const LivestreamVideoView({
    super.key,
    required this.agoraService,
    this.remoteUid,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    
    if (!agoraService.isInitialized || !agoraService.isJoined) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16.w),
              Text(
                agoraService.isInitialized 
                  ? s.livestreamConnecting 
                  : s.livestreamInitializing,
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    final engine = agoraService.engine;
    if (engine == null || remoteUid == null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16.w),
              Text(
                s.livestreamWaitingStreamer,
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    // Render REMOTE user video (streamer)
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine,
        canvas: VideoCanvas(uid: remoteUid!),
        connection: RtcConnection(channelId: agoraService.channelName ?? ''),
      ),
    );
  }
}
