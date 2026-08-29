import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('livestream application does not import auth implementation', () {
    final source = File(
      'lib/features/livestream/application/livestream_viewer_view_model.dart',
    ).readAsStringSync();

    expect(
      source,
      isNot(contains('features/auth/di/auth_network_providers.dart')),
    );
  });
}
