import 'package:delivery_app/features/payments/domain/entities/payment_order.dart';
import 'package:equatable/equatable.dart';

abstract interface class PaymentStatusRefresher {
  Future<PaymentOrder> refresh(String paymentRef);
}

/// One payment-return attempt. The URL is only an indication to refresh; the
/// final outcome is based exclusively on the canonical Gateway response.
class PaymentReturnCoordinator {
  PaymentReturnCoordinator({
    required Uri expectedReturnUrl,
    required PaymentStatusRefresher statusRefresher,
  }) : _expectedReturnUrl = expectedReturnUrl,
       _statusRefresher = statusRefresher;

  final Uri _expectedReturnUrl;
  final PaymentStatusRefresher _statusRefresher;
  bool _terminal = false;

  Future<PaymentReturnOutcome> handleWebViewNavigation(Uri callback) =>
      _handle(callback);

  Future<PaymentReturnOutcome> handleDeepLink(Uri callback) =>
      _handle(callback);

  bool isExpectedReturnUri(Uri callback) =>
      callback.scheme == _expectedReturnUrl.scheme &&
      callback.host == _expectedReturnUrl.host &&
      callback.path == _expectedReturnUrl.path;

  Future<PaymentReturnOutcome> _handle(Uri callback) async {
    if (_terminal) return const PaymentReturnOutcome.duplicate();
    final providerResult = _parseProviderCallback(callback);
    if (providerResult == null) return const PaymentReturnOutcome.malformed();

    // Mark terminal before the network request so WebView and app-link copies
    // cannot cause a second status refresh while the first is in flight.
    _terminal = true;
    try {
      final payment = await _statusRefresher.refresh(providerResult.paymentRef);
      return switch (payment.status) {
        PaymentStatus.succeeded => PaymentReturnOutcome.succeeded(
          payment.paymentRef,
        ),
        PaymentStatus.failed || PaymentStatus.expired =>
          PaymentReturnOutcome.failed(payment.paymentRef),
        PaymentStatus.pending || PaymentStatus.unknown =>
          PaymentReturnOutcome.pending(payment.paymentRef),
      };
    } catch (_) {
      return PaymentReturnOutcome.refreshFailed(providerResult.paymentRef);
    }
  }

  _ProviderCallback? _parseProviderCallback(Uri callback) {
    if (!isExpectedReturnUri(callback)) {
      return null;
    }
    final paymentRef = callback.queryParameters['vnp_TxnRef'];
    final responseCode = callback.queryParameters['vnp_ResponseCode'];
    if (paymentRef == null ||
        !RegExp(r'^PAY-[A-Za-z0-9-]{1,59}$').hasMatch(paymentRef) ||
        responseCode == null ||
        !RegExp(r'^\d{2}$').hasMatch(responseCode)) {
      return null;
    }
    return _ProviderCallback(paymentRef);
  }
}

class _ProviderCallback {
  const _ProviderCallback(this.paymentRef);

  final String paymentRef;
}

class PaymentReturnOutcome extends Equatable {
  const PaymentReturnOutcome._(this.kind, [this.paymentRef]);

  const PaymentReturnOutcome.succeeded(String paymentRef)
    : this._(PaymentReturnOutcomeKind.succeeded, paymentRef);
  const PaymentReturnOutcome.failed(String paymentRef)
    : this._(PaymentReturnOutcomeKind.failed, paymentRef);
  const PaymentReturnOutcome.pending(String paymentRef)
    : this._(PaymentReturnOutcomeKind.pending, paymentRef);
  const PaymentReturnOutcome.refreshFailed(String paymentRef)
    : this._(PaymentReturnOutcomeKind.refreshFailed, paymentRef);
  const PaymentReturnOutcome.malformed()
    : this._(PaymentReturnOutcomeKind.malformed);
  const PaymentReturnOutcome.duplicate()
    : this._(PaymentReturnOutcomeKind.duplicate);

  final PaymentReturnOutcomeKind kind;
  final String? paymentRef;

  @override
  List<Object?> get props => [kind, paymentRef];
}

enum PaymentReturnOutcomeKind {
  succeeded,
  failed,
  pending,
  refreshFailed,
  malformed,
  duplicate,
}
