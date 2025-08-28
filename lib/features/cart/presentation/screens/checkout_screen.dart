import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Checkout Screen
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Card(
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Delivery Address'),
                subtitle: Text('123 Main St, City, State 12345'),
                trailing: Icon(Icons.edit),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.payment),
                title: Text('Payment Method'),
                subtitle: Text('**** **** **** 1234'),
                trailing: Icon(Icons.edit),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.pushNamed('payment'),
                child: const Text('Place Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
