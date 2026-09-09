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
      return const SizedBox.shrink();
    }
    if (campaign?.isActive == true && state.items.isEmpty) {
      return const _FlashSaleStatusCard(
        key: Key('flash_sale_empty'),
        child: Text('Hiện chưa có món Flash Sale khả dụng'),
      );
    }
    if (!state.isVisible || campaign == null) return const SizedBox.shrink();
    final endAt = campaign.endAt();
    if (endAt == null) return const SizedBox.shrink();
    return Container(
      key: const Key('flash_sale_banner'),
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      color: Theme.of(context).colorScheme.surface,
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
              height:
                  232 *
                  MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 2.0),
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
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 8, bottom: 4),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Center(child: child),
    ),
  );
}
