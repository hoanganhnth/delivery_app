import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/flash_sale/application/flash_sale_view_model.dart';
import 'package:delivery_app/features/flash_sale/di/flash_sale_providers.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_campaign_entity.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_item_entity.dart';
import 'package:delivery_app/features/flash_sale/domain/repositories/flash_sale_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'exposes a campaign request failure for the retryable banner state',
    () async {
      final container = ProviderContainer(
        overrides: [
          flashSaleCheckoutEnabledProvider.overrideWithValue(true),
          flashSaleRepositoryProvider.overrideWithValue(
            const _FailingFlashSaleRepository(),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(flashSaleViewModelProvider.notifier).load();

      expect(
        container.read(flashSaleViewModelProvider).errorMessage,
        'Catalog unavailable',
      );
    },
  );
}

class _FailingFlashSaleRepository implements FlashSaleRepository {
  const _FailingFlashSaleRepository();

  @override
  Future<Either<Failure, List<FlashSaleCampaignEntity>>>
  getActiveCampaigns() async =>
      left(const ServerFailure('Catalog unavailable'));

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getCampaignItems(
    int campaignId,
  ) => throw UnimplementedError();

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getRestaurantItems(
    int restaurantId,
  ) => throw UnimplementedError();
}
