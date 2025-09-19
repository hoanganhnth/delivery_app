import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Track Order Screen
class TrackOrderScreen extends StatelessWidget {
  final String orderId;
  
  const TrackOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order #$orderId'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0.w),
                child: Column(
                  children: [
                    const Icon(Icons.delivery_dining, size: 64),
                    SizedBox(height: 16.w),
                    Text(
                      'Your order is on the way!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8.w),
                    const Text('Estimated delivery: 15-20 minutes'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.w),
            Expanded(
              child: ListView(
                children: [
                  _buildTrackingStep('Order Confirmed', true, '2:30 PM'),
                  _buildTrackingStep('Restaurant Preparing', true, '2:35 PM'),
                  _buildTrackingStep('Order Ready for Pickup', true, '2:50 PM'),
                  _buildTrackingStep('Driver Assigned', true, '2:52 PM'),
                  _buildTrackingStep('Out for Delivery', true, '2:55 PM'),
                  _buildTrackingStep('Delivered', false, null),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep(String title, bool isCompleted, String? time) {
    return ListTile(
      leading: Icon(
        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isCompleted ? Colors.green : Colors.grey,
      ),
      title: Text(title),
      trailing: time != null ? Text(time) : null,
    );
  }
}
