import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/connection_providers.dart';

/// Widget hiển thị connection status của các socket services
class ConnectionStatusWidget extends ConsumerWidget {
  const ConnectionStatusWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipperConnectionAsync = ref.watch(shipperLocationConnectionProvider);
    final deliveryConnectionAsync = ref.watch(deliveryTrackingConnectionProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Connection Status',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            
            // Shipper Location Connection
            shipperConnectionAsync.when(
              data: (isConnected) => _buildConnectionRow(
                'Shipper Location',
                isConnected,
                Icons.location_on,
              ),
              loading: () => _buildConnectionRow(
                'Shipper Location',
                null,
                Icons.location_on,
              ),
              error: (_, __) => _buildConnectionRow(
                'Shipper Location',
                false,
                Icons.location_on,
              ),
            ),
            
            const SizedBox(height: 4),
            
            // Delivery Tracking Connection
            deliveryConnectionAsync.when(
              data: (isConnected) => _buildConnectionRow(
                'Delivery Tracking',
                isConnected,
                Icons.local_shipping,
              ),
              loading: () => _buildConnectionRow(
                'Delivery Tracking',
                null,
                Icons.local_shipping,
              ),
              error: (_, __) => _buildConnectionRow(
                'Delivery Tracking',
                false,
                Icons.local_shipping,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildConnectionRow(String name, bool? isConnected, IconData icon) {
    Color color;
    IconData statusIcon;
    String status;
    
    if (isConnected == null) {
      color = Colors.orange;
      statusIcon = Icons.sync;
      status = 'Connecting...';
    } else if (isConnected) {
      color = Colors.green;
      statusIcon = Icons.check_circle;
      status = 'Connected';
    } else {
      color = Colors.red;
      statusIcon = Icons.error_outline;
      status = 'Disconnected';
    }
    
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Icon(statusIcon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          status,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Simple connection indicator cho status bar
class ConnectionIndicator extends ConsumerWidget {
  const ConnectionIndicator({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allReady = ref.watch(allConnectionsReadyProvider);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: allReady ? Colors.green : Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            allReady ? Icons.wifi : Icons.sync,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            allReady ? 'Online' : 'Connecting...',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
