import 'package:equatable/equatable.dart';

import '../domain/entities/flash_sale_campaign_entity.dart';
import '../domain/entities/flash_sale_item_entity.dart';

final class FlashSaleViewState extends Equatable {
  const FlashSaleViewState({
    this.campaign,
    this.items = const <FlashSaleItemEntity>[],
    this.isLoading = false,
    this.errorMessage,
  });

  final FlashSaleCampaignEntity? campaign;
  final List<FlashSaleItemEntity> items;
  final bool isLoading;
  final String? errorMessage;

  bool get isVisible => campaign?.isActive == true && items.isNotEmpty;
  bool get hasError => errorMessage != null;

  @override
  List<Object?> get props => [campaign, items, isLoading, errorMessage];
}
