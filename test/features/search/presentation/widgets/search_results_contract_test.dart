import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('search results omit missing facts and keep canonical navigation', () {
    final source = [
      'lib/features/search/presentation/widgets/dish_search_results.dart',
      'lib/features/search/presentation/widgets/restaurant_search_results.dart',
    ].map((path) => File(path).readAsStringSync()).join('\n');

    expect(source, isNot(contains(r'?? 0.0')));
    expect(source, isNot(contains('Various cuisines')));
    expect(source, isNot(contains(r"Text('\$")));
    expect(source, isNot(contains('Navigate to')));
    expect(source, contains('pushToRestaurantDetails'));
    expect(source, contains("NumberFormat('#,###', 'vi_VN')"));
  });
}
