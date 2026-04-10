import '../../../../../core/error/failures.dart';
import '../../../domain/entities/livestream_entity.dart';

/// Livestream list state
class LivestreamListState {
  final bool isLoading;
  final List<LivestreamEntity> livestreams;
  final Failure? failure;
  final bool hasMore;
  final int currentPage;

  const LivestreamListState({
    this.isLoading = false,
    this.livestreams = const [],
    this.failure,
    this.hasMore = true,
    this.currentPage = 1,
  });

  LivestreamListState copyWith({
    bool? isLoading,
    List<LivestreamEntity>? livestreams,
    Failure? failure,
    bool? hasMore,
    int? currentPage,
    bool clearFailure = false,
  }) {
    return LivestreamListState(
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
