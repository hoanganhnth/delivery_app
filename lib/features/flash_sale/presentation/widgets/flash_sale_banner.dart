import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/flash_sale_provider.dart';
import 'countdown_timer.dart';
import 'flash_sale_item_card.dart';
import 'package:delivery_app/core/routing/routing.dart';

class FlashSaleBanner extends ConsumerWidget {
  const FlashSaleBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCampaignsAsync = ref.watch(activeCampaignsProvider);

    return activeCampaignsAsync.when(
      data: (campaigns) {
        if (campaigns.isEmpty) return const SizedBox.shrink();

        final currentCampaign = campaigns.first;
        final itemsAsync = ref.watch(campaignItemsProvider(currentCampaign.id));

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          color: const Color(0xFFFFF0E6), // Light orange background
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    const Icon(Icons.flash_on, color: Colors.orange, size: 24),
                    const SizedBox(width: 4),
                    const Text(
                      'FLASH SALE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(width: 12),
                    CountdownTimer(
                      endTime: DateTime.parse(currentCampaign.endTime),
                      onFinished: () {
                        ref.invalidate(activeCampaignsProvider);
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Row(
                        children: [
                          Text('Xem thêm',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13)),
                          Icon(Icons.chevron_right,
                              color: Colors.black54, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Items List
              itemsAsync.when(
                data: (items) {
                  if (items.isEmpty) return const SizedBox.shrink();

                  return SizedBox(
                    height: 250,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return FlashSaleItemCard(
                          item: item,
                          onTap: () {
                            // Navigate to Restaurant menu
                            ref
                                .read(routerProvider)
                                .push('/restaurant/${item.restaurantId}');
                          },
                        );
                      },
                    ),
                  );
                },
                loading: () => const SizedBox(
                  height: 250,
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.orange)),
                ),
                error: (error, stack) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}
