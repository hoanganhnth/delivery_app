import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tracking_providers.dart';
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
    final locationAsync = ref.watch(shipperLocationStreamProvider(shipperId));
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
            locationAsync.when(
              data: (location) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shipper ID: ${location.shipperId}'),
                  Text('Latitude: ${location.latitude.toStringAsFixed(6)}'),
                  Text('Longitude: ${location.longitude.toStringAsFixed(6)}'),
                  Text('Updated: ${location.updatedAt.toLocal()}'),
                ],
              ),
              loading: () => const Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 8),
                  Text('Connecting to shipper tracking...'),
                ],
              ),
              error: (error, stack) => Column(
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  Text('Error: $error'),
                ],
              ),
            ),
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
    final trackingAsync = ref.watch(deliveryTrackingStreamProvider(orderId));
    
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
            trackingAsync.when(
              data: (tracking) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${tracking.orderId}'),
                  Text('Status: ${tracking.status}'),
                  Text('Shipper: ${tracking.shipperId}'),
                  if (tracking.estimatedDeliveryTime != null)
                    Text('ETA: ${tracking.estimatedDeliveryTime!.toLocal()}'),
                  if (tracking.shipperCurrentLat != null && tracking.shipperCurrentLng != null)
                    Text(
                      'Current Location: ${tracking.shipperCurrentLat!.toStringAsFixed(6)}, ${tracking.shipperCurrentLng!.toStringAsFixed(6)}',
                    ),
                ],
              ),
              loading: () => const Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 8),
                  Text('Connecting to delivery tracking...'),
                ],
              ),
              error: (error, stack) => Column(
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  Text('Error: $error'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
