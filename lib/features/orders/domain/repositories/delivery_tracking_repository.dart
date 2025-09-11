import 'package:delivery_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/delivery_tracking_entity.dart';

/// Repository interface cho delivery tracking
abstract class DeliveryTrackingRepository {
  /// Stream để lắng nghe delivery updates
  Stream<DeliveryTrackingEntity> get deliveryStream;
  
  /// Stream để lắng nghe connection status
  Stream<bool> get connectionStream;
  
  /// Kết nối đến tracking service
  Future<Either<Failure, void>> connect();
  
  /// Ngắt kết nối tracking service
  Future<Either<Failure, void>> disconnect();
  
  /// Bắt đầu theo dõi delivery cho order
  Future<Either<Failure, void>> startTracking(int orderId);
  
  /// Dừng theo dõi delivery
  Future<Either<Failure, void>> stopTracking();
  
  /// Làm mới kết nối
  Future<Either<Failure, void>> refresh();
  
  /// Kiểm tra trạng thái tracking
  bool get isTracking;
  
  /// Kiểm tra trạng thái kết nối
  bool get isConnected;
}
