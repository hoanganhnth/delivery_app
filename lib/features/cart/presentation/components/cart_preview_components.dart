import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/cart/application/cart_view_intent.dart';
import 'package:delivery_app/features/cart/application/cart_view_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _cartPreviewAccent = Color(0xFFEE4D2D);

class CartPreviewHeader extends StatelessWidget implements PreferredSizeWidget {
  const CartPreviewHeader({
    super.key,
    required this.itemCount,
    this.onBack,
    required this.onCart,
  });

  final int itemCount;
  final VoidCallback? onBack;
  final VoidCallback onCart;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 50,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    backgroundColor: PreviewUi.surface(context),
    leadingWidth: 44,
    leading: onBack == null
        ? const SizedBox(width: 44)
        : IconButton(
            key: const Key('cart_back'),
            tooltip: 'Quay lại',
            onPressed: onBack,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back, color: _cartPreviewAccent),
          ),
    title: Text(
      'Giỏ hàng',
      style: TextStyle(
        color: PreviewUi.text(context),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    actions: [
      SizedBox(
        width: 44,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            IconButton(
              key: const Key('cart_header_action'),
              tooltip: 'Giỏ hàng',
              onPressed: onCart,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.shopping_bag_outlined, size: 22),
            ),
            if (itemCount > 0)
              Positioned(
                right: 1,
                top: 4,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: _cartPreviewAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    itemCount > 99 ? '99+' : '$itemCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class CartPreviewBody extends StatelessWidget {
  const CartPreviewBody({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CartViewState state;
  final ValueChanged<CartViewIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasError) {
      return Center(
        child: _CartPreviewMessage(
          icon: Icons.error_outline,
          title: 'Chưa tải được giỏ hàng',
          actionLabel: 'Thử lại',
          onAction: () => onIntent(const CartRetryRequested()),
        ),
      );
    }
    if (state.isEmpty) {
      return Center(
        child: _CartPreviewMessage(
          icon: Icons.receipt_long_outlined,
          title: 'Giỏ hàng đang trống',
          message: 'Món ngon đang chờ bạn khám phá!',
          actionLabel: 'Khám phá món ngon',
          onAction: () => onIntent(const CartBrowseRestaurantsRequested()),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ColoredBox(
          color: PreviewUi.surface(context),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.restaurantName ?? 'Nhà hàng',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                for (final item in state.items)
                  CartPreviewLine(
                    item: item,
                    onIncrease: () =>
                        onIntent(CartIncrementRequested(item.menuItemId)),
                    onDecrease: () =>
                        onIntent(CartDecrementRequested(item.menuItemId)),
                  ),
                TextButton(
                  key: const Key('cart_preview_add_more'),
                  onPressed: () =>
                      onIntent(const CartBrowseRestaurantsRequested()),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: _cartPreviewAccent,
                  ),
                  child: const Text(
                    '+ Thêm món',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ColoredBox(
          color: PreviewUi.surface(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Tạm tính (${state.totalItems} món)',
                  style: const TextStyle(fontSize: 13),
                ),
                const Spacer(),
                Text(
                  _cartMoney(state.totalAmount),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 88),
      ],
    );
  }
}

class CartPreviewLine extends StatelessWidget {
  const CartPreviewLine({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
  });

  final CartLineViewData item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppContentImage(
          imageUrl: item.imageUrl,
          semanticLabel: item.name,
          width: 75,
          height: 75,
          borderRadius: BorderRadius.circular(3),
          placeholderIcon: Icons.fastfood_outlined,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.notes?.trim().isNotEmpty == true
                      ? item.notes!
                      : 'Không có ghi chú',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: PreviewUi.muted(context),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      _cartMoney(item.price),
                      style: const TextStyle(
                        color: _cartPreviewAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    _CartStepper(
                      quantity: item.quantity,
                      onIncrease: onIncrease,
                      onDecrease: onDecrease,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _CartStepper extends StatelessWidget {
  const _CartStepper({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) => Container(
    height: 32,
    decoration: BoxDecoration(
      border: Border.all(color: PreviewUi.divider(context)),
      borderRadius: BorderRadius.circular(3),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Giảm số lượng',
          onPressed: onDecrease,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 30, height: 30),
          icon: const Icon(Icons.remove, size: 14, color: _cartPreviewAccent),
        ),
        SizedBox(
          width: 19,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
          tooltip: 'Tăng số lượng',
          onPressed: onIncrease,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 30, height: 30),
          icon: const Icon(Icons.add, size: 14, color: _cartPreviewAccent),
        ),
      ],
    ),
  );
}

class CartPreviewCheckoutButton extends StatelessWidget {
  const CartPreviewCheckoutButton({
    super.key,
    required this.totalAmount,
    required this.onPressed,
  });

  final double totalAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Material(
    color: PreviewUi.surface(context),
    elevation: 3,
    child: SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 12, 12, 20),
      child: SizedBox(
        height: 44,
        child: Material(
          color: _cartPreviewAccent,
          borderRadius: BorderRadius.circular(3),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(3),
            child: Center(
              child: Text(
                'Giao hàng · ${_cartMoney(totalAmount)}',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _CartPreviewMessage extends StatelessWidget {
  const _CartPreviewMessage({
    required this.icon,
    required this.title,
    required this.actionLabel,
    required this.onAction,
    this.message,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 46, color: PreviewUi.muted(context)),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        if (message != null) ...[
          const SizedBox(height: 6),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
          ),
        ],
        const SizedBox(height: 16),
        SizedBox(
          height: 44,
          child: FilledButton(
            onPressed: onAction,
            style: FilledButton.styleFrom(
              backgroundColor: _cartPreviewAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: Text(actionLabel),
          ),
        ),
      ],
    ),
  );
}

String _cartMoney(num value) =>
    '${NumberFormat('#,###', 'vi_VN').format(value)}đ';
