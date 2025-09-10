import 'package:delivery_app/core/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/providers.dart';
import '../widgets/orders_tab_bar.dart';
import '../widgets/orders_list.dart';
import '../widgets/orders_empty_state.dart';
import '../widgets/orders_error_state.dart';
import '../widgets/cancel_order_dialog.dart';
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
  OrderStatus? currentStatus;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadInitialData();
    _setupTabListener();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersListProvider.notifier).getUserOrders();
    });
  }

  void _setupTabListener() {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _loadOrdersByStatus(_getStatusForTab(_tabController.index));
      }
    });
  }

  OrderStatus? _getStatusForTab(int index) {
    switch (index) {
      case 0: return null; // All orders
      case 1: return OrderStatus.pending;
      case 2: return OrderStatus.confirmed;
      case 3: return OrderStatus.delivered;
      default: return null;
    }
  }

  void _loadOrdersByStatus(OrderStatus? status) {
    setState(() {
      currentStatus = status;
    });
    ref.read(ordersListProvider.notifier).getUserOrders();
  }

  Future<void> _refreshOrders() async {
    await ref.read(ordersListProvider.notifier).getUserOrders();
  }

  void _retryLoadOrders() {
    ref.read(ordersListProvider.notifier).clearError();
    ref.read(ordersListProvider.notifier).getUserOrders();
  }

  void _navigateToOrderDetail(int orderId) {
    context.pushOrderDetail(orderId.toString());
  }

  void _showCancelOrderDialog(OrderEntity order) {
    CancelOrderDialog.show(
      context,
      order,
      onSuccess: _refreshOrders,
    );
  }

  void _navigateToRestaurants() {
    Navigator.of(context).pop();
  }

  List<OrderEntity> _getFilteredOrders(List<OrderEntity> orders) {
    if (currentStatus == null) return orders;
    return orders.where((order) => order.status == currentStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ordersState = ref.watch(ordersListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(theme),
      body: Column(
        children: [
          OrdersTabBar(tabController: _tabController),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshOrders,
              child: _buildBody(ordersState),
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

  Widget _buildBody(OrdersListState ordersState) {
    // Loading state when no orders yet
    if (ordersState.isLoading && ordersState.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state
    if (ordersState.errorMessage != null) {
      return OrdersErrorState(
        errorMessage: ordersState.errorMessage!,
        onRetry: _retryLoadOrders,
      );
    }

    // Get filtered orders
    final filteredOrders = _getFilteredOrders(ordersState.orders);

    // Empty state
    if (filteredOrders.isEmpty) {
      return OrdersEmptyState(
        onGoToRestaurants: _navigateToRestaurants,
      );
    }

    // Orders list
    return OrdersList(
      orders: filteredOrders,
      isLoading: ordersState.isLoading,
      scrollController: _scrollController,
      onOrderTap: _navigateToOrderDetail,
      onOrderCancel: _showCancelOrderDialog,
    );
  }
}
