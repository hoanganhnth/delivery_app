import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/resources/base_response_dto.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_api_service.dart';
import '../mappers/notification_mapper.dart';

/// Implementation của NotificationRepository
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApiService _apiService;

  NotificationRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getUserNotifications(
    int userId,
  ) async {
    try {
      final response = await _apiService.getUserNotifications(userId);
      if (!response.isSuccess || response.data == null) {
        throw const FormatException('Invalid notifications response');
      }
      final entities = response.data!
          .map((dto) => dto.toEntityStrict())
          .toList(growable: false);
      return right(entities);
    } catch (e) {
      AppLogger.e('Failed to fetch notifications', e);
      return left(ServerFailure('Không thể tải thông báo'));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>>
  getUnreadNotifications() async {
    try {
      final response = await _apiService.getUnreadNotifications();
      if (!response.isSuccess || response.data == null) {
        throw const FormatException('Invalid unread notifications response');
      }
      final entities = response.data!
          .map((dto) => dto.toEntityStrict())
          .toList(growable: false);
      return right(entities);
    } catch (e) {
      AppLogger.e('Failed to fetch unread notifications', e);
      return left(ServerFailure('Không thể tải thông báo chưa đọc'));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final response = await _apiService.getUnreadCount();
      final count = response.data;
      if (!response.isSuccess || count == null || count < 0) {
        throw const FormatException('Invalid unread count response');
      }
      return right(count);
    } catch (e) {
      AppLogger.e('Failed to fetch unread count', e);
      return left(ServerFailure('Không thể lấy số thông báo'));
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> markAsRead(int id) async {
    try {
      final response = await _apiService.markAsRead(id);
      if (!response.isSuccess || response.data == null) {
        throw const FormatException('Invalid mark-as-read response');
      }
      return right(response.data!.toEntityStrict());
    } catch (e) {
      AppLogger.e('Failed to mark notification as read', e);
      return left(ServerFailure('Đánh dấu đã đọc thất bại'));
    }
  }

  @override
  Future<Either<Failure, int>> markAllAsRead() async {
    try {
      final response = await _apiService.markAllAsRead();
      final count = response.data;
      if (!response.isSuccess || count == null || count < 0) {
        throw const FormatException('Invalid mark-all-as-read response');
      }
      return right(count);
    } catch (e) {
      AppLogger.e('Failed to mark all as read', e);
      return left(ServerFailure('Đánh dấu tất cả đã đọc thất bại'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotification(int id) async {
    try {
      final response = await _apiService.deleteNotification(id);
      if (!response.isSuccess) {
        throw const FormatException('Invalid delete notification response');
      }
      return right(true);
    } catch (e) {
      AppLogger.e('Failed to delete notification', e);
      return left(ServerFailure('Xóa thông báo thất bại'));
    }
  }
}
