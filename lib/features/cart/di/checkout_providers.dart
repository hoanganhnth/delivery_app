import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/cart/application/checkout_preview_gateway.dart';
import 'package:delivery_app/features/cart/application/checkout_voucher.dart';
import 'package:delivery_app/features/orders/data/datasources/order_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkoutPreviewGatewayProvider = Provider<CheckoutPreviewGateway>((ref) {
  return OrderApiCheckoutPreviewGateway(
    OrderApiService(ref.watch(authenticatedDioProvider)),
  );
});

final checkoutVoucherGatewayProvider = Provider<CheckoutVoucherGateway>((ref) {
  return CheckoutVoucherClient(ref.watch(authenticatedDioProvider));
});
