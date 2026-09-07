import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/core/widgets/restaurant_header_card.dart';
import 'package:delivery_app/features/cart/presentation/widgets/amber_cart_item_widget.dart';
import '../../application/cart_view_intent.dart';
import '../../application/cart_view_state.dart';

/// Pure cart rendering. All persistence, price sync and navigation are intents.
class CartView extends StatelessWidget {
  const CartView({
    super.key,
    required this.state,
    required this.onIntent,
    this.isTab = false,
    this.showBackButton = true,
  });

  final CartViewState state;
  final ValueChanged<CartViewIntent> onIntent;
  final bool isTab;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF7F8FA),
    appBar: AppTopBar(
      title: 'Giỏ hàng',
      leadingKey: const Key('cart_back'),
      backTooltip: 'Quay lại',
      onBack: showBackButton ? () => onIntent(const CartBackRequested()) : null,
      actions: [
        if (!state.isEmpty)
          AppIconButton(
            key: const Key('cart_clear'),
            tooltip: 'Xóa giỏ hàng',
            icon: Icons.delete_outline,
            onPressed: () => onIntent(const CartClearRequested()),
          ),
      ],
    ),
    body: _body(context),
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

    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final bottomNavHeight = isTab ? (96.w + bottomPadding) : bottomPadding;
    final checkoutButtonBottom = bottomNavHeight + 16.w;

    if (state.isEmpty) {
      return _EmptyCart(
        bottomOffset: bottomNavHeight,
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
            SliverToBoxAdapter(child: SizedBox(height: checkoutButtonBottom + 56.w)),
          ],
        ),
        Positioned(
          left: 16.w,
          right: 16.w,
          bottom: checkoutButtonBottom,
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
  const _EmptyCart({required this.onBrowse, this.bottomOffset = 0});
  final VoidCallback onBrowse;
  final double bottomOffset;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.fromLTRB(32, 32, 32, 32 + bottomOffset),
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
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: AppRadii.container,
      border: Border.all(color: const Color(0xFFEDEFF2), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tổng đơn hàng',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1A1D20),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tạm tính', style: TextStyle(color: Color(0xFF757F8A))),
            Text(
              '${totalAmount.toStringAsFixed(0)}đ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí giao hàng', style: TextStyle(color: Color(0xFF757F8A))),
            Text('Tính ở bước thanh toán', style: TextStyle(color: Color(0xFF757F8A))),
          ],
        ),
        const Divider(color: Color(0xFFEDEFF2), height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tạm tính',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '${totalAmount.toStringAsFixed(0)}đ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
