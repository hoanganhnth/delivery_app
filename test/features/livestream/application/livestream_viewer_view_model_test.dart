import 'package:delivery_app/features/livestream/application/livestream_viewer_view_model.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream_join_session.dart';
import 'package:delivery_app/features/livestream/domain/repositories/livestream_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
}

LivestreamJoinSession _session(String id) => LivestreamJoinSession(
  livestreamId: id,
  channelName: 'server-channel',
  token: 'server-token',
  uid: 501,
  expiresAt: DateTime.utc(2099),
  title: 'Live kitchen',
  restaurantId: 42,
);

final class _FakeRepository implements LivestreamRepository {
  int joinCount = 0;

  @override
  Future<LivestreamJoinSession> join(String livestreamId) async {
    joinCount++;
    return _session(livestreamId);
  }
}

final class _FailingRepository implements LivestreamRepository {
  @override
  Future<LivestreamJoinSession> join(String livestreamId) {
    return Future.error(const FormatException('bad response'));
  }
}

final class _FakeMediaPort implements LivestreamMediaPort {
  int joinCount = 0;
  int leaveCount = 0;

  @override
  Future<void> join(LivestreamJoinSession session) async => joinCount++;

  @override
  Future<void> leave() async => leaveCount++;
}
