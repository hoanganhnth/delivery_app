import 'dart:async';

import 'package:delivery_app/features/livestream/application/livestream_viewer_view_model.dart';
import 'package:delivery_app/features/livestream/application/livestream_media_port.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream_join_session.dart';
import 'package:delivery_app/features/livestream/domain/repositories/livestream_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  const id = '00000000-0000-4000-8000-000000000001';

  test(
    'disabled capability does not attempt a media or repository join',
    () async {
      final repository = _FakeRepository();
      final media = _FakeMediaPort();
      final container = ProviderContainer(
        overrides: [
          livestreamEnabledProvider.overrideWithValue(false),
          livestreamRepositoryProvider.overrideWithValue(repository),
          livestreamMediaPortProvider.overrideWithValue(media),
        ],
      );
      addTearDown(container.dispose);

      await container.read(livestreamViewerProvider(id).notifier).join();

      expect(
        container.read(livestreamViewerProvider(id)).phase,
        LivestreamViewerPhase.disabled,
      );
      expect(repository.joinCount, 0);
      expect(media.joinCount, 0);
    },
  );

  test(
    'media SDK absence is exposed as recoverable mediaUnavailable state',
    () async {
      final container = ProviderContainer(
        overrides: [
          livestreamEnabledProvider.overrideWithValue(true),
          livestreamRepositoryProvider.overrideWithValue(_FakeRepository()),
          livestreamMediaPortProvider.overrideWithValue(
            const UnsupportedLivestreamMediaPort(),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(livestreamViewerProvider(id).notifier).join();

      final state = container.read(livestreamViewerProvider(id));
      expect(state.phase, LivestreamViewerPhase.mediaUnavailable);
      expect(state.session?.channelName, 'server-channel');
      expect(state.message, 'Phát livestream tạm thời chưa khả dụng');
    },
  );

  test('disposing the viewer leaves the media session', () async {
    final media = _FakeMediaPort();
    final container = ProviderContainer(
      overrides: [
        livestreamEnabledProvider.overrideWithValue(true),
        livestreamRepositoryProvider.overrideWithValue(_FakeRepository()),
        livestreamMediaPortProvider.overrideWithValue(media),
      ],
    );

    await container.read(livestreamViewerProvider(id).notifier).join();
    expect(media.joinCount, 1);
    container.dispose();
    await Future<void>.delayed(Duration.zero);

    expect(media.leaveCount, 1);
  });

  test(
    'successful media join exposes the joined phase and server session',
    () async {
      final container = ProviderContainer(
        overrides: [
          livestreamEnabledProvider.overrideWithValue(true),
          livestreamRepositoryProvider.overrideWithValue(_FakeRepository()),
          livestreamMediaPortProvider.overrideWithValue(_FakeMediaPort()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(livestreamViewerProvider(id).notifier).join();

      final state = container.read(livestreamViewerProvider(id));
      expect(state.phase, LivestreamViewerPhase.joined);
      expect(state.session?.livestreamId, id);
      expect(state.session?.token, 'server-token');
      expect(state.room?.pinnedProducts.single.productName, 'Món live');
    },
  );

  test(
    'media token renewal is delegated to the authenticated repository',
    () async {
      final repository = _FakeRepository();
      final media = _FakeMediaPort();
      final container = ProviderContainer(
        overrides: [
          livestreamEnabledProvider.overrideWithValue(true),
          livestreamRepositoryProvider.overrideWithValue(repository),
          livestreamMediaPortProvider.overrideWithValue(media),
        ],
      );
      addTearDown(container.dispose);

      await container.read(livestreamViewerProvider(id).notifier).join();
      await expectLater(
        media.renewToken!(),
        completion('renewed-server-token'),
      );

      expect(repository.renewCount, 1);
      expect(repository.renewedSession?.livestreamId, id);
    },
  );

  test('repository format failures become retryable error state', () async {
    final container = ProviderContainer(
      overrides: [
        livestreamEnabledProvider.overrideWithValue(true),
        livestreamRepositoryProvider.overrideWithValue(_FailingRepository()),
        livestreamMediaPortProvider.overrideWithValue(_FakeMediaPort()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(livestreamViewerProvider(id).notifier).join();

    final state = container.read(livestreamViewerProvider(id));
    expect(state.phase, LivestreamViewerPhase.error);
    expect(state.message, 'Livestream data is unavailable');
  });

  test('a late older join cannot replace the newest viewer request', () async {
    final repository = _SequencedJoinRepository();
    final media = _SessionCapturingMediaPort();
    final container = ProviderContainer(
      overrides: [
        livestreamEnabledProvider.overrideWithValue(true),
        livestreamRepositoryProvider.overrideWithValue(repository),
        livestreamMediaPortProvider.overrideWithValue(media),
      ],
    );
    addTearDown(container.dispose);

    final older = container.read(livestreamViewerProvider(id).notifier).join();
    await Future<void>.delayed(Duration.zero);
    await container.read(livestreamViewerProvider(id).notifier).join();
    repository.first.complete(_session(id, channel: 'older-channel'));
    await older;

    expect(media.joinedChannels, ['newer-channel']);
    expect(
      container.read(livestreamViewerProvider(id)).session?.channelName,
      'newer-channel',
    );
  });
}

LivestreamJoinSession _session(
  String id, {
  String channel = 'server-channel',
}) => LivestreamJoinSession(
  livestreamId: id,
  channelName: channel,
  token: 'server-token',
  uid: 501,
  expiresAt: DateTime.utc(2099),
  title: 'Live kitchen',
  restaurantId: 42,
);

final class _FakeRepository implements LivestreamRepository {
  int joinCount = 0;
  int renewCount = 0;
  LivestreamJoinSession? renewedSession;

  @override
  Future<List<Livestream>> getActive() async => const [];

  @override
  Future<Livestream> getById(String livestreamId) async => _room(livestreamId);

  @override
  Future<LivestreamJoinSession> join(String livestreamId) async {
    joinCount++;
    return _session(livestreamId);
  }

  @override
  Future<String> renewToken(LivestreamJoinSession session) async {
    renewCount++;
    renewedSession = session;
    return 'renewed-server-token';
  }
}

final class _FailingRepository implements LivestreamRepository {
  @override
  Future<List<Livestream>> getActive() =>
      Future.error(const FormatException('bad response'));

  @override
  Future<Livestream> getById(String livestreamId) =>
      Future.error(const FormatException('bad response'));

  @override
  Future<LivestreamJoinSession> join(String livestreamId) {
    return Future.error(const FormatException('bad response'));
  }

  @override
  Future<String> renewToken(LivestreamJoinSession session) =>
      Future.error(const FormatException('bad renewal'));
}

final class _FakeMediaPort implements LivestreamMediaPort {
  int joinCount = 0;
  int leaveCount = 0;
  Future<String> Function()? renewToken;

  @override
  Future<void> join(
    LivestreamJoinSession session, {
    required Future<String> Function() renewToken,
  }) async {
    joinCount++;
    this.renewToken = renewToken;
  }

  @override
  Future<void> leave() async => leaveCount++;

  @override
  Widget buildVideoView() => const SizedBox.shrink();
}

final class _SequencedJoinRepository implements LivestreamRepository {
  final first = Completer<LivestreamJoinSession>();
  var calls = 0;

  @override
  Future<List<Livestream>> getActive() async => const [];

  @override
  Future<Livestream> getById(String livestreamId) async => _room(livestreamId);

  @override
  Future<LivestreamJoinSession> join(String livestreamId) {
    calls++;
    return calls == 1
        ? first.future
        : Future.value(_session(livestreamId, channel: 'newer-channel'));
  }

  @override
  Future<String> renewToken(LivestreamJoinSession session) async =>
      'renewed-server-token';
}

Livestream _room(String id) => Livestream(
  id: id,
  sellerId: 7,
  restaurantId: 42,
  title: 'Live kitchen',
  status: LivestreamStatus.live,
  streamProvider: LivestreamProvider.agora,
  pinnedProducts: [
    LivestreamProduct(
      id: 91,
      livestreamId: id,
      productId: 501,
      productName: 'Món live',
      restaurantId: 42,
      restaurantName: 'Live kitchen',
      priceAtLive: 42000,
      isPinned: true,
    ),
  ],
);

final class _SessionCapturingMediaPort implements LivestreamMediaPort {
  final joinedChannels = <String>[];

  @override
  Widget buildVideoView() => const SizedBox.shrink();

  @override
  Future<void> join(
    LivestreamJoinSession session, {
    required Future<String> Function() renewToken,
  }) async => joinedChannels.add(session.channelName);

  @override
  Future<void> leave() async {}
}
