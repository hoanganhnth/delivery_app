import 'package:delivery_app/core/design_system/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('customer theme follows web mobile brand and neutral surfaces', () {
    expect(LightColors().primary, const Color(0xFFEE4D2D));
    expect(LightColors().background, const Color(0xFFF5F5F5));
    expect(LightColors().border, const Color(0xFFEEEEEE));
    expect(DarkColors().primary, const Color(0xFFFF8066));
  });
}
