import 'package:delivery_app/features/support/presentation/support_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('fails closed when Firebase has not been initialized', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SupportPage())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Support unavailable'), findsOneWidget);
    expect(find.text('Please try again later.'), findsOneWidget);
  });
}
