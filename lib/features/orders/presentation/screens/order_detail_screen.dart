import 'package:delivery_app/features/orders/presentation/pages/order_detail_page.dart';
import 'package:flutter/material.dart';

/// Compatibility route entry point during the Orders presentation migration.
class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final num orderId;

  @override
  Widget build(BuildContext context) =>
      OrderDetailPage(orderId: orderId.toInt());
}
