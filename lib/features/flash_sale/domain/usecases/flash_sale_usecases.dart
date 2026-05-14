import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/flash_sale_campaign_entity.dart';
import '../entities/flash_sale_item_entity.dart';
import '../repositories/flash_sale_repository.dart';

/// Use case: Lấy danh sách Flash Sale campaign đang active
class GetActiveCampaignsUseCase
    extends UseCase<List<FlashSaleCampaignEntity>, NoParams> {
  final FlashSaleRepository repository;

  GetActiveCampaignsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FlashSaleCampaignEntity>>> call(
      NoParams params) async {
    return repository.getActiveCampaigns();
  }
}

/// Use case: Lấy danh sách item trong 1 campaign
class GetCampaignItemsUseCase
    extends UseCase<List<FlashSaleItemEntity>, GetCampaignItemsParams> {
  final FlashSaleRepository repository;

  GetCampaignItemsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> call(
      GetCampaignItemsParams params) async {
    return repository.getCampaignItems(params.campaignId);
  }
}

class GetCampaignItemsParams {
  final int campaignId;

  const GetCampaignItemsParams({required this.campaignId});
}
