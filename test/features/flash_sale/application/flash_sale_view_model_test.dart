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

  test('loads and keeps available items from every active campaign', () async {
    final repository = _MultipleCampaignsRepository();
    final container = ProviderContainer(
      overrides: [
        flashSaleCheckoutEnabledProvider.overrideWithValue(true),
        flashSaleRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await container.read(flashSaleViewModelProvider.notifier).load();

    final state = container.read(flashSaleViewModelProvider);
    expect(repository.requestedCampaignIds, [11, 12]);
    expect(state.campaign?.id, 11);
    expect(state.items.map((item) => item.id), [71, 72]);
  });
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

class _MultipleCampaignsRepository implements FlashSaleRepository {
  final List<int> requestedCampaignIds = [];

  @override
  Future<Either<Failure, List<FlashSaleCampaignEntity>>>
  getActiveCampaigns() async => right(const [
    FlashSaleCampaignEntity(
      id: 11,
      name: 'Lunch',
      isRecurring: true,
      startTime: '11:00:00',
      endTime: '14:00:00',
      status: 'ACTIVE',
    ),
    FlashSaleCampaignEntity(
      id: 12,
      name: 'Dinner',
      isRecurring: true,
      startTime: '17:00:00',
      endTime: '20:00:00',
      status: 'ACTIVE',
    ),
  ]);

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getCampaignItems(
    int campaignId,
  ) async {
    requestedCampaignIds.add(campaignId);
    return right([
      FlashSaleItemEntity(
        id: campaignId == 11 ? 71 : 72,
        campaignId: campaignId,
        restaurantId: 201,
        menuItemId: campaignId == 11 ? 301 : 302,
        originalPrice: 50000,
        flashSalePrice: 30000,
        stockQuantity: 10,
        soldQuantity: 2,
        status: 'APPROVED',
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getRestaurantItems(
    int restaurantId,
  ) => throw UnimplementedError();
}
