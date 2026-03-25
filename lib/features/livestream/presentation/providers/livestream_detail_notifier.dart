import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/livestream_comment_entity.dart';
import '../../domain/usecases/get_livestreams_usecase.dart';
import '../../domain/usecases/livestream_interaction_usecases.dart';
import 'livestream_providers.dart';
import 'livestream_state.dart';

part 'livestream_detail_notifier.g.dart';

/// Livestream detail notifier
@riverpod
class LivestreamDetail extends _$LivestreamDetail {
  StreamSubscription? _commentsSubscription;
  StreamSubscription? _likesSubscription;

  @override
  LivestreamDetailState build(num id) {
    // start loading details immediately upon build
    Future.microtask(() => loadLivestreamDetail(id));
    
    // cleanup on dispose
    ref.onDispose(() {
      _commentsSubscription?.cancel();
      _likesSubscription?.cancel();
    });

    return const LivestreamDetailState();
  }

  /// Load livestream detail
  Future<void> loadLivestreamDetail(num id) async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final getLivestreamByIdUseCase = ref.read(getLivestreamByIdUseCaseProvider);
    final result = await getLivestreamByIdUseCase(
      GetLivestreamByIdParams(id: id),
    );

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
        
        // Start streaming comments and likes
        _startStreamingComments(id);
        _startStreamingLikes(id);
      },
    );
  }

  /// Start streaming comments from Firebase
  void _startStreamingComments(num livestreamId) {
    _commentsSubscription?.cancel();
    
    final streamCommentsUseCase = ref.read(streamCommentsUseCaseProvider);
    final commentsStream = streamCommentsUseCase(
      StreamCommentsParams(livestreamId: livestreamId),
    );

    _commentsSubscription = commentsStream.listen((either) {
      // Comments are handled separately in LivestreamInteractionNotifier
    });
  }

  /// Start streaming likes from Firebase
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
          // Update like count
          state = state.copyWith(
            currentLikeCount: likes.length,
          );
        },
      );
    });
  }

  /// Update viewer count
  void updateViewerCount(int count) {
    state = state.copyWith(currentViewerCount: count);
  }
}

/// Livestream interaction state
class LivestreamInteractionState {
  final List<LivestreamCommentEntity> comments;
  final List<LivestreamLikeEntity> recentLikes;
  final bool isSendingComment;
  final bool isSendingLike;

  const LivestreamInteractionState({
    this.comments = const [],
    this.recentLikes = const [],
    this.isSendingComment = false,
    this.isSendingLike = false,
  });

  LivestreamInteractionState copyWith({
    List<LivestreamCommentEntity>? comments,
    List<LivestreamLikeEntity>? recentLikes,
    bool? isSendingComment,
    bool? isSendingLike,
  }) {
    return LivestreamInteractionState(
      comments: comments ?? this.comments,
      recentLikes: recentLikes ?? this.recentLikes,
      isSendingComment: isSendingComment ?? this.isSendingComment,
      isSendingLike: isSendingLike ?? this.isSendingLike,
    );
  }
}

/// Livestream interaction notifier
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

    result.fold(
      (failure) {
        state = state.copyWith(isSendingComment: false);
      },
      (_) {
        state = state.copyWith(isSendingComment: false);
      },
    );
  }

  /// Send like
  Future<void> sendLike(LivestreamLikeEntity like) async {
    state = state.copyWith(isSendingLike: true);

    final sendLikeUseCase = ref.read(sendLikeUseCaseProvider);
    final result = await sendLikeUseCase(
      SendLikeParams(like: like),
    );

    result.fold(
      (failure) {
        state = state.copyWith(isSendingLike: false);
      },
      (_) {
        state = state.copyWith(isSendingLike: false);
      },
    );
  }
}
