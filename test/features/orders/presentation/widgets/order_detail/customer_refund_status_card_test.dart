import 'package:delivery_app/features/orders/domain/entities/refund_case_entity.dart';
import 'package:delivery_app/features/orders/presentation/providers/refund_status_providers.dart';
import 'package:delivery_app/features/orders/presentation/widgets/order_detail/customer_refund_status_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../support/app_harness.dart';

void main() {
  testWidgets('shows manual-review status for the matching order only', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      overrides: [
        customerRefundStatusPortProvider.overrideWithValue(
          _FakeRefundStatusPort([
            _refundCase(orderId: 101, status: RefundCaseStatus.manualReview),
            _refundCase(orderId: 202, status: RefundCaseStatus.succeeded),
          ]),
        ),
      ],
      child: const CustomerRefundStatusCard(orderId: 101),
    );
    await tester.pumpAndSettle();

    expect(find.text('Trạng thái hoàn tiền'), findsOneWidget);
    expect(find.text('Đang được kiểm tra'), findsOneWidget);
    expect(find.textContaining('120.000'), findsOneWidget);
    expect(find.textContaining('₫'), findsOneWidget);
    expect(find.text('Hoàn tiền thành công'), findsNothing);
  });

  testWidgets('stays hidden when the order has no refund case', (tester) async {
    await pumpTestApp(
      tester,
      overrides: [
        customerRefundStatusPortProvider.overrideWithValue(
          _FakeRefundStatusPort([_refundCase(orderId: 202)]),
        ),
      ],
      child: const CustomerRefundStatusCard(orderId: 101),
    );
    await tester.pumpAndSettle();

    expect(find.text('Trạng thái hoàn tiền'), findsNothing);
  });

  testWidgets('shows a retry state without exposing a refund action', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      overrides: [
        customerRefundStatusPortProvider.overrideWithValue(
          _FailingRefundStatusPort(),
        ),
      ],
      child: const CustomerRefundStatusCard(orderId: 101),
    );
    await tester.pumpAndSettle();

    expect(find.text('Không thể tải trạng thái hoàn tiền.'), findsOneWidget);
    expect(find.text('Thử lại'), findsOneWidget);
    expect(find.textContaining('Yêu cầu hoàn tiền'), findsNothing);
  });
}

class _FakeRefundStatusPort implements CustomerRefundStatusPort {
  const _FakeRefundStatusPort(this.cases);

  final List<RefundCaseEntity> cases;

  @override
  Future<List<RefundCaseEntity>> getMyRefundCases({int limit = 50}) async =>
      cases;
}

class _FailingRefundStatusPort implements CustomerRefundStatusPort {
  @override
  Future<List<RefundCaseEntity>> getMyRefundCases({int limit = 50}) {
    throw StateError('network unavailable');
  }
}

RefundCaseEntity _refundCase({
  required int orderId,
  RefundCaseStatus status = RefundCaseStatus.manualReview,
}) {
  return RefundCaseEntity(
    refundId: 'refund-$orderId',
    orderId: orderId,
    paymentMethod: 'ONLINE',
    trigger: 'ORDER_CANCELLED',
    status: status,
    currency: 'VND',
    refundAmount: 120000,
    createdAt: DateTime(2026, 8, 2, 10),
  );
}
