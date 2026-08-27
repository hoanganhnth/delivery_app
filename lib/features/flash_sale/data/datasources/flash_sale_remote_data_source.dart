import '../models/flash_sale_campaign_model.dart';
import '../models/flash_sale_item_model.dart';

abstract interface class FlashSaleRemoteDataSource {
  Future<List<FlashSaleCampaignModel>> getActiveCampaigns();

  Future<List<FlashSaleItemModel>> getCampaignItems(int campaignId);
}
