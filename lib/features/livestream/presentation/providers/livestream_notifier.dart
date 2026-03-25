import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/usecases/get_livestreams_usecase.dart';
import 'livestream_providers.dart';
import 'livestream_state.dart';

part 'livestream_notifier.g.dart';

/// Livestream list notifier
@riverpod
class LivestreamNotifier extends _$LivestreamNotifier {
  @override
  LivestreamState build() {
    return const LivestreamState();
  }

  /// Load livestreams
  Future<void> loadLivestreams({bool refresh = false}) async {
    if (refresh) {
      state = const LivestreamState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, clearFailure: true);
    }

    final getLivestreamsUseCase = ref.read(getLivestreamsUseCaseProvider);
    final result = await getLivestreamsUseCase(
      GetLivestreamsParams(
        page: refresh ? 1 : state.currentPage,
        limit: 20,
        status: 'live',
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (livestreams) => state = state.copyWith(
        isLoading: false,
        livestreams: refresh ? livestreams : [...state.livestreams, ...livestreams],
        hasMore: livestreams.length >= 20,
        currentPage: refresh ? 2 : state.currentPage + 1,
      ),
    );
  }

  /// Load featured livestreams
  Future<void> loadFeaturedLivestreams() async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final getFeaturedLivestreamsUseCase = ref.read(getFeaturedLivestreamsUseCaseProvider);
    final result = await getFeaturedLivestreamsUseCase(
      GetFeaturedLivestreamsParams(limit: 10),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
      ),
      (livestreams) => state = state.copyWith(
        isLoading: false,
        livestreams: livestreams,
      ),
    );
  }
}
