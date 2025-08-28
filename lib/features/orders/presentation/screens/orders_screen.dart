import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Orders Screen
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          final orderId = 'ORD${1000 + index}';
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text('Order #$orderId'),
              subtitle: Text('Status: ${_getOrderStatus(index)}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.pushNamed(
                'order-details',
                pathParameters: {'orderId': orderId},
              ),
            ),
          );
        },
      ),
    );
  }

  String _getOrderStatus(int index) {
    final statuses = ['Delivered', 'In Transit', 'Preparing', 'Confirmed', 'Pending'];
    return statuses[index % statuses.length];
  }
}
