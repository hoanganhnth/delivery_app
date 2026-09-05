import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => unawaited(
        ref.read(livestreamViewerProvider(widget.livestreamId).notifier).join(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(livestreamViewerProvider(widget.livestreamId));
    void retry() => unawaited(
      ref.read(livestreamViewerProvider(widget.livestreamId).notifier).join(),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Livestream')),
      body: Center(
        child: switch (state.phase) {
          LivestreamViewerPhase.disabled => const Text(
            'Livestream hiện không khả dụng',
          ),
          LivestreamViewerPhase.loading => const CircularProgressIndicator(),
          LivestreamViewerPhase.mediaUnavailable => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Thiết bị không hỗ trợ phát livestream'),
              TextButton(onPressed: retry, child: const Text('Thử lại')),
            ],
          ),
          LivestreamViewerPhase.error => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.message ?? 'Không thể tham gia'),
              TextButton(onPressed: retry, child: const Text('Thử lại')),
            ],
          ),
          _ => Text(state.session?.title ?? 'Sẵn sàng tham gia livestream'),
        },
      ),
    );
  }
}
