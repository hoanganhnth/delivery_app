import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/cart/application/checkout_intent.dart';
import 'package:delivery_app/features/cart/application/checkout_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CheckoutBody extends StatelessWidget {
  const CheckoutBody({
    super.key,
    required this.state,
    required this.notesController,
    required this.onIntent,
  });

  final CheckoutViewState state;
  final TextEditingController notesController;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    if (state.isCartLoading) {
      return AppStateFeedback.loading(title: strings.loading);
    }
    if (state.hasCartError) {
      return AppStateFeedback.error(
        title: strings.pilotCheckoutLoadError,
        actionLabel: strings.retry,
        onAction: () => onIntent(const CheckoutPreviewRetryRequested()),
      );
    }
    if (state.isEmpty) {
      return AppStateFeedback.empty(
        icon: Icons.shopping_cart_outlined,
        title: strings.pilotCheckoutCartEmpty,
        message: strings.pilotCheckoutCartEmptyMessage,
        actionLabel: strings.continueShopping,
        onAction: () => onIntent(const CheckoutBackRequested()),
      );
    }

    return Column(
      children: [
        if (state.isPreviewLoading)
          const CheckoutPriceStatus.loading()
        else if (state.hasPreviewError)
          CheckoutPriceStatus.error(
            onRetry: () => onIntent(const CheckoutPreviewRetryRequested()),
          ),
        Expanded(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.zero,
            children: [
              _PhoneSection(
                title: strings.checkoutDeliveryAddress,
                icon: Icons.location_on_outlined,
                child: CheckoutDeliveryAddress(
                  address: state.selectedAddress,
                  onTap: () =>
                      onIntent(const CheckoutAddressSelectionRequested()),
                ),
              ),
              _PhoneSection(
                title: state.restaurantName ?? strings.restaurants,
                icon: Icons.restaurant_outlined,
                child: Column(
                  children: [
                    CheckoutOrderSummary(state: state, linesOnly: true),
                    AppTextField(
                      key: const Key('checkout_notes'),
                      controller: notesController,
                      semanticLabel: strings.checkoutNotesTitle,
                      label: strings.checkoutNotesTitle,
                      hintText: strings.pilotCheckoutNotesHint,
                      maxLines: 2,
                      textInputAction: TextInputAction.newline,
                      onChanged: (notes) =>
                          onIntent(CheckoutNotesChanged(notes)),
                    ),
                  ],
                ),
              ),
              if (state.isVoucherAvailable)
                _PhoneSection(
                  title: strings.pilotCheckoutVoucher,
                  icon: Icons.local_offer_outlined,
                  child: CheckoutVoucherSelector(
                    state: state,
                    onIntent: onIntent,
                  ),
                ),
              _PhoneSection(
                title: strings.checkoutOrderDetailsTitle,
                icon: Icons.receipt_long_outlined,
                child: CheckoutOrderSummary(state: state, pricesOnly: true),
              ),
              _PhoneSection(
                title: strings.checkoutPaymentMethodTitle,
                icon: Icons.payments_outlined,
                child: const CheckoutPaymentMethod(),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ],
    );
  }
}

class CheckoutPriceStatus extends StatelessWidget {
  const CheckoutPriceStatus.loading({super.key})
    : isLoading = true,
      onRetry = null;

  const CheckoutPriceStatus.error({super.key, required this.onRetry})
    : isLoading = false;

  final bool isLoading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final text = isLoading
        ? strings.checkoutLoadingPrice
        : strings.checkoutErrorPrice;
    return Semantics(
      liveRegion: true,
      button: onRetry != null,
      label: text,
      child: Material(
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
                  const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Icon(
                    Icons.warning_amber_rounded,
                    color: scheme.onErrorContainer,
                  ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text(text)),
                if (!isLoading)
                  Icon(Icons.refresh, color: scheme.onErrorContainer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckoutRestaurantSummary extends StatelessWidget {
  const CheckoutRestaurantSummary({
    super.key,
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
      Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          Icons.storefront_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              S
                  .of(context)
                  .pilotCheckoutRestaurantItems(distinctItems, itemCount),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class CheckoutDeliveryAddress extends StatelessWidget {
  const CheckoutDeliveryAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final CheckoutAddressViewData? address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final value = address;
    return Semantics(
      button: true,
      label: value?.fullAddress ?? strings.pilotCheckoutSelectAddress,
      child: InkWell(
        key: const Key('checkout_address_selector'),
        onTap: onTap,
        borderRadius: AppRadii.control,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: value == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.pilotCheckoutSelectAddress,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            strings.pilotCheckoutSelectAddressMessage,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                value.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              if (value.isDefault) ...[
                                const SizedBox(width: AppSpacing.xs),
                                AppBadge(
                                  label: strings.pilotCheckoutDefault,
                                  tone: AppBadgeTone.accent,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${value.recipientName} · ${value.phoneNumber}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            value.fullAddress,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(width: AppSpacing.xs),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9EA7B2),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckoutPaymentMethod extends StatelessWidget {
  const CheckoutPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F8F5),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.payments_rounded,
            color: Color(0xFF27AE60),
            size: 20,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.pilotCheckoutCash,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                strings.pilotCheckoutCashMessage,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.check_circle_rounded,
          color: Color(0xFF27AE60),
          size: 22,
        ),
      ],
    );
  }
}

class CheckoutVoucherSelector extends StatelessWidget {
  const CheckoutVoucherSelector({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    if (state.isVoucherLoading) {
      return AppStateFeedback.loading(title: strings.loading);
    }
    if (state.hasVoucherError) {
      return Row(
        children: [
          Expanded(child: Text(strings.pilotCheckoutVoucherError)),
          AppButton(
            key: const Key('checkout_voucher_retry'),
            label: strings.retry,
            variant: AppButtonVariant.quiet,
            onPressed: () => onIntent(const CheckoutVoucherRetryRequested()),
          ),
        ],
      );
    }
    return Column(
      key: const Key('checkout_voucher_selector'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          key: const Key('checkout_voucher_code'),
          label: strings.pilotCheckoutVoucherInput,
          helperText: strings.pilotCheckoutVoucherHelper,
          textCapitalization: TextCapitalization.characters,
          onSubmitted: (code) => onIntent(CheckoutVoucherCodeSubmitted(code)),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (state.isVoucherStackingAvailable)
          _StackingVoucherChoices(state: state, onIntent: onIntent)
        else
          _SingleVoucherChoices(state: state, onIntent: onIntent),
        const SizedBox(height: AppSpacing.xs),
        Text(
          strings.pilotCheckoutVoucherFlashSale,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _StackingVoucherChoices extends StatelessWidget {
  const _StackingVoucherChoices({required this.state, required this.onIntent});

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<String>(
          segments: [
            ButtonSegment<String>(
              value: 'AUTO',
              label: Text(strings.pilotCheckoutVoucherAuto),
            ),
            ButtonSegment<String>(
              value: 'MANUAL',
              label: Text(strings.pilotCheckoutVoucherManual),
            ),
          ],
          selected: {state.selectionMode},
          onSelectionChanged: (value) =>
              onIntent(CheckoutVoucherModeChanged(value.first)),
        ),
        const SizedBox(height: AppSpacing.xs),
        if (state.selectionMode == 'AUTO')
          Text(strings.pilotCheckoutVoucherAutoMessage)
        else if (state.vouchers.isEmpty)
          Text(strings.pilotCheckoutVoucherEmpty)
        else
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
      ],
    );
  }
}

class _SingleVoucherChoices extends StatelessWidget {
  const _SingleVoucherChoices({required this.state, required this.onIntent});

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(S.of(context).pilotCheckoutVoucherSingleMessage),
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
      if (state.vouchers.isEmpty) Text(S.of(context).pilotCheckoutVoucherEmpty),
    ],
  );
}

class CheckoutOrderSummary extends StatelessWidget {
  const CheckoutOrderSummary({
    super.key,
    required this.state,
    this.linesOnly = false,
    this.pricesOnly = false,
  });

  final CheckoutViewState state;
  final bool linesOnly;
  final bool pricesOnly;

  @override
  Widget build(BuildContext context) {
    final price = state.price;
    final strings = S.of(context);
    return Column(
      children: [
        if (!pricesOnly)
          for (final line in state.lines)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${line.quantity}×',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      line.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Text(
                    _currency(line.lineTotal),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
        if (!linesOnly) ...[
          const Divider(color: Color(0xFFEDEFF2), height: 20, thickness: 1),
          CheckoutPriceRow(
            label: strings.checkoutSubtotal,
            value: price?.subtotal,
          ),
          const SizedBox(height: AppSpacing.xs),
          CheckoutPriceRow(
            label: strings.checkoutShippingFee,
            value: price?.shippingFee,
          ),
          if (price != null && price.discountAmount > 0) ...[
            const SizedBox(height: AppSpacing.xs),
            CheckoutPriceRow(
              label: strings.checkoutDiscount,
              value: -price.discountAmount,
              isDiscount: true,
            ),
          ],
          if (price != null && price.appliedVouchers.isNotEmpty)
            for (final voucher in price.appliedVouchers) ...[
              const SizedBox(height: AppSpacing.xs),
              CheckoutPriceRow(
                label: '${voucher.code} · ${voucher.layer}',
                value: voucher.discountAmount,
                isDiscount: true,
              ),
            ],
          const Divider(color: Color(0xFFEDEFF2), height: 20, thickness: 1),
          CheckoutPriceRow(
            label: strings.checkoutTotal,
            value: price?.total,
            isEmphasized: true,
          ),
        ],
      ],
    );
  }
}

class CheckoutPriceRow extends StatelessWidget {
  const CheckoutPriceRow({
    super.key,
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
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Text(
          label,
          style: isEmphasized
              ? TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onSurface,
                )
              : TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Text(
        value == null
            ? '—'
            : '${isDiscount ? '−' : ''}${_currency(value!.abs())}',
        style: TextStyle(
          fontWeight: isEmphasized ? FontWeight.w800 : FontWeight.w700,
          fontSize: isEmphasized ? 17 : 14,
          color: isDiscount ? const Color(0xFF27AE60) : const Color(0xFF1A1D20),
        ),
      ),
    ],
  );
}

class CheckoutStickyAction extends StatelessWidget {
  const CheckoutStickyAction({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final CheckoutViewState state;
  final ValueChanged<CheckoutIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final price = state.price;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    strings.checkoutTotal,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    price == null ? '—' : _currency(price.total),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Semantics(
                label: strings.pilotCheckoutPlaceOrder,
                child: FilledButton(
                  key: const Key('checkout_place_order'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(120, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: state.canPlaceOrder
                      ? () => onIntent(const CheckoutPlaceOrderRequested())
                      : null,
                  child: state.isPlacingOrder
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          state.isPreviewLoading
                              ? strings.checkoutLoadingPrice
                              : strings.checkoutOrderBtn,
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _currency(double value) => '${value.toStringAsFixed(0)} ₫';

/// Flat, separated blocks matching the web phone checkout hierarchy.
class _PhoneSection extends StatelessWidget {
  const _PhoneSection({
    required this.title,
    required this.icon,
    required this.child,
  });
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(16),
    color: Theme.of(context).colorScheme.surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}
