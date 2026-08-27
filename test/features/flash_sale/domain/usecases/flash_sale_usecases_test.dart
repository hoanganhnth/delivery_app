import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_campaign_entity.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_item_entity.dart';
import 'package:delivery_app/features/flash_sale/domain/repositories/flash_sale_repository.dart';
import 'package:delivery_app/features/flash_sale/domain/usecases/flash_sale_usecases.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads active campaigns through the repository boundary', () async {
    final repository = _FakeFlashSaleRepository();

    final result = await GetActiveFlashSaleCampaignsUseCase(repository)(
      const GetActiveFlashSaleCampaignsParams(),
    );

    expect(result.isRight(), isTrue);
    expect(repository.getCampaignsCalls, 1);
  });

  test('rejects an invalid campaign ID before requesting items', () async {
    final repository = _FakeFlashSaleRepository();

    final result = await GetFlashSaleCampaignItemsUseCase(repository)(
      const GetFlashSaleCampaignItemsParams(campaignId: 0),
    );

    expect(
      result,
      const Left<Failure, List<FlashSaleItemEntity>>(
        ValidationFailure('Invalid flash-sale campaign identity'),
      ),
    );
    expect(repository.getItemsCalls, 0);
  });
}

class _FakeFlashSaleRepository implements FlashSaleRepository {
  int getCampaignsCalls = 0;
  int getItemsCalls = 0;

  @override
  Future<Either<Failure, List<FlashSaleCampaignEntity>>>
  getActiveCampaigns() async {
    getCampaignsCalls++;
    return right(const []);
  }

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getCampaignItems(
    int campaignId,
  ) async {
    getItemsCalls++;
    return right(const []);
  }

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getRestaurantItems(
    int restaurantId,
  ) => throw UnimplementedError();
}
