import 'dart:async';

import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/core/network/resources/base_response_dto.dart';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource.dart';
import 'package:delivery_app/features/orders/data/datasources/delivery_tracking_remote_datasource_impl.dart';
import 'package:delivery_app/features/orders/data/datasources/shipper_location_datasource.dart';
import 'package:delivery_app/features/orders/data/dtos/current_delivery_dto.dart';
import 'package:delivery_app/features/orders/data/repositories/delivery_tracking_repository_impl.dart';
import 'package:delivery_app/features/orders/data/repositories/shipper_location_repository_impl.dart';
import 'package:delivery_app/features/orders/domain/entities/shipper_location_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  for (final scenario in [
    'success',
    'rejected',
    'missing',
    'malformed',
    '401',
    '500',
    'timeout',
  ]) {
    test(
      'delivery tracking maps $scenario through REST and repository',
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
                    type: DioExceptionType.sendTimeout,
                  ),
                );
              } else {
                handler.next(options);
              }
            },
          ),
        );
        adapter.onGet(
          '/deliveries/order/601',
          (server) => server.reply(int.tryParse(scenario) ?? 200, {
            'status': scenario == 'rejected' ? 0 : 1,
            'message': 'delivery response',
            'data': scenario == 'missing'
                ? null
                : scenario == 'malformed'
                ? 'invalid'
                : {
                    'id': 1,
                    'orderId': 601,
                    'shipperId': 9,
                    'status': 'ASSIGNED',
                    'pickupAddress': 'Shop',
                    'deliveryAddress': 'Home',
                    'pickupLat': 10.77,
                    'pickupLng': 106.7,
                    'deliveryLat': 10.78,
                    'deliveryLng': 106.71,
                  },
          }),
        );
        final repository = DeliveryTrackingRepositoryImpl(
          DeliveryTrackingRemoteDataSourceImpl(DeliveryTrackingApiService(dio)),
        );
        final result = await repository.getCurrentDelivery(601);
        expect(sent?.method, 'GET');
        expect(sent?.uri.path, '/api/deliveries/order/601');
        expect(sent?.queryParameters, isEmpty);
        if (scenario == 'success') {
          expect(result.getOrElse((e) => throw e).shipperId, 9);
        } else {
          expect(result.isLeft(), isTrue);
          final failure = result.fold((e) => e, (_) => null);
          if (scenario == 'timeout') expect(failure, isA<NetworkFailure>());
          if (scenario == '401') expect(failure, isA<UnauthorizedFailure>());
          if (['missing', 'rejected', '500'].contains(scenario)) {
            expect(failure, isA<ServerFailure>());
          }
          if (scenario == 'malformed') {
            expect(failure, isA<UnexpectedFailure>());
          }
        }
        dio.close();
      },
    );
  }
  test('tracking repository catches non-Exception errors', () async {
    final result = await DeliveryTrackingRepositoryImpl(
      _BrokenDelivery(),
    ).getCurrentDelivery(601);
    expect(result.fold((e) => e, (_) => null), isA<ServerFailure>());
  });

  test(
    'shipper tracking connects, subscribes, filters and unsubscribes',
    () async {
      final source = _LocationSource()..connected = false;
      final repository = ShipperLocationRepositoryImpl(source);
      expect(repository.isTracking, isFalse);
      final events = <ShipperLocationEntity>[];
      final subscription = repository.locationStream.listen(events.add);
      final location = ShipperLocationEntity(
        shipperId: 9,
        latitude: 10.77,
        longitude: 106.7,
        updatedAt: DateTime.utc(2026),
      );
      source.controller.add(location);
      await Future<void>.delayed(Duration.zero);
      expect(events, isEmpty);
      expect((await repository.startTrackingShipper(9, 1)).isRight(), isTrue);
      expect(source.subscribed, ['9', 1]);
      expect(source.connectCalls, 1);
      expect(repository.isTracking, isTrue);
      source.controller.add(location.copyWith(shipperId: 8));
      source.controller.add(location.copyWith(latitude: 91));
      source.controller.add(location.copyWith(longitude: 181));
      source.controller.add(location);
      await Future<void>.delayed(Duration.zero);
      expect(events, [location]);
      expect((await repository.stopTrackingShipper()).isRight(), isTrue);
      expect(source.unsubscribed, '9');
      expect(repository.isTracking, isFalse);
      expect((await repository.stopTrackingShipper()).isRight(), isTrue);
      await repository.startTrackingShipper(9, 1);
      repository.dispose();
      await Future<void>.delayed(Duration.zero);
      expect(repository.isTracking, isFalse);
      await subscription.cancel();
      await source.controller.close();
    },
  );

  for (final mode in [
    'connect-fails',
    'disconnects',
    'subscribe-throws',
    'unsubscribe-throws',
  ]) {
    test('shipper tracking reports $mode', () async {
      final source = _LocationSource()..mode = mode;
      if (mode == 'connect-fails') source.connected = false;
      final repository = ShipperLocationRepositoryImpl(source);
      final started = await repository.startTrackingShipper(9, 1);
      if (mode == 'unsubscribe-throws') {
        expect(started.isRight(), isTrue);
        expect(
          (await repository.stopTrackingShipper()).fold((e) => e, (_) => null),
          isA<ServerFailure>(),
        );
        expect(repository.isTracking, isTrue);
      } else {
        expect(
          started.fold((e) => e, (_) => null),
          mode == 'subscribe-throws'
              ? isA<ServerFailure>()
              : isA<NetworkFailure>(),
        );
        expect(repository.isTracking, isFalse);
      }
      await source.controller.close();
    });
  }
}

class _BrokenDelivery implements DeliveryTrackingRemoteDataSource {
  @override
  Future<BaseResponseDto<CurrentDeliveryDto>> getCurrentDelivery(
    int orderId,
  ) async => throw StateError('broken');
}

class _LocationSource implements ShipperLocationDataSource {
  final controller = StreamController<ShipperLocationEntity>.broadcast();
  bool connected = true;
  String mode = '';
  int connectCalls = 0;
  int connectionReads = 0;
  List<Object>? subscribed;
  String? unsubscribed;
  @override
  Stream<ShipperLocationEntity> get locationStream => controller.stream;
  @override
  Stream<bool> get connectionStream {
    connectionReads++;
    return Stream.value(
      mode == 'disconnects' && connectionReads > 1 ? false : connected,
    );
  }

  @override
  Future<bool> connect() async {
    connectCalls++;
    connected = mode != 'connect-fails';
    return connected;
  }

  @override
  Future<void> subscribeToShipper(String shipperId, int deliveryId) async {
    if (mode == 'subscribe-throws') throw StateError('subscribe');
    subscribed = [shipperId, deliveryId];
  }

  @override
  Future<void> unsubscribeFromShipper(String shipperId) async {
    if (mode == 'unsubscribe-throws') throw StateError('unsubscribe');
    unsubscribed = shipperId;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
