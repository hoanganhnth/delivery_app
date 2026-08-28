import 'package:delivery_app/features/entitlements/presentation/entitlement_status_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('shows a safe unavailable state before backend entitlement support exists', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: EntitlementStatusPage())));
    await tester.pumpAndSettle();

    expect(find.text('Entitlement unavailable'), findsOneWidget);
    expect(find.text('No local access has been granted.'), findsOneWidget);
  });
}
