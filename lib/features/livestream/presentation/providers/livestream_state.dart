import '../../../../core/error/failures.dart';
import '../../domain/entities/livestream_entity.dart';

/// Livestream list state
class LivestreamState {
  final bool isLoading;
  final List<LivestreamEntity> livestreams;
  final Failure? failure;
  final bool hasMore;
  final int currentPage;

  const LivestreamState({
    this.isLoading = false,
    this.livestreams = const [],
    this.failure,
    this.hasMore = true,
    this.currentPage = 1,
  });

  LivestreamState copyWith({
    bool? isLoading,
    List<LivestreamEntity>? livestreams,
    Failure? failure,
    bool? hasMore,
    int? currentPage,
    bool clearFailure = false,
  }) {
    return LivestreamState(
      isLoading: isLoading ?? this.isLoading,
      livestreams: livestreams ?? this.livestreams,
      failure: clearFailure ? null : (failure ?? this.failure),
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
}

/// Livestream detail state
class LivestreamDetailState {
  final bool isLoading;
  final LivestreamEntity? livestream;
  final Failure? failure;
  final int currentViewerCount;
  final int currentLikeCount;

  const LivestreamDetailState({
    this.isLoading = false,
    this.livestream,
    this.failure,
    this.currentViewerCount = 0,
    this.currentLikeCount = 0,
  });

  LivestreamDetailState copyWith({
    bool? isLoading,
    LivestreamEntity? livestream,
    Failure? failure,
    int? currentViewerCount,
    int? currentLikeCount,
    bool clearFailure = false,
  }) {
    return LivestreamDetailState(
      isLoading: isLoading ?? this.isLoading,
      livestream: livestream ?? this.livestream,
      failure: clearFailure ? null : (failure ?? this.failure),
      currentViewerCount: currentViewerCount ?? this.currentViewerCount,
      currentLikeCount: currentLikeCount ?? this.currentLikeCount,
    );
  }

  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  bool get hasLivestream => livestream != null;
}
