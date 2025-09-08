import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Cart Screen
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildCartItem('Burger Deluxe', 2, 15.99),
                _buildCartItem('French Fries', 1, 4.99),
                _buildCartItem('Coca Cola', 2, 2.99),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$41.96',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => context.pushNamed('checkout'),
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(String name, int quantity, double price) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('Quantity: $quantity'),
        trailing: Text('\$${(price * quantity).toStringAsFixed(2)}'),
      ),
    );
  }
}
