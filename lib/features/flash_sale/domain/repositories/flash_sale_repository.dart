import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/flash_sale_campaign_entity.dart';
import '../entities/flash_sale_item_entity.dart';

/// Repository interface cho Flash Sale (domain layer)
abstract class FlashSaleRepository {
  /// Lấy danh sách campaign đang active
  Future<Either<Failure, List<FlashSaleCampaignEntity>>> getActiveCampaigns();

  /// Lấy danh sách item trong 1 campaign
  Future<Either<Failure, List<FlashSaleItemEntity>>> getCampaignItems(int campaignId);
}
