import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/shipper_entity.dart';
import '../../domain/entities/shipper_location_entity.dart';
import '../services/fake_shipper_movement_service.dart';
import '../services/mapbox_map_service.dart';
import '../providers/shipper_location_providers.dart';

/// Widget tối ưu để hiển thị bản đồ theo dõi delivery với MapBox
/// Sử dụng shipperLocationProvider thay vì fake movement
class OptimizedDeliveryTrackingMapWidget extends ConsumerStatefulWidget {
  final DeliveryTrackingEntity? deliveryTracking;
  final ShipperEntity? shipper;
  final Function(String)? onStatusChanged;
  final bool useFakeMovement; // Flag để quyết định có dùng fake movement không

  const OptimizedDeliveryTrackingMapWidget({
    super.key,
    this.deliveryTracking,
    this.shipper,
    this.onStatusChanged,
    this.useFakeMovement = false, // Mặc định không dùng fake
  });

  @override
  ConsumerState<OptimizedDeliveryTrackingMapWidget> createState() =>
      _OptimizedDeliveryTrackingMapWidgetState();
}

class _OptimizedDeliveryTrackingMapWidgetState extends ConsumerState<OptimizedDeliveryTrackingMapWidget> {
  // Services để tách logic riêng biệt
  late MapboxMapService _mapService;
  FakeShipperMovementService? _movementService;

  // Map states
  bool _isExpanded = false;
  bool _followShipper = true;
  bool _isMapInitialized = false;
  ShipperLocationEntity? _previousShipperLocation;

  @override
  void initState() {
    super.initState();
    
    // Khởi tạo services
    _mapService = MapboxMapService();
    
    // Chỉ khởi tạo fake movement service nếu cần
    if (widget.useFakeMovement) {
      _movementService = FakeShipperMovementService(
        onPositionUpdated: _onShipperPositionUpdated,
      );
    }
    
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
  void dispose() {
    _movementService?.dispose();
    _mapService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch shipper location từ provider nếu không dùng fake movement
    ShipperLocationEntity? currentShipperLocation;
    
    if (!widget.useFakeMovement) {
      final shipperLocationState = ref.watch(shipperLocationNotifierProvider);
      if (shipperLocationState.currentLocation != null) {
        currentShipperLocation = shipperLocationState.currentLocation;
        
        // Cập nhật shipper marker khi có vị trí mới
        if (_previousShipperLocation != currentShipperLocation) {
          _previousShipperLocation = currentShipperLocation;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && currentShipperLocation != null) {
              _onShipperPositionUpdated(currentShipperLocation);
            }
          });
        }
      }
    }
    
    return _isExpanded ? _buildExpandedMap() : _buildCompactMap();
  }

  // ==================== UI BUILDING METHODS ====================

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
                      // MapWidget với kích thước cụ thể
                      SizedBox(
                        height: 300,
                        width: width,
                        child: _isMapInitialized
                            ? MapWidget(
                                key: const ValueKey("compactMapWidget"),
                                onMapCreated: _onMapCreated,
                                cameraOptions: _mapService.getInitialCameraPosition(
                                  pickupLat: widget.deliveryTracking?.pickupLat,
                                  pickupLng: widget.deliveryTracking?.pickupLng,
                                  deliveryLat: widget.deliveryTracking?.deliveryLat,
                                  deliveryLng: widget.deliveryTracking?.deliveryLng,
                                ),
                                textureView: true,
                                gestureRecognizers: {
                                  Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer(),
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
                      if (_isMapInitialized) _buildMapButtons(),
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
    final mapHeight = (screenHeight * 0.7).clamp(300.0, double.infinity);

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
              // MapWidget cho expanded mode
              SizedBox(
                height: mapHeight,
                width: screenWidth,
                child: _isMapInitialized
                    ? MapWidget(
                        key: const ValueKey("expandedMapWidget"),
                        onMapCreated: _onMapCreated,
                        cameraOptions: _mapService.getInitialCameraPosition(
                          pickupLat: widget.deliveryTracking?.pickupLat,
                          pickupLng: widget.deliveryTracking?.pickupLng,
                          deliveryLat: widget.deliveryTracking?.deliveryLat,
                          deliveryLng: widget.deliveryTracking?.deliveryLng,
                        ),
                        textureView: true,
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
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
              // Overlay info khi expanded
              if (_isMapInitialized) ...[
                _buildStatusOverlay(),
                _buildShipperInfoOverlay(),
                _buildCollapseButton(),
                _buildFollowShipperButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ==================== MAP EVENT HANDLERS ====================
  
  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    if (!mounted) return;

    try {
      // Khởi tạo map service
      await _mapService.initializeMap(mapboxMap);

      // Thêm markers nếu có delivery tracking
      if (widget.deliveryTracking != null) {
        await _mapService.addDeliveryMarkers(
          pickupLat: widget.deliveryTracking!.pickupLat,
          pickupLng: widget.deliveryTracking!.pickupLng,
          deliveryLat: widget.deliveryTracking!.deliveryLat,
          deliveryLng: widget.deliveryTracking!.deliveryLng,
        );
        
        // Fit camera để hiển thị tất cả markers
        await _mapService.fitBoundsToMarkers(
          pickupLat: widget.deliveryTracking!.pickupLat,
          pickupLng: widget.deliveryTracking!.pickupLng,
          deliveryLat: widget.deliveryTracking!.deliveryLat,
          deliveryLng: widget.deliveryTracking!.deliveryLng,
        );
        
        // Bắt đầu fake shipper movement
        _startFakeShipperMovement();
      }

      AppLogger.i('Map initialization completed');
    } catch (e) {
      AppLogger.e('Error initializing map', e);
    }
  }
  
  // Callback từ FakeShipperMovementService
  void _onShipperPositionUpdated(ShipperLocationEntity location) {
    if (!mounted) return;

    setState(() {
      // Cập nhật shipper marker thông qua service
      _mapService.updateShipperMarker(location);
      
      // Di chuyển camera theo shipper nếu được bật
      if (_followShipper || _isExpanded) {
        _mapService.moveCamera(
          latitude: location.latitude,
          longitude: location.longitude,
          zoom: 14.0, // Zoom level cố định theo yêu cầu
        );
      }
    });
  }

  // Bắt đầu fake shipper movement (chỉ khi useFakeMovement = true)
  void _startFakeShipperMovement() {
    if (widget.deliveryTracking == null || !_isMapInitialized || !widget.useFakeMovement) return;

    _movementService?.startFakeShipperMovement(
      pickupLat: widget.deliveryTracking!.pickupLat,
      pickupLng: widget.deliveryTracking!.pickupLng,
      deliveryLat: widget.deliveryTracking!.deliveryLat,
      deliveryLng: widget.deliveryTracking!.deliveryLng,
      shipperId: widget.shipper?.id ?? 456,
    );
  }

  // ==================== UI COMPONENTS ====================

  Widget _buildMapButtons() {
    return Positioned(
      top: 12,
      right: 12,
      child: Column(
        children: [
          // Fullscreen button
          _buildMapButton(
            icon: Icons.fullscreen,
            onPressed: () {
              setState(() {
                _isExpanded = true;
              });
            },
            tooltip: 'Mở rộng bản đồ',
          ),
          const SizedBox(height: 8),
          // Follow shipper toggle button
          _buildMapButton(
            icon: _followShipper ? Icons.gps_fixed : Icons.gps_not_fixed,
            onPressed: () {
              setState(() {
                _followShipper = !_followShipper;
              });
            },
            tooltip: _followShipper ? 'Dừng theo dõi shipper' : 'Theo dõi shipper',
            isActive: _followShipper,
          ),
        ],
      ),
    );
  }

  Widget _buildMapButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
    bool isActive = false,
  }) {
    return Container(
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
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: 20,
        color: isActive ? Colors.blue : Colors.grey[700],
        tooltip: tooltip,
      ),
    );
  }

  Widget _buildCollapseButton() {
    return Positioned(
      top: 12,
      right: 12,
      child: _buildMapButton(
        icon: Icons.fullscreen_exit,
        onPressed: () {
          setState(() {
            _isExpanded = false;
          });
        },
        tooltip: 'Thu nhỏ bản đồ',
      ),
    );
  }
  
  Widget _buildFollowShipperButton() {
    return Positioned(
      top: 12,
      right: 60,
      child: _buildMapButton(
        icon: _followShipper ? Icons.gps_fixed : Icons.gps_not_fixed,
        onPressed: () {
          setState(() {
            _followShipper = !_followShipper;
          });
        },
        tooltip: _followShipper ? 'Dừng theo dõi shipper' : 'Theo dõi shipper',
        isActive: _followShipper,
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
  
  Widget _buildStatusOverlay() {
    if (widget.deliveryTracking == null) return const SizedBox.shrink();
    
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
        child: Row(
          children: [
            _getStatusIcon(widget.deliveryTracking!.status),
            const SizedBox(width: 8),
            Text(
              _getStatusTitle(widget.deliveryTracking!.status),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
      bottom: 12,
      left: 12,
      right: 12,
      child: Container(
        padding: const EdgeInsets.all(12),
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
        child: Row(
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
      ),
    );
  }

  // ==================== HELPER METHODS ====================

  Icon _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'picked_up':
        return const Icon(Icons.directions_bike, color: Colors.blue);
      case 'on_the_way':
        return const Icon(Icons.local_shipping, color: Colors.orange);
      case 'delivered':
        return const Icon(Icons.done_all, color: Colors.green);
      default:
        return const Icon(Icons.access_time, color: Colors.grey);
    }
  }

  String _getStatusTitle(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'Đơn hàng đã xác nhận';
      case 'picked_up':
        return 'Đã lấy hàng';
      case 'on_the_way':
        return 'Đang giao hàng';
      case 'delivered':
        return 'Đã giao hàng';
      default:
        return 'Đang xử lý';
    }
  }

  void _callShipper() {
    if (widget.shipper != null) {
      AppLogger.i('Gọi cho shipper: ${widget.shipper!.name}');
      // Implement actual call functionality here
    }
  }
}
