import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_livestreams_usecase.dart';
import 'livestream_state.dart';

/// Livestream list notifier
class LivestreamNotifier extends StateNotifier<LivestreamState> {
  final GetLivestreamsUseCase _getLivestreamsUseCase;
  final GetFeaturedLivestreamsUseCase _getFeaturedLivestreamsUseCase;

  LivestreamNotifier({
    required GetLivestreamsUseCase getLivestreamsUseCase,
    required GetFeaturedLivestreamsUseCase getFeaturedLivestreamsUseCase,
  })  : _getLivestreamsUseCase = getLivestreamsUseCase,
        _getFeaturedLivestreamsUseCase = getFeaturedLivestreamsUseCase,
        super(const LivestreamState());

  /// Load livestreams
  Future<void> loadLivestreams({bool refresh = false}) async {
    if (refresh) {
      state = const LivestreamState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, clearFailure: true);
    }

    final result = await _getLivestreamsUseCase(
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

    final result = await _getFeaturedLivestreamsUseCase(
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
