import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/delivery_status.dart';
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
  final bool useFakeMovement; // Flag để quyết định có dùng fake movement không

  const OptimizedDeliveryTrackingMapWidget({
    super.key,
    this.deliveryTracking,
    this.shipper,
    this.useFakeMovement = false, // Mặc định không dùng fake
  });

  @override
  ConsumerState<OptimizedDeliveryTrackingMapWidget> createState() =>
      _OptimizedDeliveryTrackingMapWidgetState();
}

class _OptimizedDeliveryTrackingMapWidgetState
    extends ConsumerState<OptimizedDeliveryTrackingMapWidget> {
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
    final shipperLocationState = ref.watch(shipperLocationNotifierProvider);
    if (!widget.useFakeMovement) {
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

    return _buildAnimatedMapWidget();
  }

  Widget _buildAnimatedMapWidget() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Tính toán kích thước dựa trên trạng thái expanded - đảm bảo tối thiểu 64px cho MapBox
    final mapHeight = _isExpanded
        ? (screenHeight * 0.7).clamp(300.0, double.infinity)
        : 300.0.clamp(64.0, double.infinity);

    final mapWidth = screenWidth.clamp(64.0, double.infinity);

    return Column(
      children: [
        // Thông tin bên ngoài khi compact mode (ẩn khi expanded)
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
              !_isExpanded &&
                  (widget.deliveryTracking != null || widget.shipper != null)
              ? Column(
                  key: const ValueKey('external_info'),
                  children: [
                    _buildExternalInfoCard(),
                    SizedBox(height: 8.w),
                  ],
                )
              : const SizedBox.shrink(key: ValueKey('no_external_info')),
        ),

        // Map widget với animation kích thước
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          height: mapHeight,
          width: mapWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: _isExpanded
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Đảm bảo MapWidget có size hợp lệ, tối thiểu 64x64
                final validWidth = constraints.maxWidth.clamp(
                  64.0,
                  double.infinity,
                );
                final validHeight = constraints.maxHeight.clamp(
                  64.0,
                  double.infinity,
                );

                return Stack(
                  children: [
                    // Single MapWidget instance với constraints chính xác
                    Positioned.fill(
                      child: SizedBox(
                        width: validWidth,
                        height: validHeight,
                        child: _isMapInitialized
                            ? MapWidget(
                                key: const ValueKey("animated_map_widget"),
                                onMapCreated: _onMapCreated,
                                cameraOptions: _mapService
                                    .getInitialCameraPosition(
                                      pickupLat:
                                          widget.deliveryTracking?.pickupLat,
                                      pickupLng:
                                          widget.deliveryTracking?.pickupLng,
                                      deliveryLat:
                                          widget.deliveryTracking?.deliveryLat,
                                      deliveryLng:
                                          widget.deliveryTracking?.deliveryLng,
                                    ),
                                textureView: true,
                                gestureRecognizers: {
                                  Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer(),
                                  ),
                                },
                              )
                            : _buildLoadingState(),
                      ),
                    ),

                    // Map controls - trực tiếp trong Stack
                    if (_isMapInitialized)
                      Positioned(
                        top: 12.w,
                        right: 12.w,
                        child: _buildMapControls(),
                      ),

                    // Status overlay - trực tiếp trong Stack với opacity animation
                    if (_isMapInitialized && _isExpanded)
                      Positioned(
                        top: 12.w,
                        left: 12.w,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isExpanded ? 1.0 : 0.0,
                          child: _buildStatusOverlay(),
                        ),
                      ),

                    // Shipper info overlay - trực tiếp trong Stack với opacity animation
                    if (_isMapInitialized && _isExpanded)
                      Positioned(
                        bottom: 12.w,
                        left: 12.w,
                        right: 12.w,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isExpanded ? 1.0 : 0.0,
                          child: _buildShipperInfoOverlay(),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8.w),
            Text('Đang tải bản đồ...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildMapControls() {
    return Column(
      children: [
        // Toggle expand/collapse button với animation
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Container(
            key: ValueKey(_isExpanded ? 'collapse' : 'expand'),
            child: _buildMapButton(
              icon: _isExpanded ? Icons.fullscreen_exit : Icons.fullscreen,
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              tooltip: _isExpanded ? 'Thu nhỏ bản đồ' : 'Mở rộng bản đồ',
            ),
          ),
        ),
        SizedBox(height: 8.w),
        // Follow shipper toggle
        _buildMapButton(
          icon: _followShipper ? Icons.gps_fixed : Icons.gps_not_fixed,
          onPressed: () => setState(() => _followShipper = !_followShipper),
          tooltip: _followShipper
              ? 'Dừng theo dõi shipper'
              : 'Theo dõi shipper',
          isActive: _followShipper,
        ),
      ],
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
    if (widget.deliveryTracking == null ||
        !_isMapInitialized ||
        !widget.useFakeMovement) {
      return;
    }

    _movementService?.startFakeShipperMovement(
      pickupLat: widget.deliveryTracking!.pickupLat,
      pickupLng: widget.deliveryTracking!.pickupLng,
      deliveryLat: widget.deliveryTracking!.deliveryLat,
      deliveryLng: widget.deliveryTracking!.deliveryLng,
      shipperId: widget.shipper?.id ?? 456,
    );
  }

  // ==================== UI COMPONENTS ====================

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

  Widget _buildExternalInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status
            if (widget.deliveryTracking != null) ...[
              Row(
                children: [
                  _getStatusIcon(widget.deliveryTracking!.status),
                  SizedBox(width: 8.w),
                  Text(
                    _getStatusTitle(widget.deliveryTracking!.status),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.w),
            ],

            // Shipper Info
            if (widget.shipper != null) ...[
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, size: 20),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.shipper!.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '${widget.shipper!.vehicleType.toUpperCase()} • ${widget.shipper!.vehicleNumber}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _callShipper,
                    icon: Icon(Icons.phone, size: 16),
                    label: Text('Gọi', style: TextStyle(fontSize: 12.sp)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.w,
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

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
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
          SizedBox(width: 8.w),
          Text(
            _getStatusTitle(widget.deliveryTracking!.status),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildShipperInfoOverlay() {
    if (widget.shipper == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(12.w),
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
            child: Icon(Icons.person, size: 20),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.shipper!.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '${widget.shipper!.vehicleType.toUpperCase()} • ${widget.shipper!.vehicleNumber}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _callShipper,
            icon: Icon(Icons.phone, size: 16),
            label: Text('Gọi', style: TextStyle(fontSize: 12.sp)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HELPER METHODS ====================

  Icon _getStatusIcon(DeliveryStatus status) {
    switch (status) {
      case DeliveryStatus.pending:
        return Icon(Icons.access_time, color: Colors.grey);
      case DeliveryStatus.assigned:
        return Icon(Icons.check_circle, color: Colors.green);
      case DeliveryStatus.pickedUp:
        return Icon(Icons.directions_bike, color: Colors.blue);
      case DeliveryStatus.delivering:
        return Icon(Icons.local_shipping, color: Colors.orange);
      case DeliveryStatus.delivered:
        return Icon(Icons.done_all, color: Colors.green);
      case DeliveryStatus.cancelled:
        return Icon(Icons.cancel, color: Colors.red);
    }
  }

  String _getStatusTitle(DeliveryStatus status) {
    return status.displayName;
  }

  void _callShipper() {
    if (widget.shipper != null) {
      AppLogger.i('Gọi cho shipper: ${widget.shipper!.name}');
      // Implement actual call functionality here
    }
  }
}
