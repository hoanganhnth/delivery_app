import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';

import '../data/livestream_gateway.dart';
import '../data/livestream_repository_impl.dart';
import 'livestream_media_port.dart';
import '../domain/entities/livestream.dart';
import '../domain/entities/livestream_join_session.dart';
import '../domain/repositories/livestream_repository.dart';
import '../domain/usecases/join_livestream_use_case.dart';
import '../platform/agora_livestream_media_port.dart';

enum LivestreamViewerPhase {
  disabled,
  idle,
  loading,
  joined,
  mediaUnavailable,
  error,
}

final class LivestreamViewerState {
  const LivestreamViewerState({
    this.phase = LivestreamViewerPhase.idle,
    this.room,
    this.session,
    this.message,
  });
  final LivestreamViewerPhase phase;
  final Livestream? room;
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
  (ref) => AgoraLivestreamMediaPort(appId: RuntimeConfig.agoraAppId),
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
  var _joinGeneration = 0;
  @override
  LivestreamViewerState build() {
    final media = ref.read(livestreamMediaPortProvider);
    ref.onDispose(() {
      _disposed = true;
      _joinGeneration++;
      unawaited(media.leave());
    });
    return ref.read(livestreamEnabledProvider)
        ? const LivestreamViewerState()
        : const LivestreamViewerState(phase: LivestreamViewerPhase.disabled);
  }

  Future<void> join() async {
    if (!ref.read(livestreamEnabledProvider)) return;
    final generation = ++_joinGeneration;
    state = const LivestreamViewerState(phase: LivestreamViewerPhase.loading);
    try {
      final repository = ref.read(livestreamRepositoryProvider);
      final room = await repository.getById(_livestreamId);
      if (_disposed || generation != _joinGeneration) return;
      if (room.status != LivestreamStatus.live) {
        throw const FormatException('Livestream is not live');
      }
      final session = await ref.read(joinLivestreamUseCaseProvider)(
        _livestreamId,
      );
      if (_disposed || generation != _joinGeneration) return;
      if (session.restaurantId != room.restaurantId) {
        throw const FormatException('Mismatched livestream restaurant');
      }
      try {
        await ref
            .read(livestreamMediaPortProvider)
            .join(session, renewToken: () => repository.renewToken(session));
        if (!_disposed && generation == _joinGeneration) {
          state = LivestreamViewerState(
            phase: LivestreamViewerPhase.joined,
            room: room,
            session: session,
          );
        }
      } on LivestreamMediaUnavailableException catch (error) {
        if (!_disposed && generation == _joinGeneration) {
          state = LivestreamViewerState(
            phase: LivestreamViewerPhase.mediaUnavailable,
            room: room,
            session: session,
            message: error.message,
          );
        }
      }
    } on FormatException catch (_) {
      if (!_disposed && generation == _joinGeneration) {
        state = const LivestreamViewerState(
          phase: LivestreamViewerPhase.error,
          message: 'Livestream data is unavailable',
        );
      }
    } catch (_) {
      if (!_disposed && generation == _joinGeneration) {
        state = const LivestreamViewerState(
          phase: LivestreamViewerPhase.error,
          message: 'Unable to join livestream',
        );
      }
    }
  }
}
