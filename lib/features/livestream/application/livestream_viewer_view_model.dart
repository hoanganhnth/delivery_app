import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';

import '../data/livestream_gateway.dart';
import '../data/livestream_repository_impl.dart';
import '../domain/entities/livestream_join_session.dart';
import '../domain/repositories/livestream_repository.dart';
import '../domain/usecases/join_livestream_use_case.dart';

abstract interface class LivestreamMediaPort {
  Future<void> join(LivestreamJoinSession session);
  Future<void> leave();
}

final class UnsupportedLivestreamMediaPort implements LivestreamMediaPort {
  const UnsupportedLivestreamMediaPort();
  @override
  Future<void> join(LivestreamJoinSession session) =>
      Future.error(const LivestreamMediaUnavailableException());
  @override
  Future<void> leave() async {}
}

final class LivestreamMediaUnavailableException implements Exception {
  const LivestreamMediaUnavailableException();
}

enum LivestreamViewerPhase { disabled, idle, loading, mediaUnavailable, error }

final class LivestreamViewerState {
  const LivestreamViewerState({
    this.phase = LivestreamViewerPhase.idle,
    this.session,
    this.message,
  });
  final LivestreamViewerPhase phase;
  final LivestreamJoinSession? session;
  final String? message;
}

final livestreamRepositoryProvider = Provider<LivestreamRepository>(
  (ref) => LivestreamRepositoryImpl(
    LivestreamGateway(ref.watch(authenticatedDioProvider)),
  ),
);
final joinLivestreamUseCaseProvider = Provider<JoinLivestreamUseCase>(
  (ref) => JoinLivestreamUseCase(ref.watch(livestreamRepositoryProvider)),
);
final livestreamMediaPortProvider = Provider<LivestreamMediaPort>(
  (ref) => const UnsupportedLivestreamMediaPort(),
);
final livestreamEnabledProvider = Provider<bool>(
  (ref) => RuntimeConfig.livestreamViewerEnabled,
);

final livestreamViewerProvider =
    NotifierProvider.family<
      LivestreamViewerViewModel,
      LivestreamViewerState,
      String
    >((livestreamId) => LivestreamViewerViewModel(livestreamId));

class LivestreamViewerViewModel extends Notifier<LivestreamViewerState> {
  LivestreamViewerViewModel(this._livestreamId);

  final String _livestreamId;
  bool _disposed = false;
  @override
  LivestreamViewerState build() {
    final media = ref.read(livestreamMediaPortProvider);
    ref.onDispose(() {
      _disposed = true;
      unawaited(media.leave());
    });
    return ref.read(livestreamEnabledProvider)
        ? const LivestreamViewerState()
        : const LivestreamViewerState(phase: LivestreamViewerPhase.disabled);
  }

  Future<void> join() async {
    if (!ref.read(livestreamEnabledProvider)) return;
    state = const LivestreamViewerState(phase: LivestreamViewerPhase.loading);
    try {
      final session = await ref.read(joinLivestreamUseCaseProvider)(
        _livestreamId,
      );
      if (_disposed) return;
      try {
        await ref.read(livestreamMediaPortProvider).join(session);
        if (!_disposed) state = LivestreamViewerState(session: session);
      } on LivestreamMediaUnavailableException {
        if (!_disposed) {
          state = LivestreamViewerState(
            phase: LivestreamViewerPhase.mediaUnavailable,
            session: session,
          );
        }
      }
    } on FormatException catch (_) {
      if (!_disposed) {
        state = const LivestreamViewerState(
          phase: LivestreamViewerPhase.error,
          message: 'Livestream data is unavailable',
        );
      }
    } catch (_) {
      if (!_disposed) {
        state = const LivestreamViewerState(
          phase: LivestreamViewerPhase.error,
          message: 'Unable to join livestream',
        );
      }
    }
  }
}
