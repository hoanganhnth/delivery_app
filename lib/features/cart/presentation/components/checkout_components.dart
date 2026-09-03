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
            padding: const EdgeInsets.all(AppSpacing.page),
            children: [
              AppSection(
                title: strings.pilotCheckoutRestaurant,
                icon: Icons.restaurant_outlined,
                child: CheckoutRestaurantSummary(
                  name: state.restaurantName ?? strings.restaurants,
                  itemCount: state.itemCount,
                  distinctItems: state.lines.length,
                ),
              ),
              AppSection(
                title: strings.checkoutDeliveryAddress,
                icon: Icons.location_on_outlined,
                child: CheckoutDeliveryAddress(
                  address: state.selectedAddress,
                  onTap: () =>
                      onIntent(const CheckoutAddressSelectionRequested()),
                ),
              ),
              AppSection(
                title: strings.checkoutPaymentMethodTitle,
                icon: Icons.payments_outlined,
                child: const CheckoutPaymentMethod(),
              ),
              if (state.isVoucherAvailable)
                AppSection(
                  title: strings.pilotCheckoutVoucher,
                  icon: Icons.local_offer_outlined,
                  child: CheckoutVoucherSelector(
                    state: state,
                    onIntent: onIntent,
                  ),
                ),
              AppSection(
                title: strings.checkoutOrderDetailsTitle,
                icon: Icons.receipt_long_outlined,
                child: CheckoutOrderSummary(state: state),
              ),
              AppSection(
                title: strings.checkoutNotesTitle,
                icon: Icons.note_outlined,
                child: AppTextField(
                  key: const Key('checkout_notes'),
                  controller: notesController,
                  semanticLabel: strings.checkoutNotesTitle,
                  hintText: strings.pilotCheckoutNotesHint,
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  onChanged: (notes) => onIntent(CheckoutNotesChanged(notes)),
                ),
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
      DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: AppRadii.control,
        ),
        child: const SizedBox.square(
          dimension: 48,
          child: Icon(Icons.restaurant_outlined),
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              S
                  .of(context)
                  .pilotCheckoutRestaurantItems(distinctItems, itemCount),
              style: Theme.of(context).textTheme.bodySmall,
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
              Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: value == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.pilotCheckoutSelectAddress,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(strings.pilotCheckoutSelectAddressMessage),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: AppSpacing.xs,
                            runSpacing: AppSpacing.xxs,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                value.label,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              if (value.isDefault)
                                AppBadge(
                                  label: strings.pilotCheckoutDefault,
                                  tone: AppBadgeTone.accent,
                                ),
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
        const Icon(Icons.payments_outlined),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.pilotCheckoutCash,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(strings.pilotCheckoutCashMessage),
            ],
          ),
        ),
        Icon(Icons.check_circle, color: context.semanticColors.success),
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
  const CheckoutOrderSummary({super.key, required this.state});

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
                Text(
                  '${line.quantity}×',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text(line.name)),
                Text(_currency(line.lineTotal)),
              ],
            ),
          ),
        const Divider(),
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
        const Divider(),
        CheckoutPriceRow(
          label: strings.checkoutTotal,
          value: price?.total,
          isEmphasized: true,
        ),
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
              ? const TextStyle(fontWeight: FontWeight.w800)
              : null,
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Text(
        value == null
            ? '—'
            : '${isDiscount ? '−' : ''}${_currency(value!.abs())}',
        style: TextStyle(
          fontWeight: isEmphasized ? FontWeight.w800 : FontWeight.w500,
          color: isDiscount ? context.semanticColors.success : null,
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
    return AppStickyAction(
      summary: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            strings.checkoutTotal,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          Text(
            price == null ? '—' : _currency(price.total),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      child: AppButton(
        key: const Key('checkout_place_order'),
        label: state.isPreviewLoading
            ? strings.checkoutLoadingPrice
            : strings.checkoutOrderBtn,
        semanticLabel: strings.pilotCheckoutPlaceOrder,
        isLoading: state.isPlacingOrder,
        onPressed: state.canPlaceOrder
            ? () => onIntent(const CheckoutPlaceOrderRequested())
            : null,
        expand: true,
      ),
    );
  }
}

String _currency(double value) => '${value.toStringAsFixed(0)} ₫';
