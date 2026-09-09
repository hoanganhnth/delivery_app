import 'package:delivery_app/features/splash/application/splash_intent.dart';
import 'package:delivery_app/features/splash/application/splash_state.dart';
import 'package:delivery_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets(
    'splash view displays the compact native identity while loading',
    (tester) async {
      await pumpTestApp(
        tester,
        child: SplashView(state: const SplashViewState(), onIntent: (_) {}),
      );

      expect(find.byIcon(Icons.restaurant), findsOneWidget);
      expect(find.text('Delivery'), findsOneWidget);
      expect(find.text('URBAN HEARTH'), findsNothing);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets('splash view exposes retry as a typed intent', (tester) async {
    final intents = <SplashIntent>[];
    await pumpTestApp(
      tester,
      child: SplashView(
        state: const SplashViewState(phase: SplashPhase.error),
        onIntent: intents.add,
      ),
    );

    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    await tester.tap(find.text('Retry'));
    expect(intents.single, isA<SplashRetryRequested>());
  });
}
