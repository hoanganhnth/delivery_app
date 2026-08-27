import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:delivery_app/features/payments/domain/entities/payment_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const expectedReturn = 'delivery://payments/vnpay-return';

  test('provider success refreshes canonical success exactly once', () async {
    final refresher = _RecordingRefresher(
      const PaymentOrder(
        paymentRef: 'PAY-123',
        status: PaymentStatus.succeeded,
      ),
    );
    final coordinator = PaymentReturnCoordinator(
      expectedReturnUrl: Uri.parse(expectedReturn),
      statusRefresher: refresher,
    );

    final outcome = await coordinator.handleDeepLink(
      Uri.parse('$expectedReturn?vnp_TxnRef=PAY-123&vnp_ResponseCode=00'),
    );

    expect(outcome, const PaymentReturnOutcome.succeeded('PAY-123'));
    expect(refresher.references, ['PAY-123']);
  });

  test(
    'provider cancellation is not treated as a success before refresh',
    () async {
      final refresher = _RecordingRefresher(
        const PaymentOrder(paymentRef: 'PAY-124', status: PaymentStatus.failed),
      );
      final coordinator = PaymentReturnCoordinator(
        expectedReturnUrl: Uri.parse(expectedReturn),
        statusRefresher: refresher,
      );

      final outcome = await coordinator.handleWebViewNavigation(
        Uri.parse('$expectedReturn?vnp_TxnRef=PAY-124&vnp_ResponseCode=24'),
      );

      expect(outcome, const PaymentReturnOutcome.failed('PAY-124'));
      expect(refresher.references, ['PAY-124']);
    },
  );

  test('duplicate callback does not refresh canonical status twice', () async {
    final refresher = _RecordingRefresher(
      const PaymentOrder(
        paymentRef: 'PAY-125',
        status: PaymentStatus.succeeded,
      ),
    );
    final coordinator = PaymentReturnCoordinator(
      expectedReturnUrl: Uri.parse(expectedReturn),
      statusRefresher: refresher,
    );
    final callback = Uri.parse(
      '$expectedReturn?vnp_TxnRef=PAY-125&vnp_ResponseCode=00',
    );

    await coordinator.handleDeepLink(callback);
    final duplicate = await coordinator.handleWebViewNavigation(callback);

    expect(duplicate, const PaymentReturnOutcome.duplicate());
    expect(refresher.references, ['PAY-125']);
  });

  test('WebView and app-link callbacks share terminal state', () async {
    final refresher = _RecordingRefresher(
      const PaymentOrder(
        paymentRef: 'PAY-128',
        status: PaymentStatus.succeeded,
      ),
    );
    final coordinator = PaymentReturnCoordinator(
      expectedReturnUrl: Uri.parse(expectedReturn),
      statusRefresher: refresher,
    );
    final callback = Uri.parse(
      '$expectedReturn?vnp_TxnRef=PAY-128&vnp_ResponseCode=00',
    );

    final outcomes = await Future.wait([
      coordinator.handleWebViewNavigation(callback),
      coordinator.handleDeepLink(callback),
    ]);

    expect(
      outcomes.where(
        (outcome) => outcome.kind == PaymentReturnOutcomeKind.duplicate,
      ),
      hasLength(1),
    );
    expect(
      outcomes.where(
        (outcome) => outcome.kind == PaymentReturnOutcomeKind.succeeded,
      ),
      hasLength(1),
    );
    expect(refresher.references, ['PAY-128']);
  });

  test('malformed callback performs no status refresh', () async {
    final refresher = _RecordingRefresher(
      const PaymentOrder(
        paymentRef: 'PAY-126',
        status: PaymentStatus.succeeded,
      ),
    );
    final coordinator = PaymentReturnCoordinator(
      expectedReturnUrl: Uri.parse(expectedReturn),
      statusRefresher: refresher,
    );

    final outcome = await coordinator.handleDeepLink(
      Uri.parse('$expectedReturn?vnp_TxnRef=PAY-126'),
    );

    expect(outcome, const PaymentReturnOutcome.malformed());
    expect(refresher.references, isEmpty);
  });

  test(
    'refresh failure ends the callback transition without reporting success',
    () async {
      final coordinator = PaymentReturnCoordinator(
        expectedReturnUrl: Uri.parse(expectedReturn),
        statusRefresher: _ThrowingRefresher(),
      );

      final outcome = await coordinator.handleDeepLink(
        Uri.parse('$expectedReturn?vnp_TxnRef=PAY-127&vnp_ResponseCode=00'),
      );

      expect(outcome, const PaymentReturnOutcome.refreshFailed('PAY-127'));
    },
  );
}

class _RecordingRefresher implements PaymentStatusRefresher {
  _RecordingRefresher(this.value);

  final PaymentOrder value;
  final List<String> references = <String>[];

  @override
  Future<PaymentOrder> refresh(String paymentRef) async {
    references.add(paymentRef);
    return value;
  }
}

class _ThrowingRefresher implements PaymentStatusRefresher {
  @override
  Future<PaymentOrder> refresh(String paymentRef) {
    throw StateError('Gateway unavailable');
  }
}
