import '../../../../../core/error/failures.dart';
import '../../../domain/entities/livestream_entity.dart';

/// Livestream detail state — metadata about the livestream
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
