import 'package:delivery_app/features/user_address/data/datasources/user_address_api_service.dart';
import 'package:delivery_app/features/user_address/data/dtos/user_address_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late UserAddressApiService service;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    service = UserAddressApiService(dio);
  });

  test('reads user addresses through canonical /api/addresses path', () async {
    adapter.onGet(
      '/addresses/users/42/addresses',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': [
          {
            'id': 7,
            'userId': 42,
            'label': 'Nhà',
            'recipientName': 'Khách Test',
            'phoneNumber': '0900000001',
            'addressLine': '123 Lê Lợi',
            'ward': 'Phường 1',
            'district': 'Quận 1',
            'city': 'TP.HCM',
            'postalCode': null,
            'latitude': 10.7769,
            'longitude': 106.7009,
            'isDefault': true,
            'createdAt': '2026-07-29T00:00:00.000Z',
            'updatedAt': '2026-07-29T00:00:00.000Z',
          },
        ],
      }),
    );

    final response = await service.getUserAddresses(42);

    expect(response.status, 1);
    expect(response.data, hasLength(1));
    expect(response.data?.single.userId, 42);
  });

  test('creates address through canonical /api/addresses path', () async {
    const request = UserAddressRequestDto(
      label: 'Cơ quan',
      recipientName: 'Khách Test',
      phoneNumber: '0900000002',
      addressLine: '45 Nguyễn Huệ',
      ward: 'Phường Bến Nghé',
      district: 'Quận 1',
      city: 'TP.HCM',
      postalCode: null,
      latitude: 10.777,
      longitude: 106.703,
      isDefault: false,
    );

    adapter.onPost(
      '/addresses/users/42/addresses',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 8,
          'userId': 42,
          ...request.toJson(),
          'createdAt': '2026-07-29T00:00:00.000Z',
          'updatedAt': '2026-07-29T00:00:00.000Z',
        },
      }),
      data: request,
    );

    final response = await service.createAddress(42, request);

    expect(response.status, 1);
    expect(response.data?.label, 'Cơ quan');
  });

  test('updates and defaults address through canonical /api/addresses path', () async {
    const request = UserAddressRequestDto(
      label: 'Nhà mới',
      recipientName: 'Khách Test',
      phoneNumber: '0900000003',
      addressLine: '99 Lê Lai',
      ward: 'Phường Bến Thành',
      district: 'Quận 1',
      city: 'TP.HCM',
      postalCode: '700000',
      latitude: 10.775,
      longitude: 106.703,
      isDefault: true,
    );

    adapter.onPut(
      '/addresses/8',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 8,
          'userId': 42,
          ...request.toJson(),
          'createdAt': '2026-07-29T00:00:00.000Z',
          'updatedAt': '2026-07-29T00:00:00.000Z',
        },
      }),
      data: request,
    );

    final updated = await service.updateAddress(8, request);
    expect(updated.data?.isDefault, true);

    adapter.onPatch(
      '/addresses/8/default',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 8,
          'userId': 42,
          'label': 'Nhà mới',
          'recipientName': 'Khách Test',
          'phoneNumber': '0900000003',
          'addressLine': '99 Lê Lai',
          'ward': 'Phường Bến Thành',
          'district': 'Quận 1',
          'city': 'TP.HCM',
          'postalCode': '700000',
          'latitude': 10.775,
          'longitude': 106.703,
          'isDefault': true,
          'createdAt': '2026-07-29T00:00:00.000Z',
          'updatedAt': '2026-07-29T00:00:00.000Z',
        },
      }),
    );

    final defaultAddress = await service.setDefaultAddress(8);
    expect(defaultAddress.data?.isDefault, true);
  });

  test('deletes address through canonical /api/addresses path', () async {
    adapter.onDelete(
      '/addresses/8',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': null,
      }),
    );

    final response = await service.deleteAddress(8);
    expect(response.status, 1);
  });

  test('reads address by id through canonical /api/addresses path', () async {
    adapter.onGet(
      '/addresses/8',
      (server) => server.reply(200, {
        'status': 1,
        'message': 'Success',
        'data': {
          'id': 8,
          'userId': 42,
          'label': 'Nhà',
          'recipientName': 'Khách Test',
          'phoneNumber': '0900000001',
          'addressLine': '123 Lê Lợi',
          'ward': 'Phường 1',
          'district': 'Quận 1',
          'city': 'TP.HCM',
          'postalCode': null,
          'latitude': 10.7769,
          'longitude': 106.7009,
          'isDefault': true,
          'createdAt': '2026-07-29T00:00:00.000Z',
          'updatedAt': '2026-07-29T00:00:00.000Z',
        },
      }),
    );

    final response = await service.getAddressById(8);

    expect(response.status, 1);
    expect(response.data?.id, 8);
  });
}
