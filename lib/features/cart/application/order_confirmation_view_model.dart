import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_confirmation_effect.dart';
import 'order_confirmation_intent.dart';
import 'order_confirmation_state.dart';

final orderConfirmationViewModelProvider =
    NotifierProvider.autoDispose<
      OrderConfirmationViewModel,
      OrderConfirmationViewState
    >(OrderConfirmationViewModel.new);

class OrderConfirmationViewModel extends Notifier<OrderConfirmationViewState> {
  int _nextEffectId = 0;

  @override
  OrderConfirmationViewState build() => const OrderConfirmationViewState();

  void dispatch(OrderConfirmationIntent intent) {
    switch (intent) {
      case OrderConfirmationTrackingRequested():
        _emit(const OrderConfirmationNavigateToOrders());
      case OrderConfirmationEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
  }

  void _emit(OrderConfirmationEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
