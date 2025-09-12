import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/shipper_location_providers.dart';
import '../providers/delivery_tracking_providers.dart';
import '../providers/connection_providers.dart';

/// Example widget để hiển thị shipper location tracking
class ShipperLocationTrackingWidget extends ConsumerWidget {
  final int shipperId;
  
  const ShipperLocationTrackingWidget({
    required this.shipperId,
    super.key,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipperState = ref.watch(shipperLocationNotifierProvider);
    final connectionAsync = ref.watch(shipperLocationConnectionProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Shipper Location Tracking',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                // Connection status indicator
                connectionAsync.when(
                  data: (isConnected) => Icon(
                    isConnected ? Icons.wifi : Icons.wifi_off,
                    size: 16,
                    color: isConnected ? Colors.green : Colors.red,
                  ),
                  loading: () => const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Icon(
                    Icons.error_outline,
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Show current shipper location state
            if (shipperState.hasError) 
              Column(
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  Text('Error: ${shipperState.error}'),
                ],
              )
            else if (shipperState.isLoading)
              const Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 8),
                  Text('Connecting to shipper tracking...'),
                ],
              )
            else if (shipperState.hasLocation && shipperState.currentLocation != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shipper ID: ${shipperState.currentLocation!.shipperId}'),
                  Text('Latitude: ${shipperState.currentLocation!.latitude.toStringAsFixed(6)}'),
                  Text('Longitude: ${shipperState.currentLocation!.longitude.toStringAsFixed(6)}'),
                  Text('Updated: ${shipperState.currentLocation!.updatedAt.toLocal()}'),
                ],
              )
            else 
              const Text('No location data available'),
          ],
        ),
      ),
    );
  }
}

/// Example widget để hiển thị delivery tracking
class DeliveryTrackingWidget extends ConsumerWidget {
  final int orderId;
  
  const DeliveryTrackingWidget({
    required this.orderId,
    super.key,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryState = ref.watch(deliveryTrackingNotifierProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery Tracking',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // Show current delivery tracking state
            if (deliveryState.error != null) 
              Column(
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  Text('Error: ${deliveryState.error}'),
                ],
              )
            else if (deliveryState.isLoading)
              const Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 8),
                  Text('Connecting to delivery tracking...'),
                ],
              )
            else if (deliveryState.isTracking)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: $orderId'),
                  Text('Status: ${deliveryState.isConnected ? "Connected" : "Disconnected"}'),
                  Text('Tracking: ${deliveryState.isTracking ? "Active" : "Inactive"}'),
                  // TODO: Add actual delivery tracking entity data when DeliveryTrackingEntity is ready
                ],
              )
            else 
              const Text('No tracking data available'),
          ],
        ),
      ),
    );
  }
}
