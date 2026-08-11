import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:equatable/equatable.dart';

import 'refund_history_effect.dart';

final class RefundHistoryViewState extends Equatable {
  const RefundHistoryViewState({
    this.cases = const [],
    this.isLoading = true,
    this.hasError = false,
    this.effects = const <UiEffectEnvelope<RefundHistoryEffect>>[],
  });

  final List<RefundCaseEntity> cases;
  final bool isLoading;
  final bool hasError;
  final List<UiEffectEnvelope<RefundHistoryEffect>> effects;

  bool get isEmpty => !isLoading && !hasError && cases.isEmpty;

  RefundHistoryViewState copyWith({
    List<RefundCaseEntity>? cases,
    bool? isLoading,
    bool? hasError,
    List<UiEffectEnvelope<RefundHistoryEffect>>? effects,
  }) => RefundHistoryViewState(
    cases: cases ?? this.cases,
    isLoading: isLoading ?? this.isLoading,
    hasError: hasError ?? this.hasError,
    effects: effects ?? this.effects,
  );

  @override
  List<Object?> get props => [cases, isLoading, hasError, effects];
}
