import 'dart:convert';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/user_address/data/datasources/user_address_api_service.dart';
import 'package:delivery_app/features/user_address/data/datasources/user_address_remote_datasource.dart';
import 'package:delivery_app/features/user_address/data/datasources/user_address_remote_datasource_impl.dart';
import 'package:delivery_app/features/user_address/data/dtos/user_address_request_dto.dart';
import 'package:delivery_app/features/user_address/data/dtos/user_address_response_dto.dart';
import 'package:delivery_app/features/user_address/data/repositories/user_address_repository_impl.dart';
import 'package:delivery_app/features/user_address/domain/entities/address_upsert_command.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

const command = AddressUpsertCommand(
  label: 'Office',
  recipientName: 'Customer',
  phoneNumber: '0900000001',
  addressLine: '45 Nguyen Hue',
  ward: 'Ben Nghe',
  district: 'District 1',
  city: 'HCM',
  postalCode: '700000',
  latitude: 10.77,
  longitude: 106.7,
  isDefault: true,
);
const body = <String, dynamic>{
  'label': 'Office',
  'recipientName': 'Customer',
  'phoneNumber': '0900000001',
  'addressLine': '45 Nguyen Hue',
  'ward': 'Ben Nghe',
  'district': 'District 1',
  'city': 'HCM',
  'postalCode': '700000',
  'latitude': 10.77,
  'longitude': 106.7,
  'isDefault': true,
};
final address = <String, dynamic>{
  'id': 8,
  'userId': 42,
  ...body,
  'createdAt': '2026-07-29T00:00:00.000Z',
  'updatedAt': '2026-07-30T00:00:00.000Z',
};

void main() {
  test('DTO round trips every field and defaults nullable isDefault', () {
    final request = UserAddressRequestDto.fromJson(body);
    expect(request.toJson(), body);
    final dto = UserAddressResponseDto.fromJson(address);
    expect(dto.toJson(), address);
    expect(dto.toEntity().toDto(), dto);
    expect(dto.copyWith(isDefault: null).toEntity().isDefault, isFalse);
    expect(dto.toEntity().latitude, 10.77);
    expect(dto.toEntity().createdAt, DateTime.utc(2026, 7, 29));
  });

  final operations = <String, (String, String)>{
    'list': ('GET', '/addresses/users/42/addresses'),
    'get': ('GET', '/addresses/8'),
    'create': ('POST', '/addresses/users/42/addresses'),
    'update': ('PUT', '/addresses/8'),
    'delete': ('DELETE', '/addresses/8'),
    'default': ('PATCH', '/addresses/8/default'),
  };
  for (final entry in operations.entries) {
    for (final scenario in [
      'success',
      'rejected',
      'missing',
      'malformed',
      'invalid-item',
      '401',
      '404',
      '500',
      'timeout',
    ]) {
      test(
        '${entry.key} maps $scenario through HTTP, datasource and repository',
        () async {
          final dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
          final adapter = DioAdapter(dio: dio);
          RequestOptions? sent;
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) {
                sent = options;
                if (scenario == 'timeout') {
                  handler.reject(
                    DioException(
                      requestOptions: options,
                      type: DioExceptionType.receiveTimeout,
                    ),
                  );
                } else {
                  handler.next(options);
                }
              },
            ),
          );
          final (method, path) = entry.value;
          final status = int.tryParse(scenario) ?? 200;
          final data = scenario == 'missing'
              ? null
              : scenario == 'malformed'
              ? 'invalid'
              : scenario == 'invalid-item'
              ? (entry.key == 'list' ? [{}] : {})
              : entry.key == 'list'
              ? [address]
              : entry.key == 'delete'
              ? null
              : address;
          adapter.onRoute(
            path,
            (server) => server.reply(status, {
              'status': scenario == 'rejected' ? 0 : 1,
              'message': scenario == 'success' ? 'Success' : 'address rejected',
              'data': data,
            }),
            request: Request(
              method: RequestMethods.forName(name: method),
              data: method == 'POST' || method == 'PUT' ? Matchers.any : null,
            ),
          );
          final repository = UserAddressRepositoryImpl(
            UserAddressRemoteDataSourceImpl(UserAddressApiService(dio)),
          );
          final result = switch (entry.key) {
            'list' => await repository.getUserAddresses(42),
            'get' => await repository.getAddressById(8),
            'create' => await repository.createAddress(42, command),
            'update' => await repository.updateAddress(8, command),
            'delete' => await repository.deleteAddress(8),
            _ => await repository.setDefaultAddress(8),
          };
          expect(sent?.method, method);
          expect(sent?.uri.path, '/api$path');
          expect(sent?.queryParameters, isEmpty);
          if (method == 'POST' || method == 'PUT') {
            expect(jsonDecode(jsonEncode(sent?.data)), body);
          }
          if (scenario == 'success' ||
              (entry.key == 'list' && scenario == 'malformed') ||
              (entry.key == 'delete' &&
                  [
                    'rejected',
                    'missing',
                    'malformed',
                    'invalid-item',
                  ].contains(scenario))) {
            expect(result.isRight(), isTrue);
            result.fold((e) => fail('$e'), (value) {
              if (entry.key == 'delete') {
                expect(value, scenario != 'rejected');
              } else if (entry.key == 'list') {
                expect((value as List).length, scenario == 'malformed' ? 0 : 1);
              } else {
                // Compare every mapped field, including optional coordinates and dates.
                expect((value as UserAddressEntity).toDto().toJson(), address);
              }
            });
          } else {
            expect(result.isLeft(), isTrue);
            final failure = result.fold((e) => e, (_) => null);
            if (scenario == 'timeout') expect(failure, isA<NetworkFailure>());
            if (scenario == '401') expect(failure, isA<UnauthorizedFailure>());
            if (scenario == '404' || scenario == '500') {
              expect(failure, isA<ServerFailure>());
            }
            if ([
              'rejected',
              'missing',
              'malformed',
              'invalid-item',
            ].contains(scenario)) {
              expect(failure, isA<UnexpectedFailure>());
            }
          }
          dio.close();
        },
      );
    }
    test(
      '${entry.key} converts non-Exception datasource errors to server failures',
      () async {
        final repository = UserAddressRepositoryImpl(_BrokenSource());
        final result = switch (entry.key) {
          'list' => await repository.getUserAddresses(42),
          'get' => await repository.getAddressById(8),
          'create' => await repository.createAddress(42, command),
          'update' => await repository.updateAddress(8, command),
          'delete' => await repository.deleteAddress(8),
          _ => await repository.setDefaultAddress(8),
        };
        expect(result.fold((e) => e, (_) => null), isA<ServerFailure>());
      },
    );
  }
}

class _BrokenSource implements UserAddressRemoteDataSource {
  Never broken() => throw StateError('broken');
  @override
  Future<List<UserAddressResponseDto>> getUserAddresses(int userId) async =>
      broken();
  @override
  Future<UserAddressResponseDto> getAddressById(int addressId) async =>
      broken();
  @override
  Future<UserAddressResponseDto> createAddress(
    int userId,
    UserAddressRequestDto request,
  ) async => broken();
  @override
  Future<UserAddressResponseDto> updateAddress(
    int addressId,
    UserAddressRequestDto request,
  ) async => broken();
  @override
  Future<bool> deleteAddress(int addressId) async => broken();
  @override
  Future<UserAddressResponseDto> setDefaultAddress(int addressId) async =>
      broken();
}
