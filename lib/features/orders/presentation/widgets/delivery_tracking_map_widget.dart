import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../domain/entities/delivery_tracking_entity.dart';

/// Widget để hiển thị bản đồ theo dõi delivery với MapBox
class DeliveryTrackingMapWidget extends StatefulWidget {
  final DeliveryTrackingEntity? deliveryTracking;
  final ShipperEntity? shipper;
  final Function(String)? onStatusChanged;
  
  const DeliveryTrackingMapWidget({
    super.key,
    this.deliveryTracking,
    this.shipper,
    this.onStatusChanged,
  });

  @override
  State<DeliveryTrackingMapWidget> createState() => _DeliveryTrackingMapWidgetState();
}

class _DeliveryTrackingMapWidgetState extends State<DeliveryTrackingMapWidget> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  
  // Map markers
  PointAnnotation? _shipperMarker;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            MapWidget(
              key: const ValueKey("mapWidget"),
              onMapCreated: _onMapCreated,
              cameraOptions: _getInitialCameraPosition(),
              textureView: true,
            ),
            _buildStatusOverlay(),
            _buildShipperInfoOverlay(),
          ],
        ),
      ),
    );
  }

  CameraOptions _getInitialCameraPosition() {
    if (widget.deliveryTracking != null) {
      // Center giữa pickup và delivery
      final centerLat = (widget.deliveryTracking!.pickupLat + widget.deliveryTracking!.deliveryLat) / 2;
      final centerLng = (widget.deliveryTracking!.pickupLng + widget.deliveryTracking!.deliveryLng) / 2;
      
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
    _mapboxMap = mapboxMap;
    
    // Create annotation manager
    _pointAnnotationManager = await _mapboxMap!.annotations.createPointAnnotationManager();
    
    // Add markers
    await _addMarkers();
    
    // Fit bounds to show all markers
    if (widget.deliveryTracking != null) {
      await _fitBoundsToMarkers();
    }
  }

  Future<void> _addMarkers() async {
    if (_pointAnnotationManager == null || widget.deliveryTracking == null) return;
    
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

      // Add shipper marker if available
      if (widget.deliveryTracking!.shipperCurrentLat != null && 
          widget.deliveryTracking!.shipperCurrentLng != null) {
        await _updateShipperMarker();
      }
      
    } catch (e) {
      debugPrint('Error adding markers: $e');
    }
  }

  Future<void> _updateShipperMarker() async {
    if (_pointAnnotationManager == null || 
        widget.deliveryTracking?.shipperCurrentLat == null ||
        widget.deliveryTracking?.shipperCurrentLng == null) {
      return;
    }

    try {
      // Remove existing shipper marker
      if (_shipperMarker != null) {
        await _pointAnnotationManager!.delete(_shipperMarker!);
      }

      // Add new shipper marker
      _shipperMarker = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              widget.deliveryTracking!.shipperCurrentLng!,
              widget.deliveryTracking!.shipperCurrentLat!,
            ),
          ),
          textField: "🛵 Shipper",
          textSize: 12.0,
          textColor: Colors.green.toARGB32(),
          textHaloColor: Colors.white.toARGB32(),
          textHaloWidth: 2.0,
        ),
      );
    } catch (e) {
      debugPrint('Error updating shipper marker: $e');
    }
  }

  Future<void> _fitBoundsToMarkers() async {
    if (_mapboxMap == null || widget.deliveryTracking == null) return;
    
    try {
      List<Position> positions = [
        Position(widget.deliveryTracking!.pickupLng, widget.deliveryTracking!.pickupLat),
        Position(widget.deliveryTracking!.deliveryLng, widget.deliveryTracking!.deliveryLat),
      ];

      if (widget.deliveryTracking!.shipperCurrentLat != null && 
          widget.deliveryTracking!.shipperCurrentLng != null) {
        positions.add(Position(
          widget.deliveryTracking!.shipperCurrentLng!,
          widget.deliveryTracking!.shipperCurrentLat!,
        ));
      }

      // Calculate bounds
      double minLat = positions.map((p) => p.lat.toDouble()).reduce((a, b) => a < b ? a : b);
      double maxLat = positions.map((p) => p.lat.toDouble()).reduce((a, b) => a > b ? a : b);
      double minLng = positions.map((p) => p.lng.toDouble()).reduce((a, b) => a < b ? a : b);
      double maxLng = positions.map((p) => p.lng.toDouble()).reduce((a, b) => a > b ? a : b);

      await _mapboxMap!.easeTo(
        CameraOptions(
          center: Point(coordinates: Position(
            (minLng + maxLng) / 2,
            (minLat + maxLat) / 2,
          )),
          zoom: 13.0,
        ),
        MapAnimationOptions(duration: 1000),
      );
      
    } catch (e) {
      debugPrint('Error fitting bounds: $e');
    }
  }

  Widget _buildStatusOverlay() {
    if (widget.deliveryTracking == null) return const SizedBox.shrink();
    
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _getStatusIcon(widget.deliveryTracking!.status),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getStatusTitle(widget.deliveryTracking!.status),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (widget.deliveryTracking!.notes?.isNotEmpty == true)
                    Text(
                      widget.deliveryTracking!.notes!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShipperInfoOverlay() {
    if (widget.shipper == null) return const SizedBox.shrink();
    
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: widget.shipper!.avatar != null
                  ? NetworkImage(widget.shipper!.avatar!)
                  : null,
              child: widget.shipper!.avatar == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.shipper!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${widget.shipper!.vehicleType.toUpperCase()} • ${widget.shipper!.vehicleNumber}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.amber[700], size: 16),
                const SizedBox(width: 4),
                Text(
                  widget.shipper!.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _callShipper(),
              icon: const Icon(Icons.phone),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'going_to_pickup':
        return Icon(Icons.directions_run, color: Colors.blue[600], size: 20);
      case 'at_pickup':
        return Icon(Icons.store, color: Colors.orange[600], size: 20);
      case 'delivering':
        return Icon(Icons.delivery_dining, color: Colors.green[600], size: 20);
      case 'near_delivery':
        return Icon(Icons.near_me, color: Colors.red[600], size: 20);
      default:
        return Icon(Icons.local_shipping, color: Colors.grey[600], size: 20);
    }
  }

  String _getStatusTitle(String status) {
    switch (status.toLowerCase()) {
      case 'going_to_pickup':
        return 'Đang đến nhà hàng';
      case 'at_pickup':
        return 'Đang lấy đồ ăn';
      case 'delivering':
        return 'Đang giao hàng';
      case 'near_delivery':
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
    
    // Update map when delivery tracking data changes
    if (widget.deliveryTracking != oldWidget.deliveryTracking) {
      _updateShipperMarker();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
