import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/usecases/usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/flash_sale_campaign_entity.dart';
import '../entities/flash_sale_item_entity.dart';
import '../repositories/flash_sale_repository.dart';

class GetActiveFlashSaleCampaignsUseCase
    extends
        UseCase<
          List<FlashSaleCampaignEntity>,
          GetActiveFlashSaleCampaignsParams
        > {
  GetActiveFlashSaleCampaignsUseCase(this._repository);

  final FlashSaleRepository _repository;

  @override
  Future<Either<Failure, List<FlashSaleCampaignEntity>>> call(
    GetActiveFlashSaleCampaignsParams params,
  ) => _repository.getActiveCampaigns();
}

class GetActiveFlashSaleCampaignsParams {
  const GetActiveFlashSaleCampaignsParams();
}

class GetFlashSaleCampaignItemsUseCase
    extends
        UseCase<List<FlashSaleItemEntity>, GetFlashSaleCampaignItemsParams> {
  GetFlashSaleCampaignItemsUseCase(this._repository);

  final FlashSaleRepository _repository;

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> call(
    GetFlashSaleCampaignItemsParams params,
  ) {
    if (params.campaignId <= 0) {
      return Future.value(
        left(const ValidationFailure('Invalid flash-sale campaign identity')),
      );
    }
    return _repository.getCampaignItems(params.campaignId);
  }
}

class GetFlashSaleCampaignItemsParams {
  const GetFlashSaleCampaignItemsParams({required this.campaignId});

  final int campaignId;
}
