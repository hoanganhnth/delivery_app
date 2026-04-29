import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../../domain/entities/shipper_location_entity.dart';
import 'i_map_service.dart';

/// Service để quản lý các thao tác với MapBox
class MapboxMapService implements IMapService<MapboxMap, CameraOptions> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  PolylineAnnotationManager? _polylineAnnotationManager;

  // Markers
  PointAnnotation? _shipperMarker;

  @override
  bool get isInitialized =>
      _mapboxMap != null && _pointAnnotationManager != null;

  /// Khởi tạo map và annotation manager
  @override
  Future<void> initializeMap(MapboxMap mapboxMap) async {
    try {
      _mapboxMap = mapboxMap;
      _pointAnnotationManager = await _mapboxMap!.annotations
          .createPointAnnotationManager();
      _polylineAnnotationManager = await _mapboxMap!.annotations
          .createPolylineAnnotationManager();
      AppLogger.d('MapBox map initialized successfully (Markers & Polylines)');
    } catch (e) {
      AppLogger.e('Error initializing MapBox map', e);
      rethrow;
    }
  }

  /// Helper: Vẽ Text/Emoji thành Ảnh để Mapbox hiển thị không bị lỗi font
  Future<Uint8List> _createMarkerImage(
    String text, {
    double size = 80,
    Color? bgColor,
  }) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Vẽ phông tròn phía sau
    final paint = Paint()
      ..color = bgColor ?? Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final center = Offset(size / 2, size / 2);
    final radius = size / 2;

    // Draw shadow
    canvas.drawCircle(Offset(center.dx, center.dy + 2), radius, shadowPaint);
    // Draw background
    canvas.drawCircle(center, radius, paint);

    // Vẽ viền (border)
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(center, radius, borderPaint);

    // Vẽ Emoji / chữ
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: size * 0.55),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
    );

    final p = pictureRecorder.endRecording();
    final image = await p.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  /// Thêm pickup và delivery markers
  @override
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
      final pickupBytes = await _createMarkerImage('🏪', bgColor: Colors.green);
      final deliveryBytes = await _createMarkerImage(
        '🏠',
        bgColor: Colors.blue,
      );

      // Thêm pickup marker (nhà hàng)
      await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(pickupLng, pickupLat)),
          image: pickupBytes,
          iconSize: 1.0,
        ),
      );

      // Thêm delivery marker (khách hàng)
      await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(deliveryLng, deliveryLat)),
          image: deliveryBytes,
          iconSize: 1.0,
        ),
      );

      AppLogger.d('Added pickup and delivery markers');
    } catch (e) {
      AppLogger.e('Error adding delivery markers', e);
    }
  }

  /// Cập nhật vị trí shipper marker
  @override
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
      // final ByteData bytes = await rootBundle.load(AppAssets.icShipperMap,);
      // final Uint8List list = bytes.buffer.asUint8List();
      // Tạo shipper marker mới
      final shipperBytes = await _createMarkerImage(
        '🛵',
        bgColor: Colors.red,
        size: 90,
      );

      _shipperMarker = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(location.longitude, location.latitude),
          ),
          image: shipperBytes,
          iconSize: 1.0,
        ),
      );
    } catch (e) {
      AppLogger.e('Error updating shipper marker', e);
    }
  }

  /// Vẽ đường đi (Route) từ danh sách toạ độ
  @override
  Future<void> drawRoute(List<List<double>> points) async {
    if (!isInitialized || _polylineAnnotationManager == null) {
      AppLogger.w('Map not initialized, cannot draw route');
      return;
    }

    try {
      // Xóa tất cả polyline cũ
      await _polylineAnnotationManager!.deleteAll();

      if (points.isEmpty) return;

      // Tạo polyline mới
      await _polylineAnnotationManager!.create(
        PolylineAnnotationOptions(
          geometry: LineString(
            coordinates: points.map((p) => Position(p[0], p[1])).toList(),
          ),
          lineColor: Colors.blue.withValues(alpha: 0.8).value,
          lineWidth: 5.0,
          lineJoin: LineJoin.ROUND,
        ),
      );

      AppLogger.d('Route polyline drawn: ${points.length} points');
    } catch (e) {
      AppLogger.e('Error drawing route polyline', e);
    }
  }

  /// Di chuyển camera đến vị trí cụ thể
  @override
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
  @override
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
  /// Kiểm tra tọa độ có hợp lệ hay không (không phải 0.0 default)
  bool _isValidCoordinate(double? lat, double? lng) {
    if (lat == null || lng == null) return false;
    if (lat == 0.0 && lng == 0.0) return false;
    if (lat.abs() > 90 || lng.abs() > 180) return false;
    return true;
  }

  @override
  CameraOptions getInitialCameraPosition({
    double? pickupLat,
    double? pickupLng,
    double? deliveryLat,
    double? deliveryLng,
  }) {
    final hasValidPickup = _isValidCoordinate(pickupLat, pickupLng);
    final hasValidDelivery = _isValidCoordinate(deliveryLat, deliveryLng);

    if (hasValidPickup && hasValidDelivery) {
      // Center giữa pickup và delivery
      final centerLat = (pickupLat! + deliveryLat!) / 2;
      final centerLng = (pickupLng! + deliveryLng!) / 2;
      return CameraOptions(
        center: Point(coordinates: Position(centerLng, centerLat)),
        zoom: 14.0,
      );
    } else if (hasValidDelivery) {
      return CameraOptions(
        center: Point(coordinates: Position(deliveryLng!, deliveryLat!)),
        zoom: 14.0,
      );
    } else if (hasValidPickup) {
      return CameraOptions(
        center: Point(coordinates: Position(pickupLng!, pickupLat!)),
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
  @override
  void dispose() {
    _mapboxMap = null;
    _pointAnnotationManager = null;
    _polylineAnnotationManager = null;
    _shipperMarker = null;
    AppLogger.d('MapboxMapService disposed');
  }
}
