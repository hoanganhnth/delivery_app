import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import '../application/livestream_viewer_view_model.dart';

class LivestreamViewerPage extends ConsumerStatefulWidget {
  const LivestreamViewerPage({super.key, required this.livestreamId});
  final String livestreamId;

  @override
  ConsumerState<LivestreamViewerPage> createState() =>
      _LivestreamViewerPageState();
}

class _LivestreamViewerPageState extends ConsumerState<LivestreamViewerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _join();
    });
  }

  void _join() => unawaited(
    ref.read(livestreamViewerProvider(widget.livestreamId).notifier).join(),
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(livestreamViewerProvider(widget.livestreamId));
    final disabled = state.phase == LivestreamViewerPhase.disabled;
    final loading = state.phase == LivestreamViewerPhase.loading;
    final session = state.session;
    final message = switch (state.phase) {
      LivestreamViewerPhase.disabled => 'Livestream hiện không khả dụng',
      LivestreamViewerPhase.loading => 'Đang kết nối phòng livestream...',
      LivestreamViewerPhase.error => state.message ?? 'Không thể tham gia',
      LivestreamViewerPhase.mediaUnavailable =>
        'Thiết bị không hỗ trợ phát livestream',
      LivestreamViewerPhase.idle => 'Sẵn sàng tham gia livestream',
    };
    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      appBar: PreviewPageHeader(
        title: 'Livestream',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: [
          Container(
            color: const Color(0xFF171717),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Center(
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Icon(
                        Icons.videocam_off_outlined,
                        size: 48,
                        color: Colors.white.withValues(alpha: .72),
                      ),
              ),
            ),
          ),
          PreviewSurface(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  session?.title ?? 'ShopeeFood Livestream',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  message,
                  style: TextStyle(
                    color: PreviewUi.muted(context),
                    fontSize: 12,
                  ),
                ),
                if (!disabled && !loading) ...[
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _join,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Thử lại'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PreviewUi.accent,
                      side: const BorderSide(color: PreviewUi.accent),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
