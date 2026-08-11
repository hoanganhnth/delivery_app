import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/features/cart/application/checkout_voucher.dart';
import 'package:delivery_app/features/cart/di/checkout_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export '../application/checkout_voucher.dart';

/// Wallet gateway compatibility state. The pure checkout view receives this
/// data through [CheckoutViewModel], never by watching this provider directly.
final checkoutVoucherWalletProvider =
    FutureProvider.autoDispose<List<CheckoutVoucher>>((ref) async {
      if (!RuntimeConfig.voucherCheckoutEnabled) return const [];
      return ref.read(checkoutVoucherGatewayProvider).getWallet();
    });
