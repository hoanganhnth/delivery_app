import 'package:flutter/material.dart';

/// The page boundary that prevents native WebView construction unless the
/// compile-time payment capability is enabled by an explicit build.
class PaymentReturnView extends StatelessWidget {
  const PaymentReturnView({
    super.key,
    required this.enabled,
    required this.paymentSurface,
  });

  final bool enabled;
  final Widget paymentSurface;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Thanh toán VNPay')),
    body: enabled
        ? paymentSurface
        : const Center(child: Text('Thanh toán trực tuyến chưa được bật.')),
  );
}
