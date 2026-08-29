import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('login page does not orchestrate profile loading', () {
    final source = File(
      'lib/features/auth/presentation/pages/login_page.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('features/profile/')));
  });
}
