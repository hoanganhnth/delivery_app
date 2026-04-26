import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_entity.dart';

/// Repository interface for notification management
abstract class NotificationRepository {
  /// Lấy tất cả thông báo của user
  Future<Either<Failure, List<NotificationEntity>>> getUserNotifications(int userId);

  /// Lấy thông báo chưa đọc
  Future<Either<Failure, List<NotificationEntity>>> getUnreadNotifications();

  /// Lấy số lượng thông báo chưa đọc
  Future<Either<Failure, int>> getUnreadCount();

  /// Đánh dấu đã đọc
  Future<Either<Failure, NotificationEntity>> markAsRead(int id);

  /// Đánh dấu tất cả đã đọc
  Future<Either<Failure, int>> markAllAsRead();

  /// Xóa thông báo
  Future<Either<Failure, bool>> deleteNotification(int id);
}
