import 'package:delivery_app/features/flash_sale/application/flash_sale_state.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_campaign_entity.dart';
import 'package:delivery_app/features/flash_sale/domain/entities/flash_sale_item_entity.dart';
import 'package:delivery_app/features/flash_sale/presentation/views/flash_sale_banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('renders active items and emits the restaurant identity', (
    tester,
  ) async {
    int? selectedRestaurantId;
    await pumpTestApp(
      tester,
      child: FlashSaleBannerView(
        state: FlashSaleViewState(
          campaign: const FlashSaleCampaignEntity(
            id: 11,
            name: 'Bữa trưa siêu sale',
            isRecurring: true,
            startTime: '00:00:00',
            endTime: '23:59:59',
            status: 'ACTIVE',
          ),
          items: const [
            FlashSaleItemEntity(
              id: 71,
              campaignId: 11,
              restaurantId: 201,
              menuItemId: 301,
              originalPrice: 50000,
              flashSalePrice: 30000,
              stockQuantity: 10,
              soldQuantity: 2,
              status: 'APPROVED',
            ),
          ],
        ),
        onRestaurantSelected: (id) => selectedRestaurantId = id,
        onRefreshRequested: () {},
      ),
    );

    expect(find.byKey(const Key('flash_sale_banner')), findsOneWidget);
    expect(find.byKey(const Key('flash_sale_item_71')), findsOneWidget);
    expect(find.text('Món #301'), findsOneWidget);

    await tester.tap(find.byKey(const Key('flash_sale_item_71')));

    expect(selectedRestaurantId, 201);
  });

  testWidgets('hides the banner when there is no active inventory', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      child: const FlashSaleBannerView(
        state: FlashSaleViewState(),
        onRestaurantSelected: _ignoreRestaurant,
        onRefreshRequested: _ignoreRefresh,
      ),
    );

    expect(find.byKey(const Key('flash_sale_banner')), findsNothing);
  });

  testWidgets('shows an empty state for an active campaign with no items', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      child: const FlashSaleBannerView(
        state: FlashSaleViewState(
          campaign: FlashSaleCampaignEntity(
            id: 11,
            name: 'Bữa trưa siêu sale',
            isRecurring: true,
            startTime: '00:00:00',
            endTime: '23:59:59',
            status: 'ACTIVE',
          ),
        ),
        onRestaurantSelected: _ignoreRestaurant,
        onRefreshRequested: _ignoreRefresh,
      ),
    );

    expect(find.byKey(const Key('flash_sale_empty')), findsOneWidget);
  });

  testWidgets('shows a loading state while the catalog is loading', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      child: const FlashSaleBannerView(
        state: FlashSaleViewState(isLoading: true),
        onRestaurantSelected: _ignoreRestaurant,
        onRefreshRequested: _ignoreRefresh,
      ),
    );

    expect(find.byKey(const Key('flash_sale_loading')), findsOneWidget);
  });

  testWidgets('hides failed flash sale without a blank status block', (
    tester,
  ) async {
    var refreshes = 0;
    await pumpTestApp(
      tester,
      child: FlashSaleBannerView(
        state: const FlashSaleViewState(errorMessage: 'Không tải được'),
        onRestaurantSelected: _ignoreRestaurant,
        onRefreshRequested: () => refreshes++,
      ),
    );

    expect(find.byKey(const Key('flash_sale_error')), findsNothing);
    expect(find.byKey(const Key('flash_sale_retry')), findsNothing);
    expect(find.text('Không thể tải Flash Sale'), findsNothing);
    expect(refreshes, 0);
  });
}

void _ignoreRestaurant(int id) {}

void _ignoreRefresh() {}
