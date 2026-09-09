import 'package:delivery_app/features/livestream/application/livestream_viewer_view_model.dart';
import 'package:delivery_app/features/livestream/presentation/livestream_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'disabled livestream keeps native header without simulated engagement',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [livestreamEnabledProvider.overrideWithValue(false)],
          child: const MaterialApp(
            home: LivestreamViewerPage(livestreamId: 'disabled'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Livestream hiện không khả dụng'), findsOneWidget);
      expect(find.text('LIVE'), findsNothing);
      expect(find.text('188'), findsNothing);
      expect(find.byType(AppBar), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
