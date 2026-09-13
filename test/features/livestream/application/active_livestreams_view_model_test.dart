import 'dart:async';

import 'package:delivery_app/features/livestream/application/active_livestreams_view_model.dart';
import 'package:delivery_app/features/livestream/application/livestream_viewer_view_model.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream.dart';
import 'package:delivery_app/features/livestream/domain/entities/livestream_join_session.dart';
import 'package:delivery_app/features/livestream/domain/repositories/livestream_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('disabled capability does not request active rooms', () async {
    final repository = _ActiveRepository();
    final container = ProviderContainer(
      overrides: [
        livestreamEnabledProvider.overrideWithValue(false),
        livestreamRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await container.read(activeLivestreamsProvider.notifier).load();

    expect(
      container.read(activeLivestreamsProvider).phase,
      ActiveLivestreamsPhase.disabled,
    );
    expect(repository.loadCount, 0);
  });

  test('exposes server rooms and supports a fresh retry', () async {
    final repository = _ActiveRepository();
    final container = ProviderContainer(
      overrides: [
        livestreamEnabledProvider.overrideWithValue(true),
        livestreamRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await container.read(activeLivestreamsProvider.notifier).load();
    final state = container.read(activeLivestreamsProvider);

    expect(state.phase, ActiveLivestreamsPhase.ready);
    expect(state.rooms.single.id, _id);
    expect(repository.loadCount, 1);
  });

  test('a late older request cannot replace a newer active list', () async {
    final first = Completer<List<Livestream>>();
    final repository = _SequencedRepository(first);
    final container = ProviderContainer(
      overrides: [
        livestreamEnabledProvider.overrideWithValue(true),
        livestreamRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    final older = container.read(activeLivestreamsProvider.notifier).load();
    await container.read(activeLivestreamsProvider.notifier).load();
    first.complete([_room(title: 'Kết quả cũ')]);
    await older;

    expect(
      container.read(activeLivestreamsProvider).rooms.single.title,
      'Kết quả mới',
    );
  });
}

const _id = '00000000-0000-4000-8000-000000000001';

Livestream _room({String title = 'Bếp đang live'}) => Livestream(
  id: _id,
  sellerId: 7,
  restaurantId: 42,
  title: title,
  status: LivestreamStatus.live,
  streamProvider: LivestreamProvider.agora,
  roomId: 'room-live',
  channelName: 'channel-live',
  viewCount: 12,
);

class _ActiveRepository implements LivestreamRepository {
  int loadCount = 0;

  @override
  Future<List<Livestream>> getActive() async {
    loadCount++;
    return [_room()];
  }

  @override
  Future<LivestreamJoinSession> join(String livestreamId) =>
      throw UnimplementedError();

  @override
  Future<String> renewToken(LivestreamJoinSession session) =>
      throw UnimplementedError();
}

final class _SequencedRepository implements LivestreamRepository {
  _SequencedRepository(this.first);

  final Completer<List<Livestream>> first;
  var calls = 0;

  @override
  Future<List<Livestream>> getActive() {
    calls++;
    if (calls == 1) return first.future;
    return Future.value([_room(title: 'Kết quả mới')]);
  }

  @override
  Future<LivestreamJoinSession> join(String livestreamId) =>
      throw UnimplementedError();

  @override
  Future<String> renewToken(LivestreamJoinSession session) =>
      throw UnimplementedError();
}
