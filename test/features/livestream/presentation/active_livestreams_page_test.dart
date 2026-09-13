import 'package:delivery_app/features/livestream/application/livestream_viewer_view_model.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream_join_session.dart';
import 'package:delivery_app/features/livestream/domain/repositories/livestream_repository.dart';
import 'package:delivery_app/features/livestream/presentation/active_livestreams_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../support/app_harness.dart';

void main() {
  testWidgets('shows active server rooms and opens the returned UUID', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/livestreams',
      routes: [
        GoRoute(
          path: '/livestreams',
          builder: (_, _) => const ActiveLivestreamsPage(),
        ),
        GoRoute(
          path: '/livestreams/:livestreamId',
          builder: (_, state) => Scaffold(
            body: Text('VIEWER ${state.pathParameters['livestreamId']}'),
          ),
        ),
      ],
    );
    addTearDown(router.dispose);

    await pumpTestRouter(
      tester,
      router: router,
      overrides: [
        livestreamEnabledProvider.overrideWithValue(true),
        livestreamRepositoryProvider.overrideWithValue(_Repository()),
      ],
    );
    await tester.pumpAndSettle();

    expect(find.text('Bếp đang live'), findsOneWidget);
    expect(find.text('ĐANG LIVE'), findsOneWidget);
    expect(find.byKey(const Key('active-livestream-list')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('livestream-$_id')));
    await tester.pumpAndSettle();

    expect(find.text('VIEWER $_id'), findsOneWidget);
  });
}

const _id = '00000000-0000-4000-8000-000000000001';

final class _Repository implements LivestreamRepository {
  @override
  Future<List<Livestream>> getActive() async => const [
    Livestream(
      id: _id,
      sellerId: 7,
      restaurantId: 42,
      title: 'Bếp đang live',
      status: LivestreamStatus.live,
      streamProvider: LivestreamProvider.agora,
      roomId: 'room-live',
      channelName: 'channel-live',
      viewCount: 12,
    ),
  ];

  @override
  Future<LivestreamJoinSession> join(String livestreamId) =>
      throw UnimplementedError();

  @override
  Future<String> renewToken(LivestreamJoinSession session) =>
      throw UnimplementedError();
}
