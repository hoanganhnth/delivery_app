import 'package:delivery_app/features/flash_sale/data/datasources/flash_sale_remote_data_source.dart';
import 'package:delivery_app/features/flash_sale/data/models/flash_sale_campaign_model.dart';
import 'package:delivery_app/features/flash_sale/data/models/flash_sale_item_model.dart';
import 'package:delivery_app/features/flash_sale/data/repositories/flash_sale_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'keeps the server flash-sale identity for available restaurant items',
    () async {
      final repository = FlashSaleRepositoryImpl(
        remoteDataSource: _FakeFlashSaleRemoteDataSource(
          campaigns: const [
            FlashSaleCampaignModel(
              id: 3,
              name: 'Lunch',
              isRecurring: true,
              startTime: '11:00:00',
              endTime: '14:00:00',
              status: 'ACTIVE',
            ),
          ],
          itemsByCampaign: {
            3: const [
              FlashSaleItemModel(
                id: 88,
                campaignId: 3,
                restaurantId: 7,
                menuItemId: 9,
                originalPrice: 100000,
                flashSalePrice: 60000,
                stockQuantity: 10,
                soldQuantity: 2,
                status: 'APPROVED',
              ),
            ],
          },
        ),
      );

      final result = await repository.getRestaurantItems(7);

      result.match((failure) => fail('expected an item, got $failure'), (
        items,
      ) {
        expect(items.single.id, 88);
        expect(items.single.menuItemId, 9);
        expect(items.single.flashSalePrice, 60000);
      });
    },
  );
}

class _FakeFlashSaleRemoteDataSource implements FlashSaleRemoteDataSource {
  const _FakeFlashSaleRemoteDataSource({
    required this.campaigns,
    required this.itemsByCampaign,
  });

  final List<FlashSaleCampaignModel> campaigns;
  final Map<int, List<FlashSaleItemModel>> itemsByCampaign;

  @override
  Future<List<FlashSaleCampaignModel>> getActiveCampaigns() async => campaigns;

  @override
  Future<List<FlashSaleItemModel>> getCampaignItems(int campaignId) async =>
      itemsByCampaign[campaignId] ?? const [];
}
