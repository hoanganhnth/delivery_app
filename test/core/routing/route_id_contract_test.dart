import 'package:delivery_app/core/routing/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dynamic routes accept positive integer IDs only', () {
    expect(parsePositiveRouteId('42'), 42);
    expect(parsePositiveRouteId(null), isNull);
    expect(parsePositiveRouteId(''), isNull);
    expect(parsePositiveRouteId('0'), isNull);
    expect(parsePositiveRouteId('-1'), isNull);
    expect(parsePositiveRouteId('1.5'), isNull);
    expect(parsePositiveRouteId('abc'), isNull);
  });
}
