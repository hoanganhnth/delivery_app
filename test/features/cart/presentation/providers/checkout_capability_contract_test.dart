import 'package:delivery_app/features/cart/presentation/providers/checkout_voucher_provider.dart';
import 'package:delivery_app/features/restaurants/presentation/providers/flash_sale_catalog_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
  });

  test('voucher wallet uses the authenticated Gateway contract', () async {
    adapter.onGet(
      '/promotions/my-vouchers',
      (server) => server.reply(200, {
        'status': 1,
        'data': [
          {
            'id': 55,
            'code': 'SAVE20',
            'name': 'Save 20%',
            'creatorType': 'PLATFORM',
            'rewardType': 'PERCENTAGE',
            'discountValue': 20,
            'scopeType': 'SHOP',
            'scopeRefId': 7,
            'minOrderValue': 50000,
          },
        ],
      }),
    );

    final wallet = await CheckoutVoucherClient(dio).getWallet();

    expect(wallet.single.id, 55);
    expect(wallet.single.appliesToRestaurant(7), isTrue);
    expect(wallet.single.appliesToRestaurant(8), isFalse);
  });

  test(
    'flash catalog is the only source of checkout flash-sale identity',
    () async {
      adapter.onGet(
        '/flashsales/public/campaigns',
        (server) => server.reply(200, {
          'status': 1,
          'data': [
            {'id': 3, 'name': 'Lunch'},
          ],
        }),
      );
      adapter.onGet(
        '/flashsales/public/campaigns/3/items',
        (server) => server.reply(200, {
          'status': 1,
          'data': [
            {
              'id': 88,
              'restaurantId': 7,
              'menuItemId': 9,
              'flashSalePrice': 60000,
              'stockQuantity': 10,
              'soldQuantity': 2,
              'status': 'APPROVED',
            },
          ],
        }),
      );

      final items = await FlashSaleCatalogClient(dio).getRestaurantItems(7);

      expect(items[9]?.id, 88);
      expect(items[9]?.flashSalePrice, 60000);
    },
  );

  test('duplicate active flash items for one menu fail closed', () async {
    adapter.onGet(
      '/flashsales/public/campaigns',
      (server) => server.reply(200, {
        'status': 1,
        'data': [
          {'id': 3},
          {'id': 4},
        ],
      }),
    );
    for (final campaignId in [3, 4]) {
      adapter.onGet(
        '/flashsales/public/campaigns/$campaignId/items',
        (server) => server.reply(200, {
          'status': 1,
          'data': [
            {
              'id': 80 + campaignId,
              'restaurantId': 7,
              'menuItemId': 9,
              'flashSalePrice': 60000,
              'stockQuantity': 10,
              'soldQuantity': 2,
              'status': 'APPROVED',
            },
          ],
        }),
      );
    }

    await expectLater(
      FlashSaleCatalogClient(dio).getRestaurantItems(7),
      throwsA(isA<FormatException>()),
    );
  });
}
