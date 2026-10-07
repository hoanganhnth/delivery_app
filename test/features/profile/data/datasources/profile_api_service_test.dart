import 'package:delivery_app/features/profile/data/dtos/user_profile_dto.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('reads the current profile through canonical GET /users', () async {
    final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    final adapter = DioAdapter(dio: dio);
    final service = ProfileApiService(dio);

    adapter.onGet(
      '/users',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 1,
          'authId': 10,
          'email': 'customer@test.dev',
          'role': 'USER',
          'fullName': 'Khách Test',
          'createdAt': '2026-10-01T10:00:00',
          'updatedAt': '2026-10-02T11:00:00',
        },
      }),
    );

    final response = await service.getUserProfile();

    expect(response.status, 1);
    expect(response.data?.authId, 10);
    final user = response.data!.toEntity();
    expect(user.createdAt, DateTime(2026, 10, 1, 10));
    expect(user.updatedAt, DateTime(2026, 10, 2, 11));
  });

  test('updates the current profile through canonical PUT /users', () async {
    final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    final adapter = DioAdapter(dio: dio);
    final service = ProfileApiService(dio);
    final body = <String, dynamic>{
      'fullName': 'Khách Test',
      'phone': '0900000001',
      'dob': null,
      'address': null,
    };

    adapter.onPut(
      '/users',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 1,
          'authId': 10,
          'email': 'customer@test.dev',
          'role': 'USER',
          ...body,
        },
      }),
      data: body,
    );

    final response = await service.updateUserProfile(body);

    expect(response.status, 1);
    expect(response.data?.fullName, 'Khách Test');
  });
}
