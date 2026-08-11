import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:delivery_app/features/orders/di/refund_status_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'refund_history_effect.dart';
import 'refund_history_intent.dart';
import 'refund_history_state.dart';

final refundHistoryViewModelProvider =
    NotifierProvider.autoDispose<
      RefundHistoryViewModel,
      RefundHistoryViewState
    >(RefundHistoryViewModel.new);

class RefundHistoryViewModel extends Notifier<RefundHistoryViewState> {
  int _nextEffectId = 0;

  @override
  RefundHistoryViewState build() {
    final initial = ref.read(customerRefundCasesProvider);
    ref.listen<AsyncValue<List<RefundCaseEntity>>>(
      customerRefundCasesProvider,
      (_, next) {
        if (ref.mounted) state = _fromSource(next, effects: state.effects);
      },
    );
    return _fromSource(initial);
  }

  Future<void> dispatch(RefundHistoryIntent intent) async {
    switch (intent) {
      case RefundHistoryBackRequested():
        _emit(const RefundHistoryNavigateBack());
      case RefundHistoryRefreshRequested() || RefundHistoryRetryRequested():
        await _refresh();
      case RefundHistoryOrderRequested(:final orderId):
        if (orderId > 0) _emit(RefundHistoryNavigateToOrder(orderId));
      case RefundHistoryEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  Future<void> _refresh() async {
    ref.invalidate(customerRefundCasesProvider);
    try {
      await ref.read(customerRefundCasesProvider.future);
    } catch (_) {
      // The provider's error is rendered as an in-page retry state.
    }
  }

  RefundHistoryViewState _fromSource(
    AsyncValue<List<RefundCaseEntity>> source, {
    List<UiEffectEnvelope<RefundHistoryEffect>> effects = const [],
  }) => source.when(
    loading: () => RefundHistoryViewState(isLoading: true, effects: effects),
    error: (_, _) => RefundHistoryViewState(
      isLoading: false,
      hasError: true,
      effects: effects,
    ),
    data: (cases) => RefundHistoryViewState(
      cases: List.unmodifiable(cases),
      isLoading: false,
      effects: effects,
    ),
  );

  void _emit(RefundHistoryEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
