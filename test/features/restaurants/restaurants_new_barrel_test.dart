import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('legacy restaurant barrel exports only existing modules', () {
    final source = File('lib/features/restaurants/restaurants_new.dart')
        .readAsStringSync();
    expect(source, isNot(contains("presentation/screens/all_restaurants_screen.dart")));
    expect(source, isNot(contains("presentation/screens/restaurant_detail_screen.dart")));
  });
}
