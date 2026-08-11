import 'package:equatable/equatable.dart';

sealed class RefundHistoryEffect extends Equatable {
  const RefundHistoryEffect();
}

final class RefundHistoryNavigateBack extends RefundHistoryEffect {
  const RefundHistoryNavigateBack();

  @override
  List<Object?> get props => const [];
}

final class RefundHistoryNavigateToOrder extends RefundHistoryEffect {
  const RefundHistoryNavigateToOrder(this.orderId);

  final int orderId;

  @override
  List<Object?> get props => [orderId];
}
