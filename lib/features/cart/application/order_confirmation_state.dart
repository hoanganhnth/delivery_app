import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:equatable/equatable.dart';

import 'order_confirmation_effect.dart';

final class OrderConfirmationViewState extends Equatable {
  const OrderConfirmationViewState({
    this.effects = const <UiEffectEnvelope<OrderConfirmationEffect>>[],
  });

  final List<UiEffectEnvelope<OrderConfirmationEffect>> effects;

  OrderConfirmationViewState copyWith({
    List<UiEffectEnvelope<OrderConfirmationEffect>>? effects,
  }) => OrderConfirmationViewState(effects: effects ?? this.effects);

  @override
  List<Object?> get props => [effects];
}
