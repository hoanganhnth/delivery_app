import 'package:delivery_app/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators.isEmailValid', () {
    test('accepts canonical plus-address fixtures and long TLDs', () {
      expect(
        Validators.isEmailValid('customer+20260726212530@test.dev'),
        isTrue,
      );
      expect(Validators.isEmailValid('owner@example.technology'), isTrue);
    });

    test('rejects missing local part, domain, or dot suffix', () {
      expect(Validators.isEmailValid('@test.dev'), isFalse);
      expect(Validators.isEmailValid('customer@'), isFalse);
      expect(Validators.isEmailValid('customer@test'), isFalse);
    });
  });
}
