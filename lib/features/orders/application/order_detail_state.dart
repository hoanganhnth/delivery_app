import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:equatable/equatable.dart';

import 'order_detail_effect.dart';

enum OrderDetailAction { cancel, reorder, rating }

final class OrderDetailViewState extends Equatable {
  const OrderDetailViewState({
    this.order,
    this.isLoading = true,
    this.hasError = false,
    this.refundCase,
    this.isRefundLoading = true,
    this.hasRefundError = false,
    this.trackingRawStatus,
    this.activeAction,
    this.effects = const <UiEffectEnvelope<OrderDetailEffect>>[],
  });

  final OrderEntity? order;
  final bool isLoading;
  final bool hasError;
  final RefundCaseEntity? refundCase;
  final bool isRefundLoading;
  final bool hasRefundError;
  final String? trackingRawStatus;
  final OrderDetailAction? activeAction;
  final List<UiEffectEnvelope<OrderDetailEffect>> effects;

  bool get isActionInProgress => activeAction != null;

  OrderDetailViewState copyWith({
    OrderEntity? order,
    bool clearOrder = false,
    bool? isLoading,
    bool? hasError,
    RefundCaseEntity? refundCase,
    bool clearRefundCase = false,
    bool? isRefundLoading,
    bool? hasRefundError,
    String? trackingRawStatus,
    bool clearTrackingRawStatus = false,
    OrderDetailAction? activeAction,
    bool clearActiveAction = false,
    List<UiEffectEnvelope<OrderDetailEffect>>? effects,
  }) => OrderDetailViewState(
    order: clearOrder ? null : (order ?? this.order),
    isLoading: isLoading ?? this.isLoading,
    hasError: hasError ?? this.hasError,
    refundCase: clearRefundCase ? null : (refundCase ?? this.refundCase),
    isRefundLoading: isRefundLoading ?? this.isRefundLoading,
    hasRefundError: hasRefundError ?? this.hasRefundError,
    trackingRawStatus: clearTrackingRawStatus
        ? null
        : (trackingRawStatus ?? this.trackingRawStatus),
    activeAction: clearActiveAction
        ? null
        : (activeAction ?? this.activeAction),
    effects: effects ?? this.effects,
  );

  @override
  List<Object?> get props => [
    order,
    isLoading,
    hasError,
    refundCase,
    isRefundLoading,
    hasRefundError,
    trackingRawStatus,
    activeAction,
    effects,
  ];
}
