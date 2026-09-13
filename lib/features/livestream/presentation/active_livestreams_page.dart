import 'dart:async';

import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/active_livestreams_view_model.dart';
import '../domain/entities/livestream.dart';

class ActiveLivestreamsPage extends ConsumerStatefulWidget {
  const ActiveLivestreamsPage({super.key});

  @override
  ConsumerState<ActiveLivestreamsPage> createState() =>
      _ActiveLivestreamsPageState();
}

class _ActiveLivestreamsPageState extends ConsumerState<ActiveLivestreamsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(ref.read(activeLivestreamsProvider.notifier).load());
      }
    });
  }

  void _retry() =>
      unawaited(ref.read(activeLivestreamsProvider.notifier).load());

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(activeLivestreamsProvider);
    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      appBar: PreviewPageHeader(
        title: 'Livestream đang phát',
        onBack: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.main);
          }
        },
      ),
      body: switch (state.phase) {
        ActiveLivestreamsPhase.idle ||
        ActiveLivestreamsPhase.loading => const Center(
          child: CircularProgressIndicator(color: PreviewUi.accent),
        ),
        ActiveLivestreamsPhase.disabled => const PreviewEmptyState(
          icon: Icons.live_tv_outlined,
          title: 'Livestream hiện không khả dụng',
          message: 'Tính năng đang được chuẩn bị để mở lại.',
        ),
        ActiveLivestreamsPhase.error => PreviewEmptyState(
          icon: Icons.wifi_off_outlined,
          title: state.message ?? 'Không thể tải livestream',
          message: 'Kiểm tra kết nối và thử lại.',
          actionLabel: 'Thử lại',
          onAction: _retry,
        ),
        ActiveLivestreamsPhase.ready when state.rooms.isEmpty =>
          const PreviewEmptyState(
            icon: Icons.live_tv_outlined,
            title: 'Chưa có livestream nào đang phát',
            message: 'Các buổi phát mới sẽ xuất hiện tại đây.',
          ),
        ActiveLivestreamsPhase.ready => RefreshIndicator(
          color: PreviewUi.accent,
          onRefresh: () => ref.read(activeLivestreamsProvider.notifier).load(),
          child: ListView.separated(
            key: const Key('active-livestream-list'),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.rooms.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) => _LivestreamCard(
              room: state.rooms[index],
              onTap: () => context.push(
                AppRoutes.livestreamViewerPath(state.rooms[index].id),
              ),
            ),
          ),
        ),
      },
    );
  }
}

class _LivestreamCard extends StatelessWidget {
  const _LivestreamCard({required this.room, required this.onTap});

  final Livestream room;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final image = room.pinnedProducts
        .map((product) => product.productImage?.trim())
        .whereType<String>()
        .where((value) => value.isNotEmpty)
        .firstOrNull;
    return PreviewSurface(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: InkWell(
        key: ValueKey('livestream-${room.id}'),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppContentImage(
              imageUrl: image,
              semanticLabel: room.title,
              width: 132,
              height: 96,
              borderRadius: BorderRadius.zero,
              placeholderIcon: Icons.live_tv_outlined,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.sensors,
                          size: 15,
                          color: PreviewUi.accent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'ĐANG LIVE',
                          style: TextStyle(
                            color: PreviewUi.accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.visibility_outlined,
                          size: 15,
                          color: PreviewUi.muted(context),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${room.viewCount ?? 0}',
                          style: TextStyle(
                            color: PreviewUi.muted(context),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
