import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/providers.dart';
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
  OrderStatus? currentStatus;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersListProvider.notifier).getUserOrders();
    });

    // Listen for tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _loadOrdersByStatus(_getStatusForTab(_tabController.index));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  OrderStatus? _getStatusForTab(int index) {
    switch (index) {
      case 0:
        return null; // All orders
      case 1:
        return OrderStatus.pending;
      case 2:
        return OrderStatus.confirmed;
      case 3:
        return OrderStatus.delivered;
      default:
        return null;
    }
  }

  void _loadOrdersByStatus(OrderStatus? status) {
    setState(() {
      currentStatus = status;
    });

    if (status == null) {
      ref.read(ordersListProvider.notifier).getUserOrders();
    } else {
      // Since we removed getOrdersByStatus, we'll just load all orders
      // and filter them in the UI
      ref.read(ordersListProvider.notifier).getUserOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersState = ref.watch(ordersListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(theme),
      body: Column(
        children: [
          _buildTabBar(theme),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                if (currentStatus == null) {
                  await ref.read(ordersListProvider.notifier).getUserOrders();
                } else {
                  await ref.read(ordersListProvider.notifier).getUserOrders();
                }
              },
              child: _buildBody(ordersState, theme),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      title: Text(
        S.of(context).orders,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: theme.primaryColor,
      elevation: 0,
      centerTitle: true,
    );
  }

  Widget _buildTabBar(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        // indicatorWeight: 3,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        physics: ScrollPhysics(),
        tabAlignment: TabAlignment.center,
        // indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon(
                //   Icons.list_alt,
                //   size: 18,
                // ),
                // const SizedBox(width: 4),
                AutoSizeText(S.of(context).all),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon(
                //   Icons.schedule,
                //   size: 18,
                // ),
                // const SizedBox(width: 4),
                AutoSizeText(S.of(context).pending),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon(
                //   Icons.check_circle_outline,
                //   size: 18,
                // ),
                // const SizedBox(width: 4),
                AutoSizeText(S.of(context).confirmed),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon(
                //   Icons.done_all,
                //   size: 18,
                // ),
                // const SizedBox(width: 4),
                AutoSizeText(S.of(context).delivered),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(OrdersListState ordersState, ThemeData theme) {
    if (ordersState.isLoading && ordersState.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (ordersState.errorMessage != null) {
      return _buildErrorWidget(ordersState.errorMessage!, theme);
    }

    if (ordersState.orders.isEmpty) {
      return _buildEmptyWidget(theme);
    }

    // Filter orders by current status if needed
    List<OrderEntity> filteredOrders = ordersState.orders;
    if (currentStatus != null) {
      filteredOrders = ordersState.orders
          .where((order) => order.status == currentStatus)
          .toList();
    }

    if (filteredOrders.isEmpty) {
      return _buildEmptyWidget(theme);
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: filteredOrders.length + (ordersState.isLoading ? 1 : 0),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == filteredOrders.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final order = filteredOrders[index];
        return OrderCard(
          order: order,
          onTap: () => _navigateToOrderDetail(order.id!),
          onCancel: order.status == OrderStatus.pending
              ? () => _showCancelOrderDialog(order)
              : null,
        );
      },
    );
  }

  Widget _buildErrorWidget(String errorMessage, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              S.of(context).error,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(ordersListProvider.notifier).clearError();
                if (currentStatus == null) {
                  ref.read(ordersListProvider.notifier).getUserOrders();
                } else {
                  ref.read(ordersListProvider.notifier).getUserOrders();
                }
              },
              icon: const Icon(Icons.refresh),
              label: Text(S.of(context).tryAgain),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 24),
            Text(
              S.of(context).noOrders,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).noOrdersMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to restaurants or home
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.restaurant),
              label: Text(S.of(context).restaurants),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToOrderDetail(int orderId) {
    context.pushOrderDetail(orderId.toString());
  }

  void _showCancelOrderDialog(OrderEntity order) {
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
          Consumer(
            builder: (context, ref, child) {
              final cancelAsync = ref.watch(cancelOrderProvider);

              return cancelAsync.when(
                data: (success) => TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final result = await ref
                        .read(cancelOrderProvider.notifier)
                        .cancelOrder(order.id!);
                    if (result && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).orderCancelled),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: Text(
                    S.of(context).confirm,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                loading: () => const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (error, _) => TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(S.of(context).error),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
