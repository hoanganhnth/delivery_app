import 'dart:async';

import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/features/payments/application/payment_return_coordinator.dart';
import 'package:delivery_app/features/payments/di/payment_providers.dart';
import 'package:delivery_app/features/payments/presentation/views/payment_return_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A guarded sandbox surface intended for a future owned order-payment entry.
/// It never creates or clears an order; provider navigation only triggers a
/// single canonical Gateway status refresh through [PaymentReturnCoordinator].
class PaymentReturnPage extends ConsumerStatefulWidget {
  const PaymentReturnPage({
    super.key,
    required this.paymentUrl,
    this.onOutcome,
  });

  final Uri paymentUrl;
  final ValueChanged<PaymentReturnOutcome>? onOutcome;

  @override
  ConsumerState<PaymentReturnPage> createState() => _PaymentReturnPageState();
}

class _PaymentReturnPageState extends ConsumerState<PaymentReturnPage> {
  WebViewController? _webViewController;
  late final PaymentReturnCoordinator _coordinator;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _coordinator = ref.read(paymentReturnCoordinatorProvider);
    if (!RuntimeConfig.vnpayPaymentEnabled) return;
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _loading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onNavigationRequest: (request) {
            final callback = Uri.tryParse(request.url);
            if (callback == null ||
                !_coordinator.isExpectedReturnUri(callback)) {
              return NavigationDecision.navigate;
            }
            unawaited(_handleProviderReturn(callback));
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(widget.paymentUrl);
  }

  Future<void> _handleProviderReturn(Uri callback) async {
    final outcome = await _coordinator.handleWebViewNavigation(callback);
    if (!mounted) return;
    setState(() => _loading = false);
    widget.onOutcome?.call(outcome);
  }

  @override
  Widget build(BuildContext context) => PaymentReturnView(
    enabled: RuntimeConfig.vnpayPaymentEnabled,
    paymentSurface: Stack(
      children: [
        if (_webViewController != null)
          WebViewWidget(controller: _webViewController!),
        if (_loading) const Center(child: CircularProgressIndicator()),
      ],
    ),
  );
}
