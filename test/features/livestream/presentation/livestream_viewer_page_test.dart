import 'package:delivery_app/features/livestream/application/livestream_viewer_view_model.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream_join_session.dart';
import 'package:delivery_app/features/livestream/domain/repositories/livestream_repository.dart';
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

  testWidgets('shows the Agora SDK blocker instead of fake playback', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          livestreamEnabledProvider.overrideWithValue(true),
          livestreamRepositoryProvider.overrideWithValue(_FakeRepository()),
          livestreamMediaPortProvider.overrideWithValue(
            const UnsupportedLivestreamMediaPort(),
          ),
        ],
        child: const MaterialApp(
          home: LivestreamViewerPage(
            livestreamId: '00000000-0000-4000-8000-000000000001',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Phát livestream tạm thời chưa khả dụng (Agora RTC chưa được tích hợp trong ứng dụng)',
      ),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.videocam_off_outlined), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

final class _FakeRepository implements LivestreamRepository {
  @override
  Future<LivestreamJoinSession> join(String livestreamId) async =>
      LivestreamJoinSession(
        livestreamId: livestreamId,
        channelName: 'server-channel',
        token: 'server-token',
        uid: 501,
        expiresAt: DateTime.utc(2099),
        title: 'Live kitchen',
        restaurantId: 42,
      );
}
