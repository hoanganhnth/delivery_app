import 'dart:async';
import 'dart:math';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/delivery_tracking_entity.dart';
import '../../domain/entities/shipper_location_entity.dart';
import '../../domain/entities/order_entity.dart';

/// Mock Socket Service để test delivery tracking
class MockDeliveryTrackingService {
  static final MockDeliveryTrackingService _instance = 
      MockDeliveryTrackingService._internal();
  factory MockDeliveryTrackingService() => _instance;
  MockDeliveryTrackingService._internal();

  final _deliveryController = StreamController<DeliveryTrackingEntity>.broadcast();
  final _shipperLocationController = StreamController<ShipperLocationEntity>.broadcast();
  final _orderStatusController = StreamController<OrderEntity>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();
  
  Timer? _simulationTimer;
  bool _isConnected = false;
  int? _currentOrderId;
  
  /// Stream theo dõi delivery tracking (info tổng thể)
  Stream<DeliveryTrackingEntity> get deliveryStream => _deliveryController.stream;
  
  /// Stream theo dõi vị trí shipper real-time
  Stream<ShipperLocationEntity> get shipperLocationStream => _shipperLocationController.stream;
  
  /// Stream theo dõi order status
  Stream<OrderEntity> get orderStatusStream => _orderStatusController.stream;
  
  /// Stream theo dõi connection status
  Stream<bool> get connectionStream => _connectionController.stream;

  bool get isConnected => _isConnected;

  /// Kết nối mock socket
  Future<void> connect() async {
    try {
      AppLogger.i('Connecting to mock delivery tracking...');
      await Future.delayed(const Duration(milliseconds: 500));
      
      _isConnected = true;
      _connectionController.add(true);
      AppLogger.i('Mock delivery tracking connected');
      
    } catch (e) {
      AppLogger.e('Failed to connect mock delivery tracking', e);
      _connectionController.add(false);
    }
  }

  /// Bắt đầu theo dõi order
  void startTrackingOrder(int orderId) {
    if (!_isConnected) {
      AppLogger.w('Not connected. Cannot track order $orderId');
      return;
    }

    _currentOrderId = orderId;
    AppLogger.i('Starting tracking for order $orderId');
    
    // Bắt đầu simulation
    _startSimulation();
  }

  /// Dừng theo dõi order
  void stopTrackingOrder() {
    if (_currentOrderId != null) {
      AppLogger.i('Stopping tracking for order $_currentOrderId');
      _currentOrderId = null;
    }
    
    _simulationTimer?.cancel();
    _simulationTimer = null;
  }

  /// Simulation vị trí shipper di chuyển
  void _startSimulation() {
    _simulationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _updateDeliveryTracking();
      _updateShipperLocation();
    });
  }

  /// Update delivery tracking info
  void _updateDeliveryTracking() {
    if (!_isConnected || _currentOrderId == null) return;
    
    final tracking = _generateDeliveryTracking(_currentOrderId!);
    AppLogger.d('Mock Delivery Update: ${tracking.status}');
    _deliveryController.add(tracking);
  }

  /// Update shipper location (real-time)
  void _updateShipperLocation() {
    if (!_isConnected || _currentOrderId == null) return;
    
    final location = _generateShipperLocation();
    AppLogger.d('Mock Shipper Location: ${location.latitude}, ${location.longitude}');
    _shipperLocationController.add(location);
  }

  /// Generate mock delivery tracking data
  DeliveryTrackingEntity _generateDeliveryTracking(int orderId) {
    final random = Random();
    final now = DateTime.now();
    
    // Simulate different delivery phases
    final phases = ['ASSIGNED', 'PICKING_UP', 'DELIVERING', 'NEAR_DELIVERY'];
    final currentPhase = phases[random.nextInt(phases.length)];
    
    return DeliveryTrackingEntity(
      id: random.nextInt(1000),
      orderId: orderId,
      shipperId: 101,
      status: currentPhase,
      pickupAddress: 'KFC Nguyễn Văn Cừ, Quận 5',
      pickupLat: 10.8231,
      pickupLng: 106.6297,
      deliveryAddress: '123 Đường ABC, Quận 1',
      deliveryLat: 10.7769 + (random.nextDouble() - 0.5) * 0.01,
      deliveryLng: 106.7009 + (random.nextDouble() - 0.5) * 0.01,
      shipperCurrentLat: 10.8231 + (random.nextDouble() - 0.5) * 0.01,
      shipperCurrentLng: 106.6297 + (random.nextDouble() - 0.5) * 0.01,
      estimatedDeliveryTime: now.add(Duration(minutes: 15 + random.nextInt(30))),
      notes: _getStatusNote(currentPhase, 1),
      assignedAt: now.subtract(const Duration(minutes: 10)),
    );
  }

  /// Generate mock shipper location data  
  ShipperLocationEntity _generateShipperLocation() {
    final random = Random();
    
    return ShipperLocationEntity(
      shipperId: 101,
      latitude: 10.8231 + (random.nextDouble() - 0.5) * 0.01,
      longitude: 106.6297 + (random.nextDouble() - 0.5) * 0.01,
      accuracy: 5.0 + random.nextDouble() * 10,
      speed: random.nextDouble() * 30, // km/h
      heading: random.nextDouble() * 360, // degrees
      updatedAt: DateTime.now(),
      isOnline: true,
      lastPing: DateTime.now(),
    );
  }

  /// Get status note in Vietnamese
  String _getStatusNote(String status, int step) {
    switch (status) {
      case 'ASSIGNED':
        return 'Shipper đã nhận đơn và đang di chuyển đến nhà hàng';
      case 'PICKING_UP':
        return 'Shipper đang lấy đồ ăn tại nhà hàng';
      case 'DELIVERING':
        return 'Shipper đang giao hàng đến bạn';
      case 'NEAR_DELIVERY':
        return 'Shipper sắp đến nơi giao hàng';
      default:
        return 'Đang cập nhật...';
    }
  }

  /// Tạo shipper entity mẫu
  ShipperEntity getMockShipper() {
    return const ShipperEntity(
      id: 101,
      name: 'Nguyễn Văn A',
      phone: '0901234567',
      vehicleType: 'motorbike',
      vehicleNumber: '59H1-12345',
      rating: 4.8,
      avatar: 'https://i.pravatar.cc/150?img=1',
    );
  }

  /// Disconnect
  void disconnect() {
    AppLogger.i('Disconnecting mock delivery tracking');
    _isConnected = false;
    _connectionController.add(false);
    stopTrackingOrder();
  }

  /// Dispose
  void dispose() {
    disconnect();
    _deliveryController.close();
    _shipperLocationController.close();
    _orderStatusController.close();
    _connectionController.close();
  }
}
