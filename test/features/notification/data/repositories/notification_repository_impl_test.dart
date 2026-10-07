import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/notification/data/datasources/notification_api_service.dart';
import 'package:delivery_app/features/notification/data/dtos/notification_dto.dart';
import 'package:delivery_app/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

final _notification = <String, dynamic>{
  'id': 5,
  'userId': 42,
  'title': ' Title ',
  'message': ' Body ',
  'type': 'ORDER',
  'priority': 'MEDIUM',
  'status': 'SENT',
  'isRead': false,
  'relatedEntityId': 7,
  'relatedEntityType': 'ORDER',
  'data': '{"orderId":7}',
  'sentAt': '2026-01-01T00:00:00Z',
  'readAt': '2026-01-02T00:00:00Z',
  'createdAt': '2026-01-01T00:00:00Z',
  'updatedAt': '2026-01-02T00:00:00Z',
};
void main() {
  late Dio dio;
  late DioAdapter adapter;
  late NotificationRepositoryImpl repository;
  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    repository = NotificationRepositoryImpl(NotificationApiService(dio));
  });
  tearDown(() => dio.close());
  final routes = [
    '/notifications/user/42',
    '/notifications/unread',
    '/notifications/unread-count',
    '/notifications/5/read',
    '/notifications/mark-all-read',
    '/notifications/5',
  ];
  void reply(int index, Object? body, {int status = 200}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          expect(request.path, routes[index]);
          expect(
            request.method,
            index == 3 || index == 4
                ? 'PUT'
                : index == 5
                ? 'DELETE'
                : 'GET',
          );
          expect(request.queryParameters, isEmpty);
          expect(request.data, isNull);
          handler.next(request);
        },
      ),
    );
    void handler(dynamic server) => server.reply(status, body);
    if (index == 3 || index == 4) {
      adapter.onPut(routes[index], handler);
    } else if (index == 5) {
      adapter.onDelete(routes[index], handler);
    } else {
      adapter.onGet(routes[index], handler);
    }
  }

  Future<dynamic> call(int index) => switch (index) {
    0 => repository.getUserNotifications(42),
    1 => repository.getUnreadNotifications(),
    2 => repository.getUnreadCount(),
    3 => repository.markAsRead(5),
    4 => repository.markAllAsRead(),
    _ => repository.deleteNotification(5),
  };
  for (var i = 0; i < routes.length; i++) {
    test('maps successful ${routes[i]} envelope', () async {
      final payload = i < 2
          ? [_notification]
          : i == 3
          ? _notification
          : i == 5
          ? null
          : 2;
      reply(i, {'status': 1, 'message': 'ok', 'data': payload});
      final result = await call(i);
      expect(result.isRight(), true);
      result.fold((Object failure) => fail('$failure'), (dynamic value) {
        if (i < 2 || i == 3) {
          final entity = i < 2 ? (value as List).single : value;
          expect(entity.id, 5);
          expect(entity.userId, 42);
          expect(entity.title, 'Title');
          expect(entity.message, 'Body');
          expect(entity.relatedEntityId, 7);
          expect(entity.createdAt, DateTime.utc(2026));
        } else {
          expect(value, i == 5 ? true : 2);
        }
      });
    });
    for (final body in [
      {'status': 0, 'message': 'denied', 'data': null},
      {
        'status': 1,
        'message': 'ok',
        'data': i < 2
            ? [{}]
            : i == 3
            ? {}
            : -1,
      },
      'malformed',
    ]) {
      // Delete accepts any successful envelope; exercise malformed/error only.
      if (i == 5 && body is Map && body['status'] == 1) continue;
      test(
        'maps invalid ${routes[i]} response $body to ServerFailure',
        () async {
          reply(i, body);
          final result = await call(i);
          expect(result.isLeft(), true);
          result.fold(
            (Object failure) => expect(failure, isA<ServerFailure>()),
            (Object value) => fail('Unexpected $value'),
          );
        },
      );
    }
    for (final status in [400, 500]) {
      test('maps HTTP $status for ${routes[i]}', () async {
        reply(i, {'message': 'failed'}, status: status);
        expect((await call(i)).isLeft(), true);
      });
    }
    test('maps timeout for ${routes[i]}', () async {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) => handler.reject(
            DioException(
              requestOptions: request,
              type: DioExceptionType.receiveTimeout,
            ),
          ),
        ),
      );
      expect((await call(i)).isLeft(), true);
    });
  }
  test('DTO serializes every backend field and optional nulls', () {
    final dto = NotificationDto.fromJson(_notification);
    expect(dto.toJson(), _notification);
    expect(NotificationDto.fromJson({}).toJson().values, everyElement(isNull));
  });
}
