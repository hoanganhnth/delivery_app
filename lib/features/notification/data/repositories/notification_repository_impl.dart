import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_api_service.dart';
import '../dtos/notification_dto.dart';

/// Implementation của NotificationRepository
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationApiService _apiService;

  NotificationRepositoryImpl(this._apiService);

  NotificationEntity _mapDtoToEntity(NotificationDto dto) {
    return NotificationEntity(
      id: dto.id ?? 0,
      userId: dto.userId ?? 0,
      title: dto.title ?? '',
      message: dto.message ?? '',
      type: dto.type ?? '',
      priority: dto.priority ?? 'NORMAL',
      status: dto.status ?? '',
      isRead: dto.isRead ?? false,
      relatedEntityId: dto.relatedEntityId,
      relatedEntityType: dto.relatedEntityType,
      data: dto.data,
      sentAt: dto.sentAt != null ? DateTime.tryParse(dto.sentAt!) : null,
      readAt: dto.readAt != null ? DateTime.tryParse(dto.readAt!) : null,
      createdAt: dto.createdAt != null
          ? DateTime.tryParse(dto.createdAt!) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getUserNotifications(
      int userId) async {
    try {
      final response = await _apiService.getUserNotifications(userId);
      final entities =
          (response.data ?? []).map((dto) => _mapDtoToEntity(dto)).toList();
      return right(entities);
    } catch (e) {
      AppLogger.e('Failed to fetch notifications: $e');
      return left(ServerFailure('Không thể tải thông báo: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>>
      getUnreadNotifications() async {
    try {
      final response = await _apiService.getUnreadNotifications();
      final entities =
          (response.data ?? []).map((dto) => _mapDtoToEntity(dto)).toList();
      return right(entities);
    } catch (e) {
      AppLogger.e('Failed to fetch unread notifications: $e');
      return left(ServerFailure(
          'Không thể tải thông báo chưa đọc: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final response = await _apiService.getUnreadCount();
      return right(response.data ?? 0);
    } catch (e) {
      AppLogger.e('Failed to fetch unread count: $e');
      return left(ServerFailure('Không thể lấy số thông báo: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> markAsRead(int id) async {
    try {
      final response = await _apiService.markAsRead(id);
      return right(_mapDtoToEntity(response.data!));
    } catch (e) {
      AppLogger.e('Failed to mark notification as read: $e');
      return left(ServerFailure('Đánh dấu đã đọc thất bại: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, int>> markAllAsRead() async {
    try {
      final response = await _apiService.markAllAsRead();
      return right(response.data ?? 0);
    } catch (e) {
      AppLogger.e('Failed to mark all as read: $e');
      return left(ServerFailure(
          'Đánh dấu tất cả đã đọc thất bại: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotification(int id) async {
    try {
      await _apiService.deleteNotification(id);
      return right(true);
    } catch (e) {
      AppLogger.e('Failed to delete notification: $e');
      return left(ServerFailure('Xóa thông báo thất bại: ${e.toString()}'));
    }
  }
}
