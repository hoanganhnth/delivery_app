import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';
import '../widgets/amber_cart_item_widget.dart';
import '../components/cart_preview_components.dart';
import '../../application/cart_view_intent.dart';
import '../../application/cart_view_state.dart';

/// Pure cart rendering; persistence, price sync and navigation stay in intents.
class CartView extends StatelessWidget {
  const CartView({
    super.key,
    required this.state,
    required this.onIntent,
    this.isTab = false,
    this.showBackButton = true,
    this.previewMode = false,
    this.bottomNavigationBar,
  });
  final CartViewState state;
  final ValueChanged<CartViewIntent> onIntent;
  final bool isTab;
  final bool showBackButton;
  final bool previewMode;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    if (previewMode) return _buildPreview(context);
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppTopBar(
        title: strings.shoppingCart,
        backgroundColor: scheme.surface,
        leadingKey: const Key('cart_back'),
        onBack: showBackButton
            ? () => onIntent(const CartBackRequested())
            : null,
        actions: [
          if (!state.isEmpty)
            AppIconButton(
              key: const Key('cart_clear'),
              tooltip: strings.clearCart,
              icon: Icons.delete_outline,
              onPressed: () => onIntent(const CartClearRequested()),
            ),
        ],
      ),
      body: _body(context),
      bottomNavigationBar: state.isLoading || state.hasError || state.isEmpty
          ? null
          : Material(
              color: scheme.surface,
              child: SafeArea(
                top: false,
                bottom: !isTab,
                minimum: const EdgeInsets.all(12),
                child: FilledButton(
                  key: const Key('cart_checkout'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () => onIntent(const CartCheckoutRequested()),
                  child: Text(
                    '${strings.checkoutTitle} · ${state.totalAmount.toStringAsFixed(0)} ₫',
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    final actions = <Widget>[
      if (!state.isLoading && !state.hasError && !state.isEmpty)
        CartPreviewCheckoutButton(
          totalAmount: state.totalAmount,
          onPressed: () => onIntent(const CartCheckoutRequested()),
        ),
      if (bottomNavigationBar != null) bottomNavigationBar!,
    ];
    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      appBar: CartPreviewHeader(
        itemCount: state.totalItems,
        onBack: showBackButton
            ? () => onIntent(const CartBackRequested())
            : null,
        onCart: () {},
      ),
      body: CartPreviewBody(state: state, onIntent: onIntent),
      bottomNavigationBar: actions.isEmpty
          ? null
          : Column(mainAxisSize: MainAxisSize.min, children: actions),
    );
  }

  Widget _body(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasError) {
      return AppStateFeedback.error(
        title: strings.pilotCheckoutLoadError,
        actionLabel: strings.retry,
        onAction: () => onIntent(const CartRetryRequested()),
      );
    }
    if (state.isEmpty) {
      return AppStateFeedback.empty(
        icon: Icons.shopping_bag_outlined,
        title: strings.yourCartIsEmpty,
        message: strings.addSomeDeliciousItems,
        actionLabel: strings.browseRestaurants,
        onAction: () => onIntent(const CartBrowseRestaurantsRequested()),
      );
    }
    return ListView(
      children: [
        Container(
          color: scheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.restaurantName != null)
                Text(
                  state.restaurantName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              for (final item in state.items)
                AmberCartItemWidget(
                  name: item.name,
                  imageUrl: item.imageUrl,
                  price: '${item.price.toStringAsFixed(0)} ₫',
                  quantity: item.quantity,
                  subtitle: item.notes,
                  onIncrease: () =>
                      onIntent(CartIncrementRequested(item.menuItemId)),
                  onDecrease: () =>
                      onIntent(CartDecrementRequested(item.menuItemId)),
                ),
              TextButton(
                onPressed: () =>
                    onIntent(const CartBrowseRestaurantsRequested()),
                child: Text(strings.continueShopping),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          color: scheme.surface,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${strings.subtotal} (${strings.items(state.totalItems)})',
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${state.totalAmount.toStringAsFixed(0)} ₫',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
