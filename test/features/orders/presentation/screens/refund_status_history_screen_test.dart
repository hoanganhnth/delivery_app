import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:delivery_app/features/orders/presentation/providers/refund_status_providers.dart';
import 'package:delivery_app/features/orders/presentation/screens/refund_status_history_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/app_harness.dart';

void main() {
  testWidgets('shows the customer refund history with an order reference', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      overrides: [
        customerRefundStatusPortProvider.overrideWithValue(
          _FakeRefundStatusPort([
            RefundCaseEntity(
              refundId: 'refund-101',
              orderId: 101,
              paymentMethod: 'ONLINE',
              trigger: 'ORDER_CANCELLED',
              status: RefundCaseStatus.succeeded,
              currency: 'VND',
              refundAmount: 120000,
              createdAt: DateTime(2026, 8, 2, 10),
            ),
          ]),
        ),
      ],
      child: const RefundStatusHistoryScreen(),
    );
    await tester.pumpAndSettle();

    expect(find.text('Lịch sử hoàn tiền'), findsOneWidget);
    expect(find.text('Đơn #101'), findsOneWidget);
    expect(find.text('Hoàn tiền thành công'), findsOneWidget);
    expect(find.textContaining('Yêu cầu hoàn tiền'), findsNothing);
  });

  testWidgets('explains when no refund case exists', (tester) async {
    await pumpTestApp(
      tester,
      overrides: [
        customerRefundStatusPortProvider.overrideWithValue(
          const _FakeRefundStatusPort([]),
        ),
      ],
      child: const RefundStatusHistoryScreen(),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chưa có yêu cầu hoàn tiền.'), findsOneWidget);
  });
}

class _FakeRefundStatusPort implements CustomerRefundStatusPort {
  const _FakeRefundStatusPort(this.cases);

  final List<RefundCaseEntity> cases;

  @override
  Future<List<RefundCaseEntity>> getMyRefundCases({int limit = 50}) async =>
      cases;
}
