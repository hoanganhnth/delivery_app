import 'package:delivery_app/core/network/resources/page_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses the canonical stable page envelope', () {
    final page = PageDto<int>.fromJson(
      {
        'items': [11, 12],
        'page': 0,
        'size': 20,
        'totalItems': 2,
        'totalPages': 1,
        'hasNext': false,
      },
      (value) => value as int,
    );

    expect(page.items, [11, 12]);
    expect(page.totalItems, 2);
    expect(page.hasNext, isFalse);
  });

  test('rejects the legacy Spring Page serialization', () {
    expect(
      () => PageDto<int>.fromJson(
        {
          'content': <int>[],
          'number': 0,
          'size': 20,
          'totalElements': 0,
          'totalPages': 0,
        },
        (value) => value as int,
      ),
      throwsA(anything),
    );
  });
}
