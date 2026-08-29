import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('address ViewModels depend on the neutral session contract', () {
    for (final path in [
      'lib/features/user_address/application/address_list_view_model.dart',
      'lib/features/user_address/application/address_form_view_model.dart',
    ]) {
      final source = File(path).readAsStringSync();
      expect(source, isNot(contains('features/profile/application/')), reason: path);
      expect(source, contains('core/contracts/session_port_provider.dart'), reason: path);
    }
  });
}
