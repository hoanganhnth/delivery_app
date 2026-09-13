import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/livestream.dart';
import 'livestream_viewer_view_model.dart';

enum ActiveLivestreamsPhase { disabled, idle, loading, ready, error }

final class ActiveLivestreamsState {
  const ActiveLivestreamsState({
    this.phase = ActiveLivestreamsPhase.idle,
    this.rooms = const [],
    this.message,
  });

  final ActiveLivestreamsPhase phase;
  final List<Livestream> rooms;
  final String? message;
}

final activeLivestreamsProvider =
    NotifierProvider<ActiveLivestreamsViewModel, ActiveLivestreamsState>(
      ActiveLivestreamsViewModel.new,
    );

class ActiveLivestreamsViewModel extends Notifier<ActiveLivestreamsState> {
  var _requestGeneration = 0;

  @override
  ActiveLivestreamsState build() {
    ref.onDispose(() => _requestGeneration++);
    return ref.read(livestreamEnabledProvider)
        ? const ActiveLivestreamsState()
        : const ActiveLivestreamsState(phase: ActiveLivestreamsPhase.disabled);
  }

  Future<void> load() async {
    if (!ref.read(livestreamEnabledProvider)) return;
    final generation = ++_requestGeneration;
    state = const ActiveLivestreamsState(phase: ActiveLivestreamsPhase.loading);
    try {
      final rooms = await ref.read(livestreamRepositoryProvider).getActive();
      if (generation != _requestGeneration) return;
      state = ActiveLivestreamsState(
        phase: ActiveLivestreamsPhase.ready,
        rooms: rooms,
      );
    } on FormatException catch (_) {
      if (generation != _requestGeneration) return;
      state = const ActiveLivestreamsState(
        phase: ActiveLivestreamsPhase.error,
        message: 'Dữ liệu livestream không hợp lệ',
      );
    } catch (_) {
      if (generation != _requestGeneration) return;
      state = const ActiveLivestreamsState(
        phase: ActiveLivestreamsPhase.error,
        message: 'Không thể tải livestream đang phát',
      );
    }
  }
}
