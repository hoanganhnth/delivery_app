import 'package:delivery_app/features/orders/application/refund_history_intent.dart';
import 'package:delivery_app/features/orders/application/refund_history_state.dart';
import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:delivery_app/features/orders/presentation/views/refund_history_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('refund history view emits only typed navigation intents', (
    tester,
  ) async {
    final intents = <RefundHistoryIntent>[];
    await pumpTestApp(
      tester,
      child: RefundHistoryView(
        state: RefundHistoryViewState(isLoading: false, cases: [_refundCase()]),
        onIntent: intents.add,
      ),
    );

    await tester.tap(find.byTooltip('Quay lại'));
    await tester.tap(find.text('Trạng thái hoàn tiền'));

    expect(intents[0], isA<RefundHistoryBackRequested>());
    expect((intents[1] as RefundHistoryOrderRequested).orderId, 101);
  });
}

RefundCaseEntity _refundCase() => RefundCaseEntity(
  refundId: 'refund-101',
  orderId: 101,
  paymentMethod: 'ONLINE',
  trigger: 'ORDER_CANCELLED',
  status: RefundCaseStatus.succeeded,
  currency: 'VND',
  refundAmount: 120000,
  createdAt: DateTime(2026, 8, 2, 10),
);
