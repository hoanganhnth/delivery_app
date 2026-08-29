import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('catalog ViewModels depend on the neutral catalog browse port', () {
    for (final path in [
      'lib/features/catalog/application/catalog_home_view_model.dart',
      'lib/features/catalog/application/catalog_all_restaurants_view_model.dart',
      'lib/features/catalog/application/catalog_restaurant_detail_view_model.dart',
    ]) {
      final source = File(path).readAsStringSync();
      expect(source, isNot(contains('features/restaurants/')), reason: path);
      expect(source, contains('core/contracts/catalog_contract.dart'), reason: path);
    }
  });
}
