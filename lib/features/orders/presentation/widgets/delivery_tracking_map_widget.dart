import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/shipper_location_entity.dart';

/// Widget để hiển thị bản đồ theo dõi delivery với MapBox
class DeliveryTrackingMapWidget extends StatefulWidget {
  final DeliveryTrackingEntity? deliveryTracking;
  final ShipperEntity? shipper;
  final ShipperLocationEntity? shipperLocation; // Vị trí real-time của shipper
  final Function(String)? onStatusChanged;

  const DeliveryTrackingMapWidget({
    super.key,
    this.deliveryTracking,
    this.shipper,
    this.shipperLocation,
    this.onStatusChanged,
  });

  @override
  State<DeliveryTrackingMapWidget> createState() =>
      _DeliveryTrackingMapWidgetState();
}

class _DeliveryTrackingMapWidgetState extends State<DeliveryTrackingMapWidget> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;

  // Map markers
  PointAnnotation? _shipperMarker;

  // Map expansion state
  bool _isExpanded = false;

  // Map initialization state
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    // Delay nhỏ để đảm bảo widget được render hoàn toàn trước khi khởi tạo map
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isMapInitialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _buildExpandedMap() : _buildCompactMap();
  }

  Widget _buildCompactMap() {
    return Column(
      children: [
        // Thông tin đơn hàng và shipper ở ngoài map khi compact
        if (widget.deliveryTracking != null || widget.shipper != null)
          _buildExternalInfoCard(),
        const SizedBox(height: 8),

        // Map widget với nút expand - đảm bảo kích thước tối thiểu
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 300,
            minWidth: 200, // Kích thước tối thiểu để tránh lỗi MapBox
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width =
                  (constraints.maxWidth > 200 ? constraints.maxWidth : 200)
                      .toDouble();
              return Container(
                height: 300,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      // Đảm bảo MapWidget có kích thước cụ thể và chỉ render khi ready
                      SizedBox(
                        height: 300,
                        width: width,
                        child: _isMapInitialized
                            ? MapWidget(
                                key: const ValueKey("compactMapWidget"),
                                onMapCreated: _onMapCreated,
                                cameraOptions: _getInitialCameraPosition(),
                                textureView: true,
                                // Enable tương tác với map - gestureRecognizers rỗng cho phép tất cả gesture
                                gestureRecognizers: {
                                  Factory<OneSequenceGestureRecognizer>(
                                    () =>
                                        EagerGestureRecognizer(), // Cho phép map nhận tất cả gesture
                                  ),
                                },
                              )
                            : Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 8),
                                      Text(
                                        'Đang tải bản đồ...',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      if (_isMapInitialized) _buildExpandButton(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedMap() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final mapHeight = (screenHeight * 0.7).clamp(
      300.0,
      double.infinity,
    ); // Tối thiểu 300px

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 300,
        minWidth: 200,
        maxHeight: mapHeight,
        maxWidth: screenWidth,
      ),
      child: Container(
        height: mapHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Đảm bảo MapWidget có kích thước cụ thể cho expanded mode
              SizedBox(
                height: mapHeight,
                width: screenWidth,
                child: _isMapInitialized
                    ? MapWidget(
                        key: const ValueKey("expandedMapWidget"),
                        onMapCreated: _onMapCreated,
                        cameraOptions: _getInitialCameraPosition(),
                        textureView: true,
                        // Enable tương tác với map cho expanded mode
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 8),
                              Text(
                                'Đang tải bản đồ...',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              // Overlay info khi expanded - đè lên map (chỉ hiển thị khi map ready)
              if (_isMapInitialized) ...[
                _buildStatusOverlay(),
                _buildShipperInfoOverlay(),
                _buildCollapseButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandButton() {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              _isExpanded = true;
            });
          },
          icon: const Icon(Icons.fullscreen),
          iconSize: 20,
          color: Colors.grey[700],
          tooltip: 'Mở rộng bản đồ',
        ),
      ),
    );
  }

  Widget _buildCollapseButton() {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              _isExpanded = false;
            });
          },
          icon: const Icon(Icons.fullscreen_exit),
          iconSize: 20,
          color: Colors.grey[700],
          tooltip: 'Thu nhỏ bản đồ',
        ),
      ),
    );
  }

  Widget _buildExternalInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status
            if (widget.deliveryTracking != null) ...[
              Row(
                children: [
                  _getStatusIcon(widget.deliveryTracking!.status),
                  const SizedBox(width: 8),
                  Text(
                    _getStatusTitle(widget.deliveryTracking!.status),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Shipper Info
            if (widget.shipper != null) ...[
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.shipper!.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${widget.shipper!.vehicleType.toUpperCase()} • ${widget.shipper!.vehicleNumber}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _callShipper,
                    icon: const Icon(Icons.phone, size: 16),
                    label: const Text('Gọi', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  CameraOptions _getInitialCameraPosition() {
    if (widget.deliveryTracking != null) {
      // Center giữa pickup và delivery
      final centerLat =
          (widget.deliveryTracking!.pickupLat +
              widget.deliveryTracking!.deliveryLat) /
          2;
      final centerLng =
          (widget.deliveryTracking!.pickupLng +
              widget.deliveryTracking!.deliveryLng) /
          2;

      return CameraOptions(
        center: Point(coordinates: Position(centerLng, centerLat)),
        zoom: 13.0,
      );
    }

    // Default to Ho Chi Minh City
    return CameraOptions(
      center: Point(coordinates: Position(106.660172, 10.762622)),
      zoom: 12.0,
    );
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    if (!mounted) return;

    try {
      _mapboxMap = mapboxMap;
      AppLogger.d('MapBox map created successfully');

      // Create annotation manager
      _pointAnnotationManager = await _mapboxMap!.annotations
          .createPointAnnotationManager();

      // Add markers
      await _addMarkers();

      // Fit bounds to show all markers
      if (widget.deliveryTracking != null) {
        await _fitBoundsToMarkers();
      }

      AppLogger.i('Map initialization completed');
    } catch (e) {
      AppLogger.e('Error initializing map', e);
    }
  }

  Future<void> _addMarkers() async {
    if (_pointAnnotationManager == null || widget.deliveryTracking == null)
      return;

    try {
      // Add pickup marker (restaurant)
      await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              widget.deliveryTracking!.pickupLng,
              widget.deliveryTracking!.pickupLat,
            ),
          ),
          textField: "🏪 Nhà hàng",
          textSize: 12.0,
          textColor: Colors.blue.toARGB32(),
          textHaloColor: Colors.white.toARGB32(),
          textHaloWidth: 2.0,
        ),
      );

      // Add delivery marker (customer)
      await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              widget.deliveryTracking!.deliveryLng,
              widget.deliveryTracking!.deliveryLat,
            ),
          ),
          textField: "🏠 Khách hàng",
          textSize: 12.0,
          textColor: Colors.red.toARGB32(),
          textHaloColor: Colors.white.toARGB32(),
          textHaloWidth: 2.0,
        ),
      );

      // Add shipper marker if available from real-time location
      if (widget.shipperLocation != null) {
        await _updateShipperMarker();
      }
    } catch (e) {
      debugPrint('Error adding markers: $e');
    }
  }

  Future<void> _updateShipperMarker() async {
    if (_pointAnnotationManager == null || widget.shipperLocation == null) {
      return;
    }

    try {
      final newLat = widget.shipperLocation!.latitude;
      final newLng = widget.shipperLocation!.longitude;

      // Remove existing shipper marker
      if (_shipperMarker != null) {
        await _pointAnnotationManager!.delete(_shipperMarker!);
      }

      // Add new shipper marker with updated position
      _shipperMarker = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(newLng, newLat)),
          textField: "🛵 Shipper",
          textSize: 12.0,
          textColor: Colors.orange.toARGB32(),
          textHaloColor: Colors.white.toARGB32(),
          textHaloWidth: 2.0,
        ),
      );

      AppLogger.d('Updated shipper marker to position: ($newLat, $newLng)');
    } catch (e) {
      AppLogger.e('Error updating shipper marker', e);
    }
  }

  Future<void> _fitBoundsToMarkers() async {
    if (_mapboxMap == null || widget.deliveryTracking == null) return;

    try {
      final coordinates = <Position>[];

      // Add pickup and delivery coordinates
      coordinates.add(
        Position(
          widget.deliveryTracking!.pickupLng,
          widget.deliveryTracking!.pickupLat,
        ),
      );
      coordinates.add(
        Position(
          widget.deliveryTracking!.deliveryLng,
          widget.deliveryTracking!.deliveryLat,
        ),
      );

      // Add shipper location if available
      if (widget.shipperLocation != null) {
        coordinates.add(
          Position(
            widget.shipperLocation!.longitude,
            widget.shipperLocation!.latitude,
          ),
        );
      }

      // Calculate bounds
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

      // Add padding
      const padding = 0.002; // Adjust as needed
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
    } catch (e) {
      debugPrint('Error fitting bounds: $e');
    }
  }

  double _calculateZoomLevel(
    double minLat,
    double maxLat,
    double minLng,
    double maxLng,
  ) {
    // Simple zoom calculation based on bounding box
    final latDiff = maxLat - minLat;
    final lngDiff = maxLng - minLng;
    final maxDiff = math.max(latDiff, lngDiff);

    if (maxDiff > 0.1) return 10.0;
    if (maxDiff > 0.05) return 11.0;
    if (maxDiff > 0.01) return 12.0;
    if (maxDiff > 0.005) return 13.0;
    return 14.0;
  }

  Widget _buildStatusOverlay() {
    if (widget.deliveryTracking == null) return const SizedBox.shrink();

    return Positioned(
      top: 60,
      left: 12,
      right: 12,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _getStatusIcon(widget.deliveryTracking!.status),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getStatusTitle(widget.deliveryTracking!.status),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShipperInfoOverlay() {
    if (widget.shipper == null) return const SizedBox.shrink();

    return Positioned(
      bottom: 12,
      left: 12,
      right: 12,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.shipper!.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${widget.shipper!.vehicleType.toUpperCase()} • ${widget.shipper!.vehicleNumber}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 10),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _callShipper,
                icon: const Icon(Icons.phone, size: 20),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Icon _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'ASSIGNED':
        return Icon(Icons.assignment, color: Colors.orange[600], size: 20);
      case 'PICKING_UP':
        return Icon(Icons.restaurant, color: Colors.blue[600], size: 20);
      case 'DELIVERING':
        return Icon(Icons.delivery_dining, color: Colors.green[600], size: 20);
      case 'NEAR_DELIVERY':
        return Icon(Icons.near_me, color: Colors.purple[600], size: 20);
      default:
        return Icon(Icons.local_shipping, color: Colors.grey[600], size: 20);
    }
  }

  String _getStatusTitle(String status) {
    switch (status.toUpperCase()) {
      case 'ASSIGNED':
        return 'Đã nhận đơn';
      case 'PICKING_UP':
        return 'Đang lấy đồ ăn';
      case 'DELIVERING':
        return 'Đang giao hàng';
      case 'NEAR_DELIVERY':
        return 'Sắp đến nơi';
      default:
        return 'Đang cập nhật...';
    }
  }

  void _callShipper() {
    // Implement call functionality
    if (widget.shipper?.phone != null) {
      // You can use url_launcher to make phone calls
      debugPrint('Calling shipper: ${widget.shipper!.phone}');
    }
  }

  @override
  void didUpdateWidget(DeliveryTrackingMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update map when shipper location changes (real-time updates)
    if (widget.shipperLocation != oldWidget.shipperLocation) {
      final oldLat = oldWidget.shipperLocation?.latitude;
      final oldLng = oldWidget.shipperLocation?.longitude;
      final newLat = widget.shipperLocation?.latitude;
      final newLng = widget.shipperLocation?.longitude;

      if (oldLat != newLat || oldLng != newLng) {
        AppLogger.d('Shipper location changed, updating marker');
        _updateShipperMarker();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
