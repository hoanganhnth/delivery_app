import 'package:delivery_app/features/notification/data/datasources/notification_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Map<String, dynamic> _response(Object? data) => {
  'status': 1,
  'message': 'Success',
  'data': data,
};

Map<String, dynamic> _notification() => {
  'id': 5,
  'userId': 42,
  'title': 'Đơn đang giao',
  'message': 'Shipper đang giao đơn',
  'type': 'DELIVERY_DELIVERING',
  'priority': 'MEDIUM',
  'status': 'SENT',
  'isRead': false,
  'createdAt': '2026-07-29T00:00:00.000Z',
};

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late NotificationApiService service;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    service = NotificationApiService(dio);
  });

  test('uses canonical notification read and mutation routes', () async {
    final notification = _notification();
    adapter.onGet(
      '/notifications/user/42',
      (server) => server.reply(200, _response([notification])),
    );
    adapter.onGet(
      '/notifications/unread',
      (server) => server.reply(200, _response([notification])),
    );
    adapter.onGet(
      '/notifications/unread-count',
      (server) => server.reply(200, _response(1)),
    );
    adapter.onPut(
      '/notifications/5/read',
      (server) => server.reply(200, _response(notification)),
    );
    adapter.onPut(
      '/notifications/mark-all-read',
      (server) => server.reply(200, _response(1)),
    );
    adapter.onGet(
      '/notifications/5',
      (server) => server.reply(200, _response(notification)),
    );
    adapter.onDelete(
      '/notifications/5',
      (server) => server.reply(200, _response(null)),
    );

    final user = await service.getUserNotifications(42);
    final unread = await service.getUnreadNotifications();
    final count = await service.getUnreadCount();
    final marked = await service.markAsRead(5);
    final markedAll = await service.markAllAsRead();
    final detail = await service.getNotificationById(5);
    final deleted = await service.deleteNotification(5);

    expect(user.data, hasLength(1));
    expect(unread.data, hasLength(1));
    expect(count.data, 1);
    expect(marked.data?.id, 5);
    expect(markedAll.data, 1);
    expect(detail.data?.id, 5);
    expect(deleted.status, 1);
  });
}
