import 'package:delivery_app/features/cart/application/order_confirmation_intent.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_state.dart';
import 'package:flutter/material.dart';

class OrderConfirmationView extends StatelessWidget {
  const OrderConfirmationView({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final OrderConfirmationViewState state;
  final ValueChanged<OrderConfirmationIntent> onIntent;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Order Confirmed')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 100, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            'Order Confirmed!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Your order will be delivered in 25-30 minutes'),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () =>
                onIntent(const OrderConfirmationTrackingRequested()),
            child: const Text('Track Order'),
          ),
        ],
      ),
    ),
  );
}
