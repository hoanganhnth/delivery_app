import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/cart/di/cart_commands_provider.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_item_entity.dart';
import '../application/livestream_viewer_view_model.dart';
import '../domain/entities/livestream.dart';

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

  Future<void> _addProduct(LivestreamProduct product) async {
    try {
      await ref
          .read(cartCommandsProvider)
          .addItem(
            CartItemEntity(
              menuItemId: product.productId,
              menuItemName: product.productName,
              price: product.priceAtLive,
              quantity: 1,
              restaurantId: product.restaurantId,
              restaurantName: product.restaurantName,
              imageUrl: product.productImage,
            ),
            livestreamId: product.livestreamId,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã thêm món live vào giỏ')));
    } catch (error) {
      if (!mounted) return;
      final message = error is Failure
          ? error.message
          : 'Không thể thêm món vào giỏ';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(livestreamViewerProvider(widget.livestreamId));
    final disabled = state.phase == LivestreamViewerPhase.disabled;
    final loading = state.phase == LivestreamViewerPhase.loading;
    final session = state.session;
    final room = state.room;
    final pinnedProducts =
        room?.pinnedProducts
            .where((product) => product.isPinned)
            .toList(growable: false) ??
        const <LivestreamProduct>[];
    final message = switch (state.phase) {
      LivestreamViewerPhase.disabled => 'Livestream hiện không khả dụng',
      LivestreamViewerPhase.loading => 'Đang kết nối phòng livestream...',
      LivestreamViewerPhase.error => state.message ?? 'Không thể tham gia',
      LivestreamViewerPhase.mediaUnavailable =>
        state.message ?? 'Phát livestream tạm thời chưa khả dụng',
      LivestreamViewerPhase.joined => 'Đã tham gia phòng livestream',
      LivestreamViewerPhase.idle => 'Sẵn sàng tham gia livestream',
    };
    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      appBar: PreviewPageHeader(
        title: 'Livestream',
        onBack: () => Navigator.of(context).maybePop(),
        onCart: () => context.go(AppRoutes.cart),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: [
          Container(
            color: const Color(0xFF171717),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: state.phase == LivestreamViewerPhase.joined
                  ? ref.read(livestreamMediaPortProvider).buildVideoView()
                  : Center(
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
                  room?.title ?? session?.title ?? 'ShopeeFood Livestream',
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
                if (room != null) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Món đang ghim',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  if (pinnedProducts.isEmpty)
                    Text(
                      'Chưa có món ghim.',
                      style: TextStyle(color: PreviewUi.muted(context)),
                    )
                  else
                    ...pinnedProducts.map(
                      (product) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _PinnedProductCard(
                          product: product,
                          onAdd: () => _addProduct(product),
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

class _PinnedProductCard extends StatelessWidget {
  const _PinnedProductCard({required this.product, required this.onAdd});

  final LivestreamProduct product;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: PreviewUi.divider(context)),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.priceAtLive.toStringAsFixed(0)} ₫',
                    style: const TextStyle(
                      color: PreviewUi.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            FilledButton(
              key: ValueKey('add-live-product-${product.productId}'),
              onPressed: onAdd,
              style: FilledButton.styleFrom(
                backgroundColor: PreviewUi.accent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Thêm'),
            ),
          ],
        ),
      ),
    );
  }
}
