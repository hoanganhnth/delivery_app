import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../../../../core/network/socket/socket_client.dart';
import '../../domain/entities/shipper_location_entity.dart';
import 'shipper_location_datasource.dart';

/// Socket implementation của ShipperLocationDataSource
class ShipperLocationSocketDataSource implements ShipperLocationDataSource {
  final SocketClient socket;

  // Subjects cho abstract interface - Single entity stream
  final _locationSubject = PublishSubject<ShipperLocationEntity>();
  final _connectionSubject = BehaviorSubject<bool>.seeded(false);

  // State management
  final Map<String, int> _trackedDeliveriesByShipper = {};
  final Map<String, ShipperLocationEntity> _locationCache = {};
  StreamSubscription? _connectionSubscription;

  ShipperLocationSocketDataSource({required this.socket});

  @override
  Stream<ShipperLocationEntity> get locationStream => _locationSubject.stream;

  @override
  Stream<bool> get connectionStream => _connectionSubject.stream;

  @override
  List<String> get trackedShipperIds =>
      _trackedDeliveriesByShipper.keys.toList();

  @override
  Future<bool> connect() async {
    try {
      AppLogger.d('ShipperLocationSocketDataSource: Connecting...');

      // Lắng nghe connection state changes
      _connectionSubscription?.cancel();
      _connectionSubscription = socket.connectionStream.listen((isConnected) {
        _connectionSubject.add(isConnected);

        if (isConnected) {
          // Tự động re-subscribe khi reconnect
          _resubscribeToShippers();
        }
      });

      await socket.connect();
      final isConnected = socket.isConnected;

      if (isConnected) {
        // Setup message listener
        socket.rawStream.listen(_handleLocationMessage);
        AppLogger.d('ShipperLocationSocketDataSource: Connected successfully');
      }

      return isConnected;
    } catch (e) {
      AppLogger.e('ShipperLocationSocketDataSource: Connect failed: $e');
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    AppLogger.d('ShipperLocationSocketDataSource: Disconnecting...');
    await _connectionSubscription?.cancel();
    await socket.disconnect();
  }

  @override
  Future<void> subscribeToShipper(String shipperId, int deliveryId) async {
    try {
      AppLogger.d(
        'ShipperLocationSocketDataSource: Subscribing to shipper $shipperId',
      );

      _trackedDeliveriesByShipper[shipperId] = deliveryId;

      final message = jsonEncode({
        'action': 'subscribe_shipper',
        'shipperId': shipperId,
        'deliveryId': deliveryId,
      });

      socket.sendRaw(message);
      AppLogger.d(
        'ShipperLocationSocketDataSource: Subscribed to shipper $shipperId',
      );
    } catch (e) {
      _trackedDeliveriesByShipper.remove(shipperId);
      AppLogger.e(
        'ShipperLocationSocketDataSource: Subscribe to shipper $shipperId failed: $e',
      );
      rethrow;
    }
  }

  @override
  Future<void> unsubscribeFromShipper(String shipperId) async {
    try {
      AppLogger.d(
        'ShipperLocationSocketDataSource: Unsubscribing from shipper $shipperId',
      );

      _trackedDeliveriesByShipper.remove(shipperId);
      _locationCache.remove(shipperId);

      final message = jsonEncode({
        'action': 'unsubscribe_shipper',
        'shipperId': shipperId,
      });

      socket.sendRaw(message);

      AppLogger.d(
        'ShipperLocationSocketDataSource: Unsubscribed from shipper $shipperId',
      );
    } catch (e) {
      AppLogger.e(
        'ShipperLocationSocketDataSource: Unsubscribe from shipper $shipperId failed: $e',
      );
      rethrow;
    }
  }

  @override
  Future<void> unsubscribeAll() async {
    final shipperIds = _trackedDeliveriesByShipper.keys.toList();
    for (final shipperId in shipperIds) {
      await unsubscribeFromShipper(shipperId);
    }
  }

  @override
  ShipperLocationEntity? getShipperLocation(String shipperId) {
    return _locationCache[shipperId];
  }

  void _handleLocationMessage(String message) {
    try {
      final data = jsonDecode(message) as Map<String, dynamic>;

      if (data['type'] == 'location_update') {
        final shipperId = _toInt(data['shipperId']);
        final latitude = _toDouble(data['latitude']);
        final longitude = _toDouble(data['longitude']);
        final timestamp = _toDateTime(data['timestamp']);
        if (shipperId == null ||
            latitude == null ||
            longitude == null ||
            timestamp == null) {
          AppLogger.w(
            'ShipperLocationSocketDataSource: Ignoring malformed location update',
          );
          return;
        }

        final location = ShipperLocationEntity(
          shipperId: shipperId,
          latitude: latitude,
          longitude: longitude,
          updatedAt: timestamp,
          accuracy: _toDouble(data['accuracy']),
          speed: _toDouble(data['speed']),
          heading: _toDouble(data['heading']),
        );

        // Chỉ xử lý location của shippers đang track
        if (_trackedDeliveriesByShipper.containsKey(
          location.shipperId.toString(),
        )) {
          _locationCache[location.shipperId.toString()] = location;

          // Emit single entity thay vì list
          if (!_locationSubject.isClosed) {
            _locationSubject.add(location);
          }

          AppLogger.d(
            'ShipperLocationSocketDataSource: Updated location for shipper ${location.shipperId}',
          );
        }
      }
    } catch (e) {
      AppLogger.e(
        'ShipperLocationSocketDataSource: Failed to parse location message: $e',
      );
    }
  }

  /// Tự động re-subscribe các shippers sau khi reconnect
  Future<void> _resubscribeToShippers() async {
    if (_trackedDeliveriesByShipper.isNotEmpty) {
      AppLogger.d(
        'ShipperLocationSocketDataSource: Re-subscribing to ${_trackedDeliveriesByShipper.length} shippers',
      );

      final subscriptions = Map<String, int>.from(_trackedDeliveriesByShipper);
      _trackedDeliveriesByShipper.clear();

      for (final entry in subscriptions.entries) {
        await subscribeToShipper(entry.key, entry.value);
      }
    }
  }

  // Type-safe parsing helpers
  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  DateTime? _toDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  @override
  Future<void> dispose() async {
    AppLogger.d('ShipperLocationSocketDataSource: Disposing...');

    await _connectionSubscription?.cancel();
    await unsubscribeAll();
    await socket.disconnect();

    if (!_locationSubject.isClosed) {
      await _locationSubject.close();
    }
    if (!_connectionSubject.isClosed) {
      await _connectionSubject.close();
    }

    _locationCache.clear();
    _trackedDeliveriesByShipper.clear();
  }
}
