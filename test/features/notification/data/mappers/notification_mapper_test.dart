import 'package:delivery_app/features/notification/data/dtos/notification_dto.dart';
import 'package:delivery_app/features/notification/data/mappers/notification_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  NotificationDto validDto({
    int? id = 1,
    int? userId = 2,
    String? title = 'Đơn đang giao',
    String? message = 'Shipper đang giao đơn của bạn',
    String? type = 'DELIVERY_DELIVERING',
    String? priority = 'MEDIUM',
    String? status = 'SENT',
    bool? isRead = false,
    String? createdAt = '2026-07-26T10:30:00',
  }) {
    return NotificationDto(
      id: id,
      userId: userId,
      title: title,
      message: message,
      type: type,
      priority: priority,
      status: status,
      isRead: isRead,
      createdAt: createdAt,
    );
  }

  test('maps a complete canonical notification', () {
    final entity = validDto().toEntityStrict();

    expect(entity.id, 1);
    expect(entity.userId, 2);
    expect(entity.priority, 'MEDIUM');
    expect(entity.status, 'SENT');
    expect(entity.createdAt, DateTime(2026, 7, 26, 10, 30));
  });

  test('rejects fabricated identity and timestamp fallbacks', () {
    expect(() => validDto(id: null).toEntityStrict(), throwsFormatException);
    expect(() => validDto(userId: 0).toEntityStrict(), throwsFormatException);
    expect(
      () => validDto(createdAt: null).toEntityStrict(),
      throwsFormatException,
    );
    expect(
      () => validDto(createdAt: 'not-a-date').toEntityStrict(),
      throwsFormatException,
    );
  });

  test('rejects blank content and unknown priority or status', () {
    expect(() => validDto(title: ' ').toEntityStrict(), throwsFormatException);
    expect(
      () => validDto(priority: 'NORMAL').toEntityStrict(),
      throwsFormatException,
    );
    expect(
      () => validDto(status: 'UNKNOWN').toEntityStrict(),
      throwsFormatException,
    );
  });
}
