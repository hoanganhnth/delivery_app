import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_campaign_entity.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_item_entity.dart';
import 'package:delivery_app/features/flash_sale/di/flash_sale_providers.dart';
import 'package:delivery_app/features/flash_sale/domain/usecases/flash_sale_usecases.dart';

import 'flash_sale_state.dart';

final flashSaleViewModelProvider =
    NotifierProvider<FlashSaleViewModel, FlashSaleViewState>(
      FlashSaleViewModel.new,
    );

class FlashSaleViewModel extends Notifier<FlashSaleViewState> {
  bool _isLoading = false;

  @override
  FlashSaleViewState build() => const FlashSaleViewState();

  Future<void> load({bool force = false}) async {
    if (_isLoading && !force) return;
    if (!ref.read(flashSaleCheckoutEnabledProvider)) {
      state = const FlashSaleViewState();
      return;
    }
    _isLoading = true;
    state = const FlashSaleViewState(isLoading: true);
    try {
      final campaignsResult = await ref
          .read(getActiveFlashSaleCampaignsUseCaseProvider)
          .call(const GetActiveFlashSaleCampaignsParams());
      if (!ref.mounted) return;
      final campaigns = campaignsResult.fold<List<FlashSaleCampaignEntity>>((
        failure,
      ) {
        state = FlashSaleViewState(errorMessage: failure.message);
        return const [];
      }, (items) => items);
      if (state.hasError) return;
      if (campaigns.isEmpty) {
        state = const FlashSaleViewState();
        return;
      }
      final activeCampaigns = campaigns
          .where((campaign) => campaign.isActive)
          .toList(growable: false);
      if (activeCampaigns.isEmpty) {
        state = const FlashSaleViewState();
        return;
      }
      final itemsResults = await Future.wait(
        activeCampaigns.map(
          (campaign) => ref
              .read(getFlashSaleCampaignItemsUseCaseProvider)
              .call(GetFlashSaleCampaignItemsParams(campaignId: campaign.id)),
        ),
      );
      if (!ref.mounted) return;
      final items = <FlashSaleItemEntity>[];
      String? partialErrorMessage;
      for (final result in itemsResults) {
        result.fold(
          (failure) => partialErrorMessage ??= failure.message,
          items.addAll,
        );
      }
      final availableItems = List<FlashSaleItemEntity>.unmodifiable(
        items.where((item) => item.isApproved && item.hasStock),
      );
      if (availableItems.isEmpty && partialErrorMessage != null) {
        state = FlashSaleViewState(errorMessage: partialErrorMessage);
        return;
      }
      state = FlashSaleViewState(
        campaign: activeCampaigns.first,
        items: availableItems,
        partialErrorMessage: partialErrorMessage,
      );
    } finally {
      _isLoading = false;
    }
  }
}
