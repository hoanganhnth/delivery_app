import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/orders_providers.dart';
import '../providers/orders_provider.dart';
import '../widgets/order_card.dart';
import '../../../../generated/l10n.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollController = ScrollController();
  
  // Status filters
  final List<OrderStatus?> _statusFilters = [
    null, // Tất cả
    OrderStatus.pending,
    OrderStatus.confirmed,
    OrderStatus.preparing,
    OrderStatus.delivering,
    OrderStatus.delivered,
    OrderStatus.cancelled,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _statusFilters.length, vsync: this);
    
    // Load orders when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersProvider.notifier).getUserOrders();
    });
    
    // Setup scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Load more orders when reaching bottom
      _loadMoreOrders();
    }
  }

  void _loadMoreOrders() {
    // TODO: Implement pagination
  }

  void _onTabChanged(int index) {
    final status = _statusFilters[index];
    if (status == null) {
      // Load all orders
      ref.read(ordersProvider.notifier).getUserOrders();
    } else {
      // Load orders by status
      ref.read(ordersProvider.notifier).getOrdersByStatus(status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersState = ref.watch(ordersProvider);
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).orders),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          onTap: _onTabChanged,
          tabs: [
            Tab(text: S.of(context).all),
            Tab(text: S.of(context).pending),
            Tab(text: S.of(context).confirmed),
            Tab(text: S.of(context).preparing),
            Tab(text: S.of(context).delivering),
            Tab(text: S.of(context).delivered),
            Tab(text: S.of(context).cancelled),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final currentStatus = _statusFilters[_tabController.index];
          if (currentStatus == null) {
            await ref.read(ordersProvider.notifier).getUserOrders();
          } else {
            await ref.read(ordersProvider.notifier).getOrdersByStatus(currentStatus);
          }
        },
        child: _buildBody(ordersState, theme),
      ),
    );
  }

  Widget _buildBody(OrdersState ordersState, ThemeData theme) {
    if (ordersState.isLoading && ordersState.orders.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (ordersState.errorMessage != null && ordersState.orders.isEmpty) {
      return _buildErrorState(ordersState.errorMessage!, theme);
    }

    if (ordersState.orders.isEmpty) {
      return _buildEmptyState(theme);
    }

    return Column(
      children: [
        if (ordersState.errorMessage != null)
          _buildErrorBanner(ordersState.errorMessage!, theme),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: ordersState.orders.length + (ordersState.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == ordersState.orders.length) {
                // Loading indicator at bottom
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final order = ordersState.orders[index];
              return OrderCard(
                order: order,
                onTap: () => _showOrderDetail(order),
                onCancel: order.canCancel ? () => _cancelOrder(order.id!) : null,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String error, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).error,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final currentStatus = _statusFilters[_tabController.index];
              if (currentStatus == null) {
                ref.read(ordersProvider.notifier).getUserOrders();
              } else {
                ref.read(ordersProvider.notifier).getOrdersByStatus(currentStatus);
              }
            },
            child: Text(S.of(context).retry),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).noOrders,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).noOrdersMessage,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(String error, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: theme.colorScheme.errorContainer,
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.onErrorContainer,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(ordersProvider.notifier).clearError();
            },
            icon: Icon(
              Icons.close,
              color: theme.colorScheme.onErrorContainer,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDetail(OrderEntity order) {
    // TODO: Navigate to order detail screen
    debugPrint('Show order detail: ${order.id}');
  }

  void _cancelOrder(int orderId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).cancelOrder),
        content: Text(S.of(context).cancelOrderConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success = await ref
                  .read(ordersProvider.notifier)
                  .cancelOrder(orderId);
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success 
                        ? S.of(context).orderCancelled
                        : S.of(context).cancelOrderFailed,
                    ),
                    backgroundColor: success 
                        ? Colors.green 
                        : Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(S.of(context).confirm),
          ),
        ],
      ),
    );
  }
}
