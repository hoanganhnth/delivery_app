import 'package:delivery_app/features/orders/domain/entities/shipper_location_entity.dart';
import 'package:delivery_app/features/orders/presentation/providers/delivery_tracking/delivery_tracking_notifier.dart';
import 'package:delivery_app/features/orders/presentation/providers/delivery_tracking/delivery_tracking_state.dart';
import 'package:delivery_app/features/orders/presentation/providers/shipper_location/shipper_location_notifier.dart';
import 'package:delivery_app/features/orders/presentation/providers/shipper_location/shipper_location_state.dart';
import 'package:delivery_app/features/orders/presentation/services/i_map_service.dart';
import 'package:delivery_app/features/orders/presentation/services/mapbox_map_service.dart';
import 'package:delivery_app/features/orders/presentation/services/tracking_map_platform.dart';
import 'package:delivery_app/features/orders/presentation/widgets/track_order/optimized_delivery_tracking_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../../support/app_harness.dart';
import '../../../../support/fulfilment_builders.dart';

void main() {
  testWidgets(
    'map actions and service lifecycle run through injected boundaries',
    (tester) async {
      final mapService = _FakeMapService();
      final location = ShipperLocationEntity(
        shipperId: 701,
        latitude: 10.77,
        longitude: 106.70,
        updatedAt: DateTime.utc(2026, 7, 30),
      );
      final route = <List<double>>[
        [106.70, 10.77],
        [106.71, 10.78],
      ];

      await pumpTestApp(
        tester,
        overrides: [
          trackingMapServiceFactoryProvider.overrideWithValue(() => mapService),
          trackingMapPlatformProvider.overrideWithValue(
            const _FakeMapPlatform(),
          ),
          deliveryTrackingProvider.overrideWithValue(
            DeliveryTrackingState(
              currentTracking: buildDeliveryTracking(),
              polylinePoints: route,
            ),
          ),
          shipperLocationProvider.overrideWithValue(
            ShipperLocationState(currentLocation: location),
          ),
        ],
        child: SingleChildScrollView(
          child: OptimizedDeliveryTrackingMapWidget(
            deliveryTracking: buildDeliveryTracking(),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.byKey(const ValueKey('fake_map_canvas')), findsOneWidget);
      expect(mapService.initialCameraCalls, 1);
      expect(mapService.updatedLocations, [location]);
      expect(mapService.cameraMoves, [(10.77, 106.70)]);
      expect(mapService.routes, [route]);
      expect(find.byTooltip('Mở rộng bản đồ'), findsOneWidget);
      expect(find.byTooltip('Dừng theo dõi shipper'), findsOneWidget);

      await tester.tap(find.byTooltip('Mở rộng bản đồ'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Thu nhỏ bản đồ'), findsOneWidget);

      await tester.tap(find.byTooltip('Dừng theo dõi shipper'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Theo dõi shipper'), findsOneWidget);

      await tester.tap(find.byTooltip('Thu nhỏ bản đồ'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Mở rộng bản đồ'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      expect(mapService.disposeCalls, 1);
    },
  );
}

class _FakeMapPlatform implements TrackingMapPlatformPort {
  const _FakeMapPlatform();

  @override
  Widget buildMap({
    required Key key,
    required CameraOptions cameraOptions,
    required ValueChanged<MapboxMap> onMapCreated,
  }) {
    return const ColoredBox(
      key: ValueKey('fake_map_canvas'),
      color: Colors.transparent,
    );
  }
}

class _FakeMapService implements IMapService<MapboxMap, CameraOptions> {
  int initialCameraCalls = 0;
  int disposeCalls = 0;
  final List<ShipperLocationEntity> updatedLocations = [];
  final List<(double, double)> cameraMoves = [];
  final List<List<List<double>>> routes = [];

  @override
  bool get isInitialized => true;

  @override
  Future<void> initializeMap(MapboxMap mapController) async {}

  @override
  Future<void> addDeliveryMarkers({
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
  }) async {}

  @override
  Future<void> updateShipperMarker(ShipperLocationEntity location) async {
    updatedLocations.add(location);
  }

  @override
  Future<void> drawRoute(List<List<double>> points) async {
    routes.add(points);
  }

  @override
  Future<void> moveCamera({
    required double latitude,
    required double longitude,
    double zoom = 14.0,
  }) async {
    cameraMoves.add((latitude, longitude));
  }

  @override
  Future<void> fitBoundsToMarkers({
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
    double? shipperLat,
    double? shipperLng,
  }) async {}

  @override
  CameraOptions getInitialCameraPosition({
    double? pickupLat,
    double? pickupLng,
    double? deliveryLat,
    double? deliveryLng,
  }) {
    initialCameraCalls += 1;
    return CameraOptions(zoom: 12);
  }

  @override
  void dispose() {
    disposeCalls += 1;
  }
}
