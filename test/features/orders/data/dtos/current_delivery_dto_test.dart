import 'package:delivery_app/features/orders/data/dtos/current_delivery_dto.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, Object?> validPayload({
    Object? id = 100,
    Object? orderId = 200,
    Object? status = 'ASSIGNED',
    Object? pickupAddress = '1 Nguyễn Huệ',
    Object? pickupLat = 10.775,
    Object? pickupLng = 106.7,
    Object? deliveryAddress = '2 Lê Lợi',
    Object? deliveryLat = 10.78,
    Object? deliveryLng = 106.69,
  }) {
    return {
      'id': id,
      'orderId': orderId,
      'shipperId': 42,
      'status': status,
      'pickupAddress': pickupAddress,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'deliveryAddress': deliveryAddress,
      'deliveryLat': deliveryLat,
      'deliveryLng': deliveryLng,
    };
  }

  test('preserves backend delivery id for location authorization', () {
    final dto = CurrentDeliveryDto.fromJson(validPayload());

    final entity = dto.toEntity();
    expect(entity.id, 100);
    expect(entity.orderId, 200);
    expect(entity.shipperId, 42);
  });

  test('maps every canonical backend delivery status', () {
    const statuses = {
      'PENDING': DeliveryStatus.pending,
      'FINDING_SHIPPER': DeliveryStatus.findingShipper,
      'WAIT_SHIPPER_CONFIRM': DeliveryStatus.waitShipperConfirm,
      'SHIPPER_NOT_FOUND': DeliveryStatus.shipperNotFound,
      'ASSIGNED': DeliveryStatus.assigned,
      'PICKED_UP': DeliveryStatus.pickedUp,
      'DELIVERING': DeliveryStatus.delivering,
      'DELIVERED': DeliveryStatus.delivered,
      'CANCELLED': DeliveryStatus.cancelled,
    };

    for (final entry in statuses.entries) {
      final entity = CurrentDeliveryDto.fromJson(
        validPayload(status: entry.key),
      ).toEntity();
      expect(entity.status, entry.value);
    }
  });

  test('rejects missing identity and unknown status instead of defaulting', () {
    expect(
      () => CurrentDeliveryDto.fromJson(validPayload(id: null)).toEntity(),
      throwsFormatException,
    );
    expect(
      () => CurrentDeliveryDto.fromJson(
        validPayload(status: 'NEW_UNKNOWN_STATUS'),
      ).toEntity(),
      throwsFormatException,
    );
  });

  test('rejects blank addresses and coordinates outside Vietnam', () {
    expect(
      () => CurrentDeliveryDto.fromJson(
        validPayload(pickupAddress: '  '),
      ).toEntity(),
      throwsFormatException,
    );
    expect(
      () => CurrentDeliveryDto.fromJson(
        validPayload(deliveryLat: 0.0, deliveryLng: 0.0),
      ).toEntity(),
      throwsFormatException,
    );
  });
}
