import 'package:delivery_app/core/presentation/mvvm/mvvm.dart';
import 'package:delivery_app/core/contracts/cart_port_provider.dart';
import 'package:delivery_app/features/orders/application/order_reorder_builder.dart';
import 'package:delivery_app/features/orders/application/restaurant_rating_submission.dart';
import 'package:delivery_app/features/orders/di/restaurant_rating_submission_provider.dart';
import 'package:delivery_app/features/orders/domain/entities/delivery_status.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:delivery_app/features/orders/application/state/tracking/delivery_tracking_notifier.dart';
import 'package:delivery_app/features/orders/application/state/tracking/delivery_tracking_state.dart';
import 'package:delivery_app/features/orders/application/state/orders/order_detail_notifier.dart';
import 'package:delivery_app/features/orders/application/state/orders/orders_list_notifier.dart';
import 'package:delivery_app/features/orders/di/order_providers.dart';
import 'package:delivery_app/features/orders/di/refund_status_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_detail_effect.dart';
import 'order_detail_intent.dart';
import 'order_detail_state.dart';

final orderDetailViewModelProvider = NotifierProvider.autoDispose
    .family<OrderDetailViewModel, OrderDetailViewState, int>(
      OrderDetailViewModel.new,
    );

/// Owns the order-detail read model and every customer-initiated operation.
///
/// The historical Riverpod providers remain data adapters during the migration;
/// the page only renders this state and forwards typed intents.
class OrderDetailViewModel extends Notifier<OrderDetailViewState> {
  OrderDetailViewModel(this._orderId);

  final int _orderId;
  late AsyncValue<OrderEntity?> _orderSource;
  late AsyncValue<RefundCaseEntity?> _refundSource;
  late DeliveryTrackingState _trackingSource;
  int _nextEffectId = 0;

  @override
  OrderDetailViewState build() {
    _orderSource = ref.read(orderDetailProvider(_orderId));
    _refundSource = ref.read(customerRefundForOrderProvider(_orderId));
    _trackingSource = ref.read(deliveryTrackingProvider);

    ref.listen<AsyncValue<OrderEntity?>>(orderDetailProvider(_orderId), (
      _,
      next,
    ) {
      _orderSource = next;
      if (ref.mounted) _publish();
    });
    ref.listen<AsyncValue<RefundCaseEntity?>>(
      customerRefundForOrderProvider(_orderId),
      (_, next) {
        _refundSource = next;
        if (ref.mounted) _publish();
      },
    );
    ref.listen<DeliveryTrackingState>(deliveryTrackingProvider, (
      previous,
      next,
    ) {
      _trackingSource = next;
      _refreshOrdersAfterTerminalTracking(previous, next);
      if (ref.mounted) _publish();
    });

    return _fromSources();
  }

  /// Rating submission returns an error message directly for the modal's
  /// local, presentational retry state. Other intents report through effects.
  Future<String?> dispatch(OrderDetailIntent intent) async {
    switch (intent) {
      case OrderDetailBackRequested():
        _emit(const OrderDetailNavigateBack());
      case OrderDetailRefreshRequested() || OrderDetailRetryRequested():
        await _refresh();
      case OrderDetailRefundRetryRequested():
        await _refreshRefundStatus();
      case OrderDetailCancelRequested():
        _requestCancellation();
      case OrderDetailCancelConfirmed(:final reason):
        await _cancel(reason);
      case OrderDetailReorderRequested():
        await _reorder();
      case OrderDetailRatingRequested():
        _requestRating();
      case OrderDetailRatingSubmitted(:final rating, :final comment):
        return _submitRating(rating: rating, comment: comment);
      case OrderDetailEffectConsumed(:final effectId):
        state = state.copyWith(
          effects: consumeUiEffect(state.effects, effectId),
        );
    }
    return null;
  }

  Future<void> _refresh() async {
    ref.invalidate(orderDetailProvider(_orderId));
    ref.invalidate(customerRefundCasesProvider);
    ref.invalidate(customerRefundForOrderProvider(_orderId));
    try {
      await ref.read(orderDetailProvider(_orderId).future);
    } catch (_) {
      // The provider error remains the retry surface in state.
    }
  }

  Future<void> _refreshRefundStatus() async {
    ref.invalidate(customerRefundCasesProvider);
    ref.invalidate(customerRefundForOrderProvider(_orderId));
    try {
      await ref.read(customerRefundForOrderProvider(_orderId).future);
    } catch (_) {
      // A failed refund lookup never replaces a usable order detail.
    }
  }

  void _requestCancellation() {
    final order = state.order;
    if (order == null || !order.canCancel || state.isActionInProgress) return;
    _emit(const OrderDetailConfirmCancellation());
  }

  Future<void> _cancel(String reason) async {
    final order = state.order;
    final orderId = order?.id;
    if (order == null ||
        orderId == null ||
        !order.canCancel ||
        state.isActionInProgress) {
      return;
    }

    state = state.copyWith(activeAction: OrderDetailAction.cancel);
    try {
      final result = await ref
          .read(cancelOrderUseCaseProvider)
          .call(orderId, reason.trim().isEmpty ? null : reason.trim());
      if (!ref.mounted) return;
      result.fold((failure) => _emit(OrderDetailShowMessage(failure.message)), (
        cancelled,
      ) {
        if (!cancelled) {
          _emit(const OrderDetailShowMessage('Không thể hủy đơn hàng.'));
          return;
        }
        ref.invalidate(orderDetailProvider(_orderId));
        ref.invalidate(customerRefundCasesProvider);
        ref.invalidate(customerRefundForOrderProvider(_orderId));
        ref.invalidate(ordersListProvider);
        _emit(
          const OrderDetailShowMessage(
            'Đã hủy đơn hàng thành công.',
            isSuccess: true,
          ),
        );
      });
    } catch (_) {
      if (ref.mounted) {
        _emit(const OrderDetailShowMessage('Không thể hủy đơn hàng.'));
      }
    } finally {
      if (ref.mounted) state = state.copyWith(clearActiveAction: true);
    }
  }

  Future<void> _reorder() async {
    final order = state.order;
    if (order == null ||
        order.canTrackingRealtime ||
        state.isActionInProgress) {
      return;
    }

    state = state.copyWith(activeAction: OrderDetailAction.reorder);
    try {
      final items = buildReorderCartItems(order);
      final cart = ref.read(cartCommandsPortProvider);
      await cart.clear();
      for (final item in items) {
        await cart.addLine(item);
      }
      if (ref.mounted) _emit(const OrderDetailNavigateToCart());
    } on FormatException {
      if (ref.mounted) {
        _emit(const OrderDetailShowMessage('Không thể đặt lại đơn này.'));
      }
    } catch (_) {
      if (ref.mounted) {
        _emit(const OrderDetailShowMessage('Không thể đặt lại đơn này.'));
      }
    } finally {
      if (ref.mounted) state = state.copyWith(clearActiveAction: true);
    }
  }

  void _requestRating() {
    final order = state.order;
    final orderId = order?.id;
    final restaurantId = order?.restaurantId;
    if (order == null ||
        order.status != OrderStatus.delivered ||
        orderId == null ||
        restaurantId == null ||
        restaurantId <= 0 ||
        state.isActionInProgress) {
      if (order != null && !state.isActionInProgress) {
        _emit(
          const OrderDetailShowMessage(
            'Không thể xác định nhà hàng cần đánh giá.',
          ),
        );
      }
      return;
    }
    _emit(
      OrderDetailOpenRestaurantRating(
        orderId: orderId,
        restaurantId: restaurantId,
        restaurantName: order.restaurantName?.trim().isNotEmpty == true
            ? order.restaurantName!.trim()
            : 'Nhà hàng',
      ),
    );
  }

  Future<String?> _submitRating({
    required int rating,
    required String comment,
  }) async {
    final order = state.order;
    final orderId = order?.id;
    final restaurantId = order?.restaurantId;
    if (order == null ||
        order.status != OrderStatus.delivered ||
        orderId == null ||
        restaurantId == null ||
        restaurantId <= 0) {
      return 'Không thể xác định đơn hàng cần đánh giá.';
    }
    if (rating < 1 || rating > 5) return 'Điểm đánh giá phải từ 1 đến 5.';
    if (state.isActionInProgress) return 'Đánh giá đang được gửi.';

    state = state.copyWith(activeAction: OrderDetailAction.rating);
    try {
      await ref
          .read(restaurantRatingSubmissionProvider)
          .submit(
            restaurantId: restaurantId,
            submission: RestaurantRatingSubmission(
              orderId: orderId,
              rating: rating,
              comment: comment.trim(),
            ),
          );
      if (!ref.mounted) return 'Đánh giá chưa được gửi. Vui lòng thử lại.';
      _emit(
        const OrderDetailShowMessage(
          'Cảm ơn bạn đã đánh giá! Đánh giá sẽ được hiển thị sau khi được kiểm duyệt.',
          isSuccess: true,
        ),
      );
      return null;
    } catch (error) {
      return 'Đánh giá thất bại: $error';
    } finally {
      if (ref.mounted) state = state.copyWith(clearActiveAction: true);
    }
  }

  void _refreshOrdersAfterTerminalTracking(
    DeliveryTrackingState? previous,
    DeliveryTrackingState next,
  ) {
    final current = next.currentTracking;
    if (current == null || current.orderId != _orderId) return;
    final previousStatus = previous?.currentTracking?.status;
    final isCompleted = current.status == DeliveryStatus.delivered;
    final isCancelled = current.status == DeliveryStatus.cancelled;
    if (previousStatus != current.status && (isCompleted || isCancelled)) {
      ref.invalidate(ordersListProvider);
    }
  }

  void _publish() {
    final refreshed = _fromSources(
      effects: state.effects,
    ).copyWith(activeAction: state.activeAction);
    state = refreshed;
  }

  OrderDetailViewState _fromSources({
    List<UiEffectEnvelope<OrderDetailEffect>> effects = const [],
  }) {
    final order = _orderSource.hasValue ? _orderSource.value : null;
    final tracking = _trackingSource.currentTracking;
    final trackingRawStatus = tracking?.orderId == _orderId
        ? tracking!.status.value
        : order?.rawBackendStatus;
    return OrderDetailViewState(
      order: order,
      isLoading: _orderSource.isLoading,
      hasError: _orderSource.hasError,
      refundCase: _refundSource.hasValue ? _refundSource.value : null,
      isRefundLoading: _refundSource.isLoading,
      hasRefundError: _refundSource.hasError,
      trackingRawStatus: trackingRawStatus,
      effects: effects,
    );
  }

  void _emit(OrderDetailEffect effect) {
    state = state.copyWith(
      effects: [
        ...state.effects,
        UiEffectEnvelope(id: _nextEffectId++, effect: effect),
      ],
    );
  }
}
