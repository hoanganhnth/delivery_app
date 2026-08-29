import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('checkout gateways use the core authenticated network port', () {
    for (final path in [
      'lib/features/cart/di/checkout_providers.dart',
      'lib/features/cart/di/checkout_preview_provider.dart',
    ]) {
      final source = File(path).readAsStringSync();
      expect(source, isNot(contains('features/auth/di/')),
          reason: path);
      expect(source, contains('core/network/_riverpod/'), reason: path);
    }
  });
}
