import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Order Details Screen
class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #$orderId'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () => context.pushNamed(
              'track-order',
              pathParameters: {'orderId': orderId},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Status',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('In Transit'),
                    const SizedBox(height: 16),
                    Text(
                      'Estimated Delivery',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('25-30 minutes'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Order Items',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  _buildOrderItem('Burger Deluxe', 2, 15.99),
                  _buildOrderItem('French Fries', 1, 4.99),
                  _buildOrderItem('Coca Cola', 2, 2.99),
                ],
              ),
            ),
            const Divider(),
            _buildTotalRow('Subtotal', 41.96),
            _buildTotalRow('Delivery Fee', 2.99),
            _buildTotalRow('Tax', 3.60),
            const Divider(),
            _buildTotalRow('Total', 48.55, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, int quantity, double price) {
    return ListTile(
      title: Text(name),
      subtitle: Text('Quantity: $quantity'),
      trailing: Text('\$${(price * quantity).toStringAsFixed(2)}'),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
