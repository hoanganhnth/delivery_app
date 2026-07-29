import 'package:delivery_app/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
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
