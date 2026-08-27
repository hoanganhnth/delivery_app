import 'package:flutter/material.dart';

import '../../application/flash_sale_state.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/flash_sale_item_card.dart';

class FlashSaleBannerView extends StatelessWidget {
  const FlashSaleBannerView({
    super.key,
    required this.state,
    required this.onRestaurantSelected,
    required this.onRefreshRequested,
  });

  final FlashSaleViewState state;
  final ValueChanged<int> onRestaurantSelected;
  final VoidCallback onRefreshRequested;

  @override
  Widget build(BuildContext context) {
    final campaign = state.campaign;
    if (state.isLoading) {
      return const _FlashSaleStatusCard(
        key: Key('flash_sale_loading'),
        child: CircularProgressIndicator(),
      );
    }
    if (state.hasError) {
      return _FlashSaleStatusCard(
        key: const Key('flash_sale_error'),
        child: Row(
          children: [
            const Expanded(child: Text('Không thể tải Flash Sale')),
            TextButton(
              key: const Key('flash_sale_retry'),
              onPressed: onRefreshRequested,
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }
    if (!state.isVisible || campaign == null) return const SizedBox.shrink();
    final endAt = campaign.endAt();
    if (endAt == null) return const SizedBox.shrink();
    return Card(
      key: const Key('flash_sale_banner'),
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      color: Theme.of(
        context,
      ).colorScheme.errorContainer.withValues(alpha: 0.45),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 2, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.flash_on,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    campaign.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                FlashSaleCountdownTimer(
                  endAt: endAt,
                  onFinished: onRefreshRequested,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 232,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return FlashSaleItemCard(
                    item: item,
                    onTap: () => onRestaurantSelected(item.restaurantId),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlashSaleStatusCard extends StatelessWidget {
  const _FlashSaleStatusCard({required super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Center(child: child),
    ),
  );
}
