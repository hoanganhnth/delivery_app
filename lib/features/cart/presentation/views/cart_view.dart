import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/core/widgets/restaurant_header_card.dart';
import 'package:delivery_app/features/cart/presentation/widgets/amber_cart_item_widget.dart';
import '../../application/cart_view_intent.dart';
import '../../application/cart_view_state.dart';

/// Pure cart rendering. All persistence, price sync and navigation are intents.
class CartView extends StatelessWidget {
  const CartView({super.key, required this.state, required this.onIntent});
  final CartViewState state;
  final ValueChanged<CartViewIntent> onIntent;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          GlassAppBar(
            titleText: 'Giỏ hàng',
            leading: GlassBackButton(
              onPressed: () => onIntent(const CartBackRequested()),
            ),
            actions: [
              if (!state.isEmpty)
                GlassActionButton(
                  icon: Icons.delete_outline,
                  onPressed: () => onIntent(const CartClearRequested()),
                ),
            ],
          ),
          Expanded(child: _body(context)),
        ],
      ),
    ),
  );
  Widget _body(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            const Text('Không thể tải giỏ hàng. Vui lòng thử lại.'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => onIntent(const CartRetryRequested()),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }
    if (state.isEmpty) {
      return _EmptyCart(
        onBrowse: () => onIntent(const CartBrowseRestaurantsRequested()),
      );
    }
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            if (state.restaurantName != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: RestaurantHeaderCard(name: state.restaurantName!),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 12.w),
                child: Row(
                  children: [
                    Text(
                      'Đơn hàng của bạn',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${state.items.length} món',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = state.items[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.w),
                    child: AmberCartItemWidget(
                      name: item.name,
                      imageUrl: item.imageUrl,
                      price: '${item.price.toStringAsFixed(0)}đ',
                      quantity: item.quantity,
                      subtitle: item.notes,
                      onIncrease: () =>
                          onIntent(CartIncrementRequested(item.menuItemId)),
                      onDecrease: () =>
                          onIntent(CartDecrementRequested(item.menuItemId)),
                    ),
                  );
                }, childCount: state.items.length),
              ),
            ),
            SliverToBoxAdapter(child: _Summary(totalAmount: state.totalAmount)),
            SliverToBoxAdapter(child: SizedBox(height: 100.w)),
          ],
        ),
        Positioned(
          left: 16.w,
          right: 16.w,
          bottom: 16.w,
          child: ElevatedButton(
            onPressed: () => onIntent(const CartCheckoutRequested()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.payment),
                const SizedBox(width: 8),
                const Text('Thanh toán'),
                const SizedBox(width: 8),
                Text('${state.totalAmount.toStringAsFixed(0)}đ'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.onBrowse});
  final VoidCallback onBrowse;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 100),
          const SizedBox(height: 24),
          Text(
            'Giỏ hàng của bạn đang trống',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          const Text(
            'Thêm món ngon để bắt đầu đặt hàng',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onBrowse,
            icon: const Icon(Icons.restaurant_menu),
            label: const Text('Khám phá nhà hàng'),
          ),
        ],
      ),
    ),
  );
}

class _Summary extends StatelessWidget {
  const _Summary({required this.totalAmount});
  final double totalAmount;
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.all(16),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tổng đơn hàng', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tạm tính'),
              Text('${totalAmount.toStringAsFixed(0)}đ'),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Phí giao hàng'), Text('Tính ở bước thanh toán')],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tạm tính', style: Theme.of(context).textTheme.titleMedium),
              Text(
                '${totalAmount.toStringAsFixed(0)}đ',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
