import 'package:fpdart/fpdart.dart';
import '../../../../core/error/error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/resources/base_response_dto.dart';
import '../../domain/entities/flash_sale_campaign_entity.dart';
import '../../domain/entities/flash_sale_item_entity.dart';
import '../../domain/repositories/flash_sale_repository.dart';
import '../datasources/flash_sale_api_service.dart';
import '../models/flash_sale_model.dart';

/// Repository implementation — chuyển đổi Model → Entity
class FlashSaleRepositoryImpl implements FlashSaleRepository {
  final FlashSaleApiService _apiService;

  FlashSaleRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, List<FlashSaleCampaignEntity>>>
      getActiveCampaigns() async {
    try {
      final response = await _apiService.getActiveCampaigns();

      if (response.isSuccess && response.data != null) {
        final entities =
            response.data!.map((model) => model.toEntity()).toList();
        return right(entities);
      } else {
        return left(ServerFailure(response.message));
      }
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getCampaignItems(
      int campaignId) async {
    try {
      final response = await _apiService.getCampaignItems(campaignId);

      if (response.isSuccess && response.data != null) {
        final entities =
            response.data!.map((model) => model.toEntity()).toList();
        return right(entities);
      } else {
        return left(ServerFailure(response.message));
      }
    } catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}

// ================================
// Model → Entity Mapping Extensions
// ================================

extension FlashSaleCampaignX on FlashSaleCampaign {
  FlashSaleCampaignEntity toEntity() {
    return FlashSaleCampaignEntity(
      id: id,
      name: name,
      isRecurring: isRecurring,
      startTime: startTime,
      endTime: endTime,
    );
  }
}

extension FlashSaleItemX on FlashSaleItem {
  FlashSaleItemEntity toEntity() {
    return FlashSaleItemEntity(
      id: id,
      campaignId: campaign.id,
      campaignName: campaign.name,
      restaurantId: restaurantId,
      menuItemId: menuItemId,
      menuItemName: menuItemName,
      originalPrice: originalPrice,
      flashSalePrice: flashSalePrice,
      stockQuantity: stockQuantity,
      soldQuantity: soldQuantity,
      status: status,
    );
  }
}
