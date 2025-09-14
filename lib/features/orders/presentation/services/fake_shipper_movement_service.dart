import 'dart:async';
import 'dart:math' as math;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/shipper_location_entity.dart';

/// Service để xử lý fake shipper movement animation
class FakeShipperMovementService {
  // Animation configuration
  static const int _totalSteps = 100; // Số bước di chuyển
  static const Duration _stepDuration = Duration(milliseconds: 200); // Thời gian mỗi bước

  // Movement state
  Timer? _movementTimer;
  bool _isMoving = false;
  int _currentStep = 0;
  List<Position> _movementPath = [];

  // Callback để cập nhật UI
  final void Function(ShipperLocationEntity) onPositionUpdated;
  
  FakeShipperMovementService({
    required this.onPositionUpdated,
  });

  /// Bắt đầu fake movement từ pickup đến delivery
  void startFakeShipperMovement({
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
    required int shipperId,
  }) {
    if (_isMoving) {
      stopFakeShipperMovement();
    }

    // Tạo đường đi từ pickup đến delivery
    _createMovementPath(
      startLat: pickupLat,
      startLng: pickupLng,
      endLat: deliveryLat,
      endLng: deliveryLng,
    );

    // Bắt đầu animation
    _isMoving = true;
    _currentStep = 0;
    _movementTimer = Timer.periodic(_stepDuration, (timer) {
      _updateShipperPosition(timer, shipperId);
    });

    AppLogger.d('Started fake shipper movement from ($pickupLat, $pickupLng) to ($deliveryLat, $deliveryLng)');
  }

  /// Tạo đường đi với nhiều điểm để có chuyển động mượt mà
  void _createMovementPath({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
  }) {
    _movementPath.clear();

    // Tạo đường cong mượt mà với nhiều điểm
    for (int i = 0; i <= _totalSteps; i++) {
      final t = i / _totalSteps;
      // Thêm độ cong để làm cho đường đi thực tế hơn
      final curveOffset = math.sin(t * math.pi) * 0.001; // Độ cong nhỏ

      final lat = startLat + (endLat - startLat) * t + curveOffset;
      final lng = startLng + (endLng - startLng) * t;

      _movementPath.add(Position(lng, lat));
    }

    AppLogger.d('Created movement path with ${_movementPath.length} steps');
  }

  /// Cập nhật vị trí shipper theo từng bước
  void _updateShipperPosition(Timer timer, int shipperId) {
    if (!_isMoving || _movementPath.isEmpty) {
      timer.cancel();
      return;
    }

    if (_currentStep >= _movementPath.length - 1) {
      // Hoàn thành di chuyển
      stopFakeShipperMovement();
      AppLogger.i('Fake shipper movement completed');
      return;
    }

    _currentStep++;
    final newPosition = _movementPath[_currentStep];

    // Tạo fake shipper location với vị trí mới
    final fakeShipperLocation = ShipperLocationEntity(
      shipperId: shipperId,
      latitude: newPosition.lat.toDouble(),
      longitude: newPosition.lng.toDouble(),
      accuracy: 5.0,
      speed: 25.0 + math.sin(_currentStep * 0.1) * 5.0, // Tốc độ thay đổi
      heading: _calculateHeading(_currentStep),
      isOnline: true,
      lastPing: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Gọi callback để cập nhật UI
    onPositionUpdated(fakeShipperLocation);
  }

  /// Tính toán hướng đi dựa trên hai điểm liền kề
  double _calculateHeading(int step) {
    if (step < 1 || _movementPath.length <= step) return 0.0;

    final current = _movementPath[step];
    final previous = _movementPath[step - 1];

    final deltaLng = current.lng - previous.lng;
    final deltaLat = current.lat - previous.lat;

    return math.atan2(deltaLng, deltaLat) * 180 / math.pi;
  }

  /// Dừng fake movement
  void stopFakeShipperMovement() {
    _isMoving = false;
    _movementTimer?.cancel();
    _movementTimer = null;
    AppLogger.d('Stopped fake shipper movement');
  }

  /// Kiểm tra xem có đang di chuyển không
  bool get isMoving => _isMoving;

  /// Lấy tiến độ di chuyển hiện tại (0.0 - 1.0)
  double get progress {
    if (_movementPath.isEmpty) return 0.0;
    return _currentStep / (_movementPath.length - 1);
  }

  /// Cleanup khi không cần dùng nữa
  void dispose() {
    stopFakeShipperMovement();
  }
}
