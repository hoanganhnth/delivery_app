import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dtos/notification_dto.dart';

part 'notification_api_service.g.dart';

@RestApi()
abstract class NotificationApiService {
  factory NotificationApiService(Dio dio) = _NotificationApiService;

  /// Lấy tất cả thông báo của user
  @GET('${ApiConstants.userNotifications}/{userId}')
  Future<BaseResponseDto<List<NotificationDto>>> getUserNotifications(
    @Path('userId') int userId,
  );

  /// Lấy thông báo chưa đọc
  @GET(ApiConstants.unreadNotifications)
  Future<BaseResponseDto<List<NotificationDto>>> getUnreadNotifications();

  /// Đếm thông báo chưa đọc
  @GET(ApiConstants.unreadCount)
  Future<BaseResponseDto<int>> getUnreadCount();

  /// Đánh dấu đã đọc
  @PUT('${ApiConstants.notifications}/{id}/read')
  Future<BaseResponseDto<NotificationDto>> markAsRead(@Path('id') int id);

  /// Đánh dấu tất cả đã đọc
  @PUT(ApiConstants.markAllRead)
  Future<BaseResponseDto<int>> markAllAsRead();

  /// Lấy thông báo theo ID
  @GET('${ApiConstants.notifications}/{id}')
  Future<BaseResponseDto<NotificationDto>> getNotificationById(@Path('id') int id);

  /// Xóa thông báo
  @DELETE('${ApiConstants.notifications}/{id}')
  Future<BaseResponseDto<void>> deleteNotification(@Path('id') int id);
}
