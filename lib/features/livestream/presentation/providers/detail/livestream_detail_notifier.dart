import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/usecases/get_livestreams_usecase.dart';
import '../../../domain/usecases/livestream_interaction_usecases.dart';
import '../di/livestream_di_providers.dart';
import 'livestream_detail_state.dart';

part 'livestream_detail_notifier.g.dart';

/// Livestream detail notifier — manages livestream metadata
@riverpod
class LivestreamDetail extends _$LivestreamDetail {
  StreamSubscription? _likesSubscription;

  @override
  LivestreamDetailState build(String id) {
    ref.onDispose(() {
      _likesSubscription?.cancel();
    });

    return const LivestreamDetailState();
  }

  /// Load livestream detail
  Future<void> loadLivestreamDetail(String id) async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final getLivestreamByIdUseCase = ref.read(getLivestreamByIdUseCaseProvider);
    final result = await getLivestreamByIdUseCase(
      GetLivestreamByIdParams(id: id),
    );
    if (!ref.mounted) return;

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (livestream) {
        state = state.copyWith(
          isLoading: false,
          livestream: livestream,
          currentViewerCount: livestream.viewerCount,
          currentLikeCount: livestream.likeCount,
        );

        // Start streaming likes for count updates
        _startStreamingLikes(id);
      },
    );
  }

  /// Stream likes from Firebase for count updates
  void _startStreamingLikes(String livestreamId) {
    _likesSubscription?.cancel();

    final streamLikesUseCase = ref.read(streamLikesUseCaseProvider);
    final likesStream = streamLikesUseCase(
      StreamLikesParams(livestreamId: livestreamId),
    );

    _likesSubscription = likesStream.listen((either) {
      either.fold(
        (failure) {},
        (likes) {
          if (!ref.mounted) return;
          state = state.copyWith(currentLikeCount: likes.length);
        },
      );
    });
  }

  /// Update viewer count
  void updateViewerCount(int count) {
    state = state.copyWith(currentViewerCount: count);
  }
}
