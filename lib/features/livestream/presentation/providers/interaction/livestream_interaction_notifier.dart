import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/livestream_comment_entity.dart';
import '../../../domain/usecases/livestream_interaction_usecases.dart';
import '../di/livestream_di_providers.dart';
import 'livestream_interaction_state.dart';

part 'livestream_interaction_notifier.g.dart';

/// Livestream interaction notifier — manages comments and likes via Firebase
@riverpod
class LivestreamInteraction extends _$LivestreamInteraction {
  StreamSubscription? _commentsSubscription;
  StreamSubscription? _likesSubscription;

  @override
  LivestreamInteractionState build(num id) {
    Future.microtask(() => startStreaming(id));

    ref.onDispose(() {
      _commentsSubscription?.cancel();
      _likesSubscription?.cancel();
    });

    return const LivestreamInteractionState();
  }

  /// Start streaming interactions
  void startStreaming(num livestreamId) {
    _startStreamingComments(livestreamId);
    _startStreamingLikes(livestreamId);
  }

  void _startStreamingComments(num livestreamId) {
    _commentsSubscription?.cancel();

    final streamCommentsUseCase = ref.read(streamCommentsUseCaseProvider);
    final commentsStream = streamCommentsUseCase(
      StreamCommentsParams(livestreamId: livestreamId),
    );

    _commentsSubscription = commentsStream.listen((either) {
      either.fold(
        (failure) {},
        (comments) {
          if (!ref.mounted) return;
          state = state.copyWith(comments: comments);
        },
      );
    });
  }

  void _startStreamingLikes(num livestreamId) {
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
          // Keep only recent 20 likes for animation
          state = state.copyWith(
            recentLikes: likes.take(20).toList(),
          );
        },
      );
    });
  }

  /// Send comment
  Future<void> sendComment(LivestreamCommentEntity comment) async {
    state = state.copyWith(isSendingComment: true);

    final sendCommentUseCase = ref.read(sendCommentUseCaseProvider);
    final result = await sendCommentUseCase(
      SendCommentParams(comment: comment),
    );
    if (!ref.mounted) return;

    result.fold(
      (failure) => state = state.copyWith(isSendingComment: false),
      (_) => state = state.copyWith(isSendingComment: false),
    );
  }

  /// Send like
  Future<void> sendLike(LivestreamLikeEntity like) async {
    state = state.copyWith(isSendingLike: true);

    final sendLikeUseCase = ref.read(sendLikeUseCaseProvider);
    final result = await sendLikeUseCase(
      SendLikeParams(like: like),
    );
    if (!ref.mounted) return;

    result.fold(
      (failure) => state = state.copyWith(isSendingLike: false),
      (_) => state = state.copyWith(isSendingLike: false),
    );
  }
}
