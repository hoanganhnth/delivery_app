import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/usecases/get_livestreams_usecase.dart';
import '../di/livestream_di_providers.dart';
import 'livestream_list_state.dart';

part 'livestream_list_notifier.g.dart';

/// Livestream list notifier
@riverpod
class LivestreamList extends _$LivestreamList {
  @override
  LivestreamListState build() {
    return const LivestreamListState();
  }

  /// Load livestreams
  Future<void> loadLivestreams({bool refresh = false}) async {
    if (refresh) {
      state = const LivestreamListState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, clearFailure: true);
    }

    final getFeaturedLivestreamsUseCase = ref.read(
      getFeaturedLivestreamsUseCaseProvider,
    );
    final result = await getFeaturedLivestreamsUseCase(
      GetFeaturedLivestreamsParams(
        limit: refresh ? 20 : state.livestreams.length + 20,
      ),
    );
    if (!ref.mounted) return;

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (livestreams) => state = state.copyWith(
        isLoading: false,
        livestreams: livestreams,
        hasMore:
            false, // Active endpoint doesn't support traditional pagination
        currentPage: 1,
      ),
    );
  }

  /// Load featured livestreams
  Future<void> loadFeaturedLivestreams() async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final getFeaturedLivestreamsUseCase = ref.read(
      getFeaturedLivestreamsUseCaseProvider,
    );
    final result = await getFeaturedLivestreamsUseCase(
      GetFeaturedLivestreamsParams(limit: 10),
    );
    if (!ref.mounted) return;

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (livestreams) =>
          state = state.copyWith(isLoading: false, livestreams: livestreams),
    );
  }
}
