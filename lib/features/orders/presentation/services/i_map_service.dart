import '../../domain/entities/shipper_location_entity.dart';

/// Interface cho dịch vụ bản đồ (Map Service)
/// Sử dụng Generic Type để có thể thay thế MapBox bằng Google Maps hoặc Provider khác
/// [TMap] là kiểu của Map Controller (VD: MapboxMap, GoogleMapController)
/// [TCamera] là kiểu của Camera Options (VD: CameraOptions, CameraPosition)
abstract class IMapService<TMap, TCamera> {
  /// Kiểm tra map đã được khởi tạo thành công chưa
  bool get isInitialized;

  /// Khởi tạo map controller và các setup cơ bản
  Future<void> initializeMap(TMap mapController);

  /// Thêm marker cho điểm nhận hàng (nhà hàng) và giao hàng (khách hàng)
  Future<void> addDeliveryMarkers({
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
  });

  /// Cập nhật vị trí của shipper (marker di chuyển)
  Future<void> updateShipperMarker(ShipperLocationEntity location);

  /// Vẽ tuyến đường (polyline) giữa các điểm
  Future<void> drawRoute(List<List<double>> points);

  /// Di chuyển camera đến một toạ độ cụ thể
  Future<void> moveCamera({
    required double latitude,
    required double longitude,
    double zoom = 14.0,
  });

  /// Tự động zoom và pan camera để vừa vặn tất cả các marker trên màn hình
  Future<void> fitBoundsToMarkers({
    required double pickupLat,
    required double pickupLng,
    required double deliveryLat,
    required double deliveryLng,
    double? shipperLat,
    double? shipperLng,
  });

  /// Tính toán vị trí camera hiển thị mặc định khi mới mở bản đồ
  TCamera getInitialCameraPosition({
    double? pickupLat,
    double? pickupLng,
    double? deliveryLat,
    double? deliveryLng,
  });

  /// Dọn dẹp tài nguyên (Hủy subscription, xóa marker, v.v)
  void dispose();
}
