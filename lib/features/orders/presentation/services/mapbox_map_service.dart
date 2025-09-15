import 'dart:math' as math;
import 'dart:typed_data';
import 'package:delivery_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/shipper_location_entity.dart';

/// Service để quản lý các thao tác với MapBox
class MapboxMapService {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;

  // Markers
  PointAnnotation? _shipperMarker;

  bool get isInitialized =>
      _mapboxMap != null && _pointAnnotationManager != null;

  /// Khởi tạo map và annotation manager
  Future<void> initializeMap(MapboxMap mapboxMap) async {
    try {
      _mapboxMap = mapboxMap;
      _pointAnnotationManager = await _mapboxMap!.annotations
          .createPointAnnotationManager();
      AppLogger.d('MapBox map initialized successfully');
    } catch (e) {
      AppLogger.e('Error initializing MapBox map', e);
      rethrow;
    }
  }

  /// Thêm pickup và delivery markers
  Future<void> addDeliveryMarkers({
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
  }) async {
    if (!isInitialized) {
      AppLogger.w('Map not initialized, cannot add markers');
      return;
    }

    try {
      // Thêm pickup marker (nhà hàng)
      await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(pickupLng, pickupLat)),
          textField: "🏪 Nhà hàng",
          textSize: 12.0,
          textColor: Colors.blue.toARGB32(),
          textHaloColor: Colors.white.toARGB32(),
          textHaloWidth: 2.0,
        ),
      );

      // Thêm delivery marker (khách hàng)
      await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(deliveryLng, deliveryLat)),
          textField: "🏠 Khách hàng",
          textSize: 12.0,
          textColor: Colors.red.toARGB32(),
          textHaloColor: Colors.white.toARGB32(),
          textHaloWidth: 2.0,
        ),
      );

      AppLogger.d('Added pickup and delivery markers');
    } catch (e) {
      AppLogger.e('Error adding delivery markers', e);
    }
  }

  /// Cập nhật vị trí shipper marker
  Future<void> updateShipperMarker(ShipperLocationEntity location) async {
    if (!isInitialized) {
      AppLogger.w('Map not initialized, cannot update shipper marker');
      return;
    }

    try {
      // Xóa shipper marker cũ nếu có
      if (_shipperMarker != null) {
        await _pointAnnotationManager!.delete(_shipperMarker!);
        _shipperMarker = null;
      }
      final ByteData bytes = await rootBundle.load(AppAssets.icShipperMap);
      final Uint8List list = bytes.buffer.asUint8List();
      // Tạo shipper marker mới với container đỏ to hơn
      _shipperMarker = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          image: list,
          geometry: Point(
            coordinates: Position(location.longitude, location.latitude),
          ),
          // textField: "�", // Container đỏ lớn
          // textSize: 24.0, // Tăng kích thước gấp đôi
          // textColor: Colors.red.toARGB32(), // Màu đỏ
          // textHaloColor: Colors.white.toARGB32(),
          // textHaloWidth: 3.0, // Tăng viền để nổi bật hơn
        ),
      );
    } catch (e) {
      AppLogger.e('Error updating shipper marker', e);
    }
  }

  /// Di chuyển camera đến vị trí cụ thể
  Future<void> moveCamera({
    required double latitude,
    required double longitude,
    double zoom = 14.0,
  }) async {
    if (_mapboxMap == null) {
      AppLogger.w('Map not initialized, cannot move camera');
      return;
    }

    try {
      await _mapboxMap!.setCamera(
        CameraOptions(
          center: Point(coordinates: Position(longitude, latitude)),
          zoom: zoom,
        ),
      );
    } catch (e) {
      AppLogger.e('Error moving camera', e);
    }
  }

  /// Fit camera để hiển thị tất cả markers
  Future<void> fitBoundsToMarkers({
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
    double? shipperLat,
    double? shipperLng,
  }) async {
    if (_mapboxMap == null) {
      AppLogger.w('Map not initialized, cannot fit bounds');
      return;
    }

    try {
      final coordinates = <Position>[];

      // Thêm pickup và delivery coordinates
      coordinates.add(Position(pickupLng, pickupLat));
      coordinates.add(Position(deliveryLng, deliveryLat));

      // Thêm shipper location nếu có
      if (shipperLat != null && shipperLng != null) {
        coordinates.add(Position(shipperLng, shipperLat));
      }

      // Tính toán bounds
      double minLat = coordinates.first.lat.toDouble();
      double maxLat = coordinates.first.lat.toDouble();
      double minLng = coordinates.first.lng.toDouble();
      double maxLng = coordinates.first.lng.toDouble();

      for (final pos in coordinates) {
        minLat = math.min(minLat, pos.lat.toDouble());
        maxLat = math.max(maxLat, pos.lat.toDouble());
        minLng = math.min(minLng, pos.lng.toDouble());
        maxLng = math.max(maxLng, pos.lng.toDouble());
      }

      // Thêm padding
      const padding = 0.002;
      minLat -= padding;
      maxLat += padding;
      minLng -= padding;
      maxLng += padding;

      // Fit camera to bounds
      await _mapboxMap!.setCamera(
        CameraOptions(
          center: Point(
            coordinates: Position((minLng + maxLng) / 2, (minLat + maxLat) / 2),
          ),
          zoom: _calculateZoomLevel(minLat, maxLat, minLng, maxLng),
        ),
      );

      AppLogger.d('Camera fitted to markers bounds');
    } catch (e) {
      AppLogger.e('Error fitting bounds', e);
    }
  }

  /// Tính toán zoom level phù hợp dựa trên bounds
  double _calculateZoomLevel(
    double minLat,
    double maxLat,
    double minLng,
    double maxLng,
  ) {
    const double zoomLevelMax = 18.0;
    const double zoomLevelMin = 1.0;

    final latDiff = maxLat - minLat;
    final lngDiff = maxLng - minLng;
    final maxDiff = math.max(latDiff, lngDiff);

    // Convert difference to zoom level (công thức thực nghiệm)
    double zoomLevel = 14.0; // Mặc định

    if (maxDiff > 0) {
      zoomLevel = 15.0 - (maxDiff * 100);
      zoomLevel = zoomLevel.clamp(zoomLevelMin, zoomLevelMax);
    }

    return zoomLevel;
  }

  /// Lấy camera position ban đầu
  CameraOptions getInitialCameraPosition({
    double? pickupLat,
    double? pickupLng,
    double? deliveryLat,
    double? deliveryLng,
  }) {
    if (pickupLat != null &&
        pickupLng != null &&
        deliveryLat != null &&
        deliveryLng != null) {
      // Center giữa pickup và delivery
      final centerLat = (pickupLat + deliveryLat) / 2;
      final centerLng = (pickupLng + deliveryLng) / 2;

      return CameraOptions(
        center: Point(coordinates: Position(centerLng, centerLat)),
        zoom: 14.0,
      );
    }

    // Default to Ho Chi Minh City
    return CameraOptions(
      center: Point(coordinates: Position(106.660172, 10.762622)),
      zoom: 14.0,
    );
  }

  /// Cleanup khi không cần dùng nữa
  void dispose() {
    _mapboxMap = null;
    _pointAnnotationManager = null;
    _shipperMarker = null;
    AppLogger.d('MapboxMapService disposed');
  }
}
