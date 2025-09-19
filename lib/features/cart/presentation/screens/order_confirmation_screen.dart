import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Order Confirmation Screen
class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            SizedBox(height: 16.w),
            Text(
              'Order Confirmed!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.w),
            const Text('Your order will be delivered in 25-30 minutes'),
            SizedBox(height: 32.w),
            ElevatedButton(
              onPressed: () => context.pushNamed('orders'),
              child: const Text('Track Order'),
            ),
          ],
        ),
      ),
    );
  }
}
