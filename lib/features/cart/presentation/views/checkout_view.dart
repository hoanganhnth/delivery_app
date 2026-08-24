import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/cart/application/checkout_intent.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Pure checkout rendering. Every customer action is an intent; persistence,
/// price previews, voucher loading and order creation are ViewModel concerns.
class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.state, required this.onIntent});

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.state.notes);
  }

  @override
  void didUpdateWidget(covariant CheckoutView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_notesController.text != widget.state.notes) {
      _notesController.value = _notesController.value.copyWith(
        text: widget.state.notes,
        selection: TextSelection.collapsed(offset: widget.state.notes.length),
        composing: TextRange.empty,
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.checkoutTitle),
        leading: IconButton(
          key: const Key('checkout_back'),
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          icon: const Icon(Icons.close),
          onPressed: () => widget.onIntent(const CheckoutBackRequested()),
        ),
      ),
      body: _body(context),
      bottomNavigationBar:
          widget.state.isCartLoading ||
              widget.state.hasCartError ||
              widget.state.isEmpty
          ? null
          : _CheckoutBottomBar(state: widget.state, onIntent: widget.onIntent),
    );
  }

  Widget _body(BuildContext context) {
    final state = widget.state;
    if (state.isCartLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasCartError) {
      return _CheckoutTerminalState(
        icon: Icons.error_outline,
        title: 'Không thể tải thông tin thanh toán.',
        actionLabel: 'Thử lại',
        onAction: () => widget.onIntent(const CheckoutPreviewRetryRequested()),
      );
    }
    if (state.isEmpty) {
      return _CheckoutTerminalState(
        icon: Icons.shopping_cart_outlined,
        title: 'Giỏ hàng trống',
        message: 'Hãy thêm ít nhất một món hàng để tiếp tục.',
        actionLabel: 'Tiếp tục mua sắm',
        onAction: () => widget.onIntent(const CheckoutBackRequested()),
      );
    }

    final strings = S.of(context);
    return Column(
      children: [
        if (state.isPreviewLoading) const _CheckoutPriceStatus.loading(),
        if (state.hasPreviewError)
          _CheckoutPriceStatus.error(
            onRetry: () =>
                widget.onIntent(const CheckoutPreviewRetryRequested()),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.page),
            children: [
              _CheckoutSection(
                title: 'Nhà hàng',
                icon: Icons.restaurant_outlined,
                child: _RestaurantCard(
                  name: state.restaurantName ?? 'Nhà hàng',
                  itemCount: state.itemCount,
                  distinctItems: state.lines.length,
                ),
              ),
              _CheckoutSection(
                title: strings.checkoutDeliveryAddress,
                icon: Icons.location_on_outlined,
                child: _DeliveryAddressCard(
                  address: state.selectedAddress,
                  onTap: () => widget.onIntent(
                    const CheckoutAddressSelectionRequested(),
                  ),
                ),
              ),
              _CheckoutSection(
                title: strings.checkoutPaymentMethodTitle,
                icon: Icons.payments_outlined,
                child: const _PaymentMethodCard(),
              ),
              if (state.isVoucherAvailable)
                _CheckoutSection(
                  title: 'Voucher',
                  icon: Icons.local_offer_outlined,
                  child: _VoucherSelector(
                    state: state,
                    onIntent: widget.onIntent,
                  ),
                ),
              _CheckoutSection(
                title: strings.checkoutOrderDetailsTitle,
                icon: Icons.receipt_long_outlined,
                child: _OrderSummary(state: state),
              ),
              _CheckoutSection(
                title: strings.checkoutNotesTitle,
                icon: Icons.note_outlined,
                child: TextField(
                  key: const Key('checkout_notes'),
                  controller: _notesController,
                  maxLines: 3,
                  onChanged: (notes) =>
                      widget.onIntent(CheckoutNotesChanged(notes)),
                  decoration: const InputDecoration(
                    hintText:
                        'Ghi chú đặc biệt cho đơn hàng (ví dụ: không cay, giao tận tay...)',
                    border: OutlineInputBorder(borderRadius: AppRadii.control),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
            ],
          ),
        ),
      ],
    );
  }
}

class _CheckoutPriceStatus extends StatelessWidget {
  const _CheckoutPriceStatus.loading() : isLoading = true, onRetry = null;

  const _CheckoutPriceStatus.error({required this.onRetry}) : isLoading = false;

  final bool isLoading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: isLoading ? scheme.secondaryContainer : scheme.errorContainer,
      child: InkWell(
        onTap: onRetry,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.page,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            children: [
              if (isLoading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(
                  Icons.warning_amber_rounded,
                  color: scheme.onErrorContainer,
                ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  isLoading
                      ? S.of(context).checkoutLoadingPrice
                      : S.of(context).checkoutErrorPrice,
                ),
              ),
              if (!isLoading)
                Icon(Icons.refresh, color: scheme.onErrorContainer),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppSpacing.xs),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.card),
            child: child,
          ),
        ),
      ],
    ),
  );
}

class _RestaurantCard extends StatelessWidget {
  const _RestaurantCard({
    required this.name,
    required this.itemCount,
    required this.distinctItems,
  });

  final String name;
  final int itemCount;
  final int distinctItems;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: AppRadii.control,
        ),
        child: const SizedBox(
          height: 48,
          width: 48,
          child: Icon(Icons.restaurant_outlined),
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.xxs),
            Text('$distinctItems món · $itemCount sản phẩm'),
          ],
        ),
      ),
    ],
  );
}

class _DeliveryAddressCard extends StatelessWidget {
  const _DeliveryAddressCard({required this.address, required this.onTap});

  final CheckoutAddressViewData? address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final value = address;
    final theme = Theme.of(context);
    return InkWell(
      key: const Key('checkout_address_selector'),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on_outlined, color: theme.colorScheme.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: value == null
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chọn địa chỉ giao hàng',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: AppSpacing.xxs),
                      Text('Vui lòng chọn địa chỉ để tính phí giao hàng.'),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: AppSpacing.xs,
                        children: [
                          Text(
                            value.label,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          if (value.isDefault) const Text('Mặc định'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text('${value.recipientName} · ${value.phoneNumber}'),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(value.fullAddress),
                    ],
                  ),
          ),
          const SizedBox(width: AppSpacing.xs),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Icon(Icons.payments_outlined),
      SizedBox(width: AppSpacing.sm),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tiền mặt (COD)',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            Text('Thanh toán khi nhận hàng'),
          ],
        ),
      ),
      Icon(Icons.check_circle, color: Colors.green),
    ],
  );
}

class _VoucherSelector extends StatelessWidget {
  const _VoucherSelector({required this.state, required this.onIntent});

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    if (state.isVoucherLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.hasVoucherError) {
      return Row(
        children: [
          const Expanded(child: Text('Không thể tải ví voucher.')),
          TextButton(
            key: const Key('checkout_voucher_retry'),
            onPressed: () => onIntent(const CheckoutVoucherRetryRequested()),
            child: const Text('Thử lại'),
          ),
        ],
      );
    }
    return Column(
      key: const Key('checkout_voucher_selector'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          key: const Key('checkout_voucher_code'),
          textCapitalization: TextCapitalization.characters,
          onSubmitted: (code) => onIntent(CheckoutVoucherCodeSubmitted(code)),
          decoration: const InputDecoration(
            labelText: 'Nhập mã để lưu vào ví',
            helperText: 'Nhấn Enter để lưu voucher',
            border: OutlineInputBorder(borderRadius: AppRadii.control),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (state.isVoucherStackingAvailable) ...[
          SegmentedButton<String>(
            segments: const [
              ButtonSegment<String>(value: 'AUTO', label: Text('Tự động')),
              ButtonSegment<String>(value: 'MANUAL', label: Text('Tự chọn')),
            ],
            selected: {state.selectionMode},
            onSelectionChanged: (value) =>
                onIntent(CheckoutVoucherModeChanged(value.first)),
          ),
          const SizedBox(height: AppSpacing.xs),
          if (state.selectionMode == 'AUTO')
            const Text('Hệ thống chọn tổ hợp có lợi nhất, tối đa 3 voucher.')
          else ...[
            for (final voucher in state.vouchers)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                value: state.selectedVoucherIds.contains(voucher.id),
                title: Text('${voucher.code} · ${voucher.displayBenefit}'),
                subtitle: Text(voucher.layer),
                onChanged: (checked) {
                  final ids = [...state.selectedVoucherIds];
                  if (checked == true) {
                    ids.add(voucher.id);
                  } else {
                    ids.remove(voucher.id);
                  }
                  onIntent(CheckoutVoucherSelectionChanged(ids));
                },
              ),
            if (state.vouchers.isEmpty)
              const Text(
                'Ví voucher hiện chưa có mã phù hợp với nhà hàng này.',
              ),
          ],
        ] else ...[
          const Text('Chọn một voucher để áp dụng cho đơn hàng.'),
          for (final voucher in state.vouchers)
            RadioListTile<int>(
              contentPadding: EdgeInsets.zero,
              dense: true,
              value: voucher.id,
              groupValue: state.selectedVoucherId,
              title: Text('${voucher.code} · ${voucher.displayBenefit}'),
              subtitle: Text(voucher.layer),
              onChanged: (value) => onIntent(CheckoutVoucherChanged(value)),
            ),
          if (state.vouchers.isEmpty)
            const Text('Ví voucher hiện chưa có mã phù hợp với nhà hàng này.'),
        ],
        const SizedBox(height: AppSpacing.xs),
        const Text('Voucher không dùng chung với Flash Sale.'),
      ],
    );
  }
}

class _OrderSummary extends StatelessWidget {
  const _OrderSummary({required this.state});

  final CheckoutViewState state;

  @override
  Widget build(BuildContext context) {
    final price = state.price;
    final strings = S.of(context);
    return Column(
      children: [
        for (final line in state.lines)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 6),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text('${line.quantity}x ${line.name}')),
                Text('${line.lineTotal.toStringAsFixed(0)}₫'),
              ],
            ),
          ),
        const Divider(),
        _PriceRow(label: strings.checkoutSubtotal, value: price?.subtotal),
        const SizedBox(height: AppSpacing.xs),
        _PriceRow(
          label: strings.checkoutShippingFee,
          value: price?.shippingFee,
        ),
        if (price != null && price.discountAmount > 0) ...[
          const SizedBox(height: AppSpacing.xs),
          _PriceRow(
            label: strings.checkoutDiscount,
            value: -price.discountAmount,
            isDiscount: true,
          ),
        ],
        if (price != null && price.appliedVouchers.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          for (final voucher in price.appliedVouchers)
            _PriceRow(
              label: '${voucher.code} · ${voucher.layer}',
              value: voucher.discountAmount,
              isDiscount: true,
            ),
        ],
        const Divider(),
        _PriceRow(
          label: strings.checkoutTotal,
          value: price?.total,
          isEmphasized: true,
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.isDiscount = false,
    this.isEmphasized = false,
  });

  final String label;
  final double? value;
  final bool isDiscount;
  final bool isEmphasized;

  @override
  Widget build(BuildContext context) {
    final amount = value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isEmphasized
              ? const TextStyle(fontWeight: FontWeight.w800)
              : null,
        ),
        Text(
          amount == null
              ? '—'
              : '${isDiscount ? '-' : ''}${amount.abs().toStringAsFixed(0)}₫',
          style: TextStyle(
            fontWeight: isEmphasized ? FontWeight.w800 : FontWeight.w500,
            color: isDiscount ? Colors.green : null,
          ),
        ),
      ],
    );
  }
}

class _CheckoutBottomBar extends StatelessWidget {
  const _CheckoutBottomBar({required this.state, required this.onIntent});

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final price = state.price;
    return Material(
      elevation: 10,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.page),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).checkoutTotal,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    price == null ? '—' : '${price.total.toStringAsFixed(0)}₫',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  key: const Key('checkout_place_order'),
                  onPressed: state.canPlaceOrder
                      ? () => onIntent(const CheckoutPlaceOrderRequested())
                      : null,
                  child: state.isPlacingOrder
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          state.isPreviewLoading
                              ? S.of(context).checkoutLoadingPrice
                              : S.of(context).checkoutOrderBtn,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutTerminalState extends StatelessWidget {
  const _CheckoutTerminalState({
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
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(message!, textAlign: TextAlign.center),
          ],
          const SizedBox(height: AppSpacing.lg),
          FilledButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    ),
  );
}
