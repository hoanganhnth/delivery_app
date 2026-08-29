import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('catalog search composition does not import the legacy search feature', () {
    final source = File(
      'lib/features/catalog/di/catalog_search_providers.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('features/search/')));
    expect(source, contains('core/network/_riverpod/network_providers.dart'));
  });
}
