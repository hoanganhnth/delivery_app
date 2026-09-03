import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Plus Jakarta Sans used weights and OFL are bundled', () {
    const root = 'assets/fonts/plus_jakarta_sans';
    const assets = <String, int>{
      '$root/PlusJakartaSans-Regular.ttf': 400,
      '$root/PlusJakartaSans-Medium.ttf': 500,
      '$root/PlusJakartaSans-SemiBold.ttf': 600,
      '$root/PlusJakartaSans-Bold.ttf': 700,
      '$root/PlusJakartaSans-ExtraBold.ttf': 800,
    };

    final pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('family: Plus Jakarta Sans'));
    for (final MapEntry(key: asset, value: weight) in assets.entries) {
      expect(File(asset).existsSync(), isTrue, reason: 'missing $asset');
      expect(pubspec, contains('asset: $asset'));
      expect(pubspec, contains('weight: $weight'));
    }

    final license = File('$root/OFL.txt');
    expect(license.existsSync(), isTrue);
    expect(license.readAsStringSync(), contains('SIL OPEN FONT LICENSE'));
  });
}
