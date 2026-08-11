import 'package:delivery_app/features/orders/presentation/pages/orders_list_page.dart';
import 'package:flutter/widgets.dart';

/// Compatibility route entry point. New code should use [OrdersListPage].
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) => const OrdersListPage();
}
