import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';

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
    backgroundColor: PreviewUi.canvas(context),
    appBar: PreviewPageHeader(
      title: 'Thanh toán VNPay',
      onBack: () => Navigator.of(context).maybePop(),
    ),
    body: enabled
        ? paymentSurface
        : Center(
            child: PreviewSurface(
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.payment_outlined, size: 40),
                  SizedBox(height: 16),
                  Text(
                    'Thanh toán trực tuyến chưa được bật.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
  );
}
