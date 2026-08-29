import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('notification ViewModel depends only on neutral session contracts', () {
    final source = File(
      'lib/features/notification/application/notification_view_model.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('features/profile/application/')));
    expect(source, isNot(contains('features/auth/')));
    expect(source, contains('core/contracts/session_port_provider.dart'));
  });
}
