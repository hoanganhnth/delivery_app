import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/order_entity.dart';
import '../providers/providers.dart';
import '../widgets/orders_tab_bar.dart';
import '../widgets/orders_list.dart' as orders_widget;
import '../widgets/orders_empty_state.dart';
import '../widgets/orders_error_state.dart';
import '../widgets/cancel_order_dialog.dart';

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
    _tabController = TabController(length: 3, vsync: this); // All, Active, Completed
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
      case 0:
        return null; // All orders
      case 1:
        return OrderStatus.pending; // Active (will filter pending + delivering)
      case 2:
        return OrderStatus.delivered; // Completed
      default:
        return null;
    }
  }

  void _loadOrdersByStatus(OrderStatus? status) {
    setState(() {
      currentStatus = status;
    });
    ref.read(ordersListProvider.notifier).getUserOrders();
  }

  Future<void> _refreshOrders() async {
    ref.invalidate(ordersListProvider);
  }

  void _retryLoadOrders() {
    ref.invalidate(ordersListProvider);
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
    if (currentStatus == null) return orders; // All
    if (currentStatus == OrderStatus.pending) {
      // Active tab: show pending + delivering
      return orders
          .where((order) =>
              order.status == OrderStatus.pending ||
              order.status == OrderStatus.delivering)
          .toList();
    }
    // Completed tab
    return orders.where((order) => order.status == currentStatus).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ordersState = ref.watch(ordersListProvider);
    final colors = ref.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: _buildAppBar(colors),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section - Editorial style
          Padding(
            padding: EdgeInsets.fromLTRB(
              ResponsiveSize.m,
              ResponsiveSize.l,
              ResponsiveSize.m,
              ResponsiveSize.s,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Orders',
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w900,
                    color: colors.textPrimary,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: ResponsiveSize.xs),
                Text(
                  'Track your current cravings and past delights.',
                  style: TextStyle(
                    fontSize: ResponsiveSize.fontM,
                    fontWeight: FontWeight.w500,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Filter Tabs
          OrdersTabBar(tabController: _tabController),
          SizedBox(height: ResponsiveSize.s),
          // Orders List
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

  PreferredSizeWidget _buildAppBar(AppColors colors) {
    return AppBar(
      backgroundColor: colors.background,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: colors.textSecondary),
          onPressed: () {
            // TODO: Implement search
          },
        ),
      ],
    );
  }

  Widget _buildBody(AsyncValue<List<OrderEntity>> ordersState) {
    return ordersState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => OrdersErrorState(
        errorMessage: error.toString(),
        onRetry: _retryLoadOrders,
      ),
      data: (orders) {
        // Get filtered orders
        final filteredOrders = _getFilteredOrders(orders);

        // Empty state
        if (filteredOrders.isEmpty) {
          return OrdersEmptyState(
            onGoToRestaurants: _navigateToRestaurants,
          );
        }

        // Orders list
        return orders_widget.OrdersList(
          orders: filteredOrders,
          isLoading: false,
          scrollController: _scrollController,
          onOrderTap: _navigateToOrderDetail,
          onOrderCancel: _showCancelOrderDialog,
        );
      },
    );
  }
}
