import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/flash_sale_campaign_entity.dart';
import '../entities/flash_sale_item_entity.dart';

abstract interface class FlashSaleRepository {
  Future<Either<Failure, List<FlashSaleCampaignEntity>>> getActiveCampaigns();

  Future<Either<Failure, List<FlashSaleItemEntity>>> getCampaignItems(
    int campaignId,
  );

  Future<Either<Failure, List<FlashSaleItemEntity>>> getRestaurantItems(
    int restaurantId,
  );
}
