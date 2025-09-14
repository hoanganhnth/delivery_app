import 'package:delivery_app/features/orders/presentation/widgets/delivery_tracking_map_widget.dart';
import 'package:delivery_app/features/orders/presentation/widgets/optimized_delivery_tracking_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/delivery_tracking_entity.dart' hide ShipperEntity;
import '../../domain/entities/shipper_location_entity.dart';
import '../providers/providers.dart';

/// Widget hiển thị delivery tracking trong order detail
class OrderDeliveryTrackingCard extends ConsumerStatefulWidget {
  final OrderEntity order;

  const OrderDeliveryTrackingCard({
    super.key,
    required this.order,
  });

  @override
  ConsumerState<OrderDeliveryTrackingCard> createState() => _OrderDeliveryTrackingCardState();
}

class _OrderDeliveryTrackingCardState extends ConsumerState<OrderDeliveryTrackingCard> {
  
  @override
  void initState() {
    super.initState();
    // Start tracking when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.order.id != null) {
        final isCurrentlyTracking = ref.read(isTrackingProvider);
        if (!isCurrentlyTracking) {
          // ref.read(deliveryTrackingNotifierProvider.notifier)
          //     .startTrackingOrder(widget.order.id!);
        }
      }
    });
  }

  @override
  void dispose() {
    // Stop tracking when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackingState = ref.watch(deliveryTrackingNotifierProvider);
    // TODO: Add back when DTOs are ready
    // final currentTracking = ref.watch(currentTrackingProvider);
    // final shipperInfo = ref.watch(shipperInfoProvider);
    final isConnected = ref.watch(trackingConnectionProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Delivery tracking header
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_shipping, color: Colors.green[600], size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Theo dõi giao hàng',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const Spacer(),
                    _buildConnectionStatus(isConnected, trackingState.isLoading),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Error message
                if (trackingState.error != null)
                  _buildErrorMessage(trackingState.error!),
                
                // TODO: Add back when DTOs are ready
                // Shipper info when available
                // if (shipperInfo != null) ...[
                //   const SizedBox(height: 16),
                //   _buildShipperInfo(shipperInfo),
                // ],
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Map widget with fake data for testing
        _buildFakeMapWidget(),
        
        if (trackingState.isLoading)
          _buildLoadingCard()
        else if (!trackingState.isConnected)
          _buildNoDataCard(),
          
        
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildConnectionStatus(bool isConnected, bool isLoading) {
    Color statusColor = isConnected ? Colors.green : Colors.red;
    String statusText = isConnected ? 'Kết nối' : 'Mất kết nối';
    IconData statusIcon = isConnected ? Icons.wifi : Icons.wifi_off;

    if (isLoading) {
      statusColor = Colors.orange;
      statusText = 'Đang kết nối...';
      statusIcon = Icons.sync;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 14),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: TextStyle(
                color: Colors.red.shade800,
                fontSize: 14,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(deliveryTrackingNotifierProvider.notifier).clearError();
            },
            icon: Icon(Icons.close, color: Colors.red.shade600, size: 20),
          ),
        ],
      ),
    );
  }

  // TODO: Add back when DTOs are ready
  /*Widget _buildShipperInfo(shipper) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: shipper.avatar != null
              ? NetworkImage(shipper.avatar!)
              : null,
          child: shipper.avatar == null
              ? const Icon(Icons.person, size: 20)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shipper.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${shipper.vehicleType.toUpperCase()} • ${shipper.vehicleNumber}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.amber[700], size: 16),
            const SizedBox(width: 4),
            Text(
              shipper.rating.toStringAsFixed(1),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () {
            // Implement call functionality
            debugPrint('Calling shipper: ${shipper.phone}');
          },
          icon: const Icon(Icons.phone, size: 16),
          label: const Text('Gọi', style: TextStyle(fontSize: 12)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            minimumSize: const Size(0, 32),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Đang tải thông tin theo dõi...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoDataCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_searching,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Chưa có thông tin theo dõi',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Shipper chưa bắt đầu giao hàng',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/

  Widget _buildLoadingCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildNoDataCard() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('No tracking data available'),
        ),
      ),
    );
  }

  /// Tạm thời fake map widget để test UI
  Widget _buildFakeMapWidget() {
    // Fake delivery tracking data
    final fakeDeliveryTracking = DeliveryTrackingEntity(
      id: 1,
      orderId: widget.order.id ?? 123,
      shipperId: 456,
      status: 'on_the_way',
      pickupAddress: 'Nhà hàng ABC, 123 Nguyễn Văn Cừ, Quận 5',
      pickupLat: 10.7626,
      pickupLng: 106.6818,
      deliveryAddress: 'Tòa nhà XYZ, 456 Lê Văn Sỹ, Quận 3',
      deliveryLat: 10.7869,
      deliveryLng: 106.6964,
      shipperCurrentLat: 10.7750,
      shipperCurrentLng: 106.6890,
      assignedAt: DateTime.now().subtract(const Duration(minutes: 15)),
      pickedUpAt: DateTime.now().subtract(const Duration(minutes: 10)),
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 8)),
      notes: 'Shipper đang trên đường giao hàng',
    );

    // Fake shipper info
    final fakeShipper = ShipperEntity(
      id: 456,
      name: 'Nguyễn Văn A',
      phone: '0901234567',
      vehicleType: 'motorbike',
      vehicleNumber: '29A-12345',
      // rating: 4.8,
      // avatar: null,
    );

    // Fake shipper location
    final fakeShipperLocation = ShipperLocationEntity(
      shipperId: 456,
      latitude: 10.7750,
      longitude: 106.6890,
      accuracy: 5.0,
      speed: 25.0,
      heading: 45.0,
      isOnline: true,
      lastPing: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return OptimizedDeliveryTrackingMapWidget(
      deliveryTracking: fakeDeliveryTracking,
      shipper: fakeShipper,
      shipperLocation: fakeShipperLocation,
    );
  }
}
