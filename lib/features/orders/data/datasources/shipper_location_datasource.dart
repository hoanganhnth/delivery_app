import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../../domain/entities/shipper_location_entity.dart';

/// Abstract interface cho ShipperLocationDataSource
/// Quản lý tracking vị trí shipper real-time qua socket
abstract class ShipperLocationDataSource {
  /// Stream chứa các ShipperLocationEntity được update real-time
  BehaviorSubject<List<ShipperLocationEntity>> get locationStream;
  
  /// Stream trạng thái kết nối socket (true = connected, false = disconnected)
  BehaviorSubject<bool> get connectionStream;
  
  /// Danh sách shipper IDs hiện tại đang được theo dõi
  List<String> get trackedShipperIds;
  
  /// Kết nối tới socket server
  /// Returns true nếu kết nối thành công
  Future<bool> connect();
  
  /// Ngắt kết nối socket
  Future<void> disconnect();
  
  /// Subscribe theo dõi vị trí của shipper specific
  /// [shipperId] - ID của shipper cần theo dõi
  Future<void> subscribeToShipper(String shipperId);
  
  /// Unsubscribe dừng theo dõi shipper
  /// [shipperId] - ID của shipper cần dừng theo dõi
  Future<void> unsubscribeFromShipper(String shipperId);
  
  /// Subscribe theo dõi multiple shippers cùng lúc
  /// [shipperIds] - Danh sách IDs cần theo dõi
  Future<void> subscribeToShippers(List<String> shipperIds);
  
  /// Unsubscribe tất cả shippers đang theo dõi
  Future<void> unsubscribeAll();
  
  /// Lấy vị trí hiện tại của shipper từ cache
  /// [shipperId] - ID của shipper
  /// Returns ShipperLocationEntity hoặc null nếu không tìm thấy
  ShipperLocationEntity? getShipperLocation(String shipperId);
  
  /// Clear tất cả data và đóng streams
  /// Dùng khi dispose feature hoặc logout
  Future<void> dispose();
}
