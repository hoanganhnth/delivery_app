import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_restaurant_detail_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CatalogRestaurantHero extends StatelessWidget {
  const CatalogRestaurantHero({super.key, required this.restaurant});

  final CatalogRestaurantDetailData restaurant;

  @override
  Widget build(BuildContext context) => AppContentImage(
    imageUrl: restaurant.imageUrl,
    semanticLabel: S.of(context).pilotRestaurantImage(restaurant.name),
    borderRadius: BorderRadius.zero,
  );
}

class CatalogRestaurantInfo extends StatelessWidget {
  const CatalogRestaurantInfo({super.key, required this.restaurant});

  final CatalogRestaurantDetailData restaurant;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final openingHours =
        restaurant.openingHour != null && restaurant.closingHour != null
            ? '${restaurant.openingHour} – ${restaurant.closingHour}'
            : strings.pilotRestaurantOpeningUnknown;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
        ),
        padding: const EdgeInsets.all(AppSpacing.card),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (restaurant.description?.trim().isNotEmpty == true) ...[
              const SizedBox(height: 6),
              Text(restaurant.description!),
            ],
            if (restaurant.rating != null ||
                restaurant.deliveryTimeMinutes != null) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: [
                  if (restaurant.rating != null)
                    Text(
                      '★ ${restaurant.rating!.toStringAsFixed(1)}'
                      '${restaurant.reviewCount == null ? '' : ' (${restaurant.reviewCount})'}',
                    ),
                  if (restaurant.deliveryTimeMinutes != null)
                    Text('${restaurant.deliveryTimeMinutes} ${strings.min}'),
                ],
              ),
            ],
            const SizedBox(height: 10),
            _InfoRow(
              icon: Icons.location_on_outlined,
              color: scheme.primary,
              child: Text(
                restaurant.address,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Divider(height: 1, color: Color(0xFFF3F4F6)),
            ),
            _InfoRow(
              icon: Icons.schedule_rounded,
              color: const Color(0xFF757F8A),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      openingHours,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  if (restaurant.isOpen != null)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color:
                            restaurant.isOpen!
                                ? const Color(0xFFE8F8F5)
                                : const Color(0xFFF0F2F5),
                        borderRadius: AppRadii.pillRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        child: Text(
                          restaurant.isOpen!
                              ? strings.pilotRestaurantOpen
                              : strings.pilotRestaurantClosed,
                          style: TextStyle(
                            color:
                                restaurant.isOpen!
                                    ? const Color(0xFF27AE60)
                                    : const Color(0xFF757F8A),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.color,
    required this.child,
  });

  final IconData icon;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: color, size: 20),
      const SizedBox(width: AppSpacing.sm),
      Expanded(child: child),
    ],
  );
}

class CatalogMenuItemCard extends StatelessWidget {
  const CatalogMenuItemCard({
    super.key,
    required this.item,
    required this.onIntent,
    this.onOpen,
  });

  final CatalogMenuItemViewData item;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final statusText = switch (item.availability) {
      CatalogMenuAvailability.soldOut => strings.outOfStock,
      CatalogMenuAvailability.unavailable => strings.unavailable,
      CatalogMenuAvailability.available => null,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: 0,
      ),
      child: Opacity(
        opacity: item.isAvailable ? 1 : 0.62,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: InkWell(
            onTap: onOpen,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: AppContentImage(
                    imageUrl: item.imageUrl,
                    semanticLabel: strings.pilotRestaurantImage(item.name),
                    width: 95,
                    height: 95,
                    borderRadius: BorderRadius.zero,
                    placeholderIcon: Icons.fastfood_outlined,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _MenuPrice(item: item),
                          if (statusText != null)
                            AppBadge(
                              label: statusText,
                              tone: AppBadgeTone.warning,
                            )
                          else
                            _QuantityControl(item: item, onIntent: onIntent),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CatalogMenuItemSheet extends StatefulWidget {
  const CatalogMenuItemSheet({
    super.key,
    required this.item,
    required this.onClose,
    required this.onAdd,
    this.onAddWithDetails,
  });
  final CatalogMenuItemViewData item;
  final VoidCallback onClose;
  final void Function(int quantity, String? notes) onAdd;
  final void Function(int quantity, String? notes)? onAddWithDetails;

  @override
  State<CatalogMenuItemSheet> createState() => _CatalogMenuItemSheetState();
}

class _CatalogMenuItemSheetState extends State<CatalogMenuItemSheet> {
  late final TextEditingController _notesController;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.sizeOf(context).height * 0.85,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.item.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                icon: const Icon(Icons.close),
                onPressed: widget.onClose,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppContentImage(
                  imageUrl: widget.item.imageUrl,
                  semanticLabel: widget.item.name,
                  height: 230,
                  borderRadius: BorderRadius.zero,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formattedDescription(widget.item),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF888888),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _sheetMoney(widget.item.displayedPrice),
                        style: const TextStyle(
                          color: Color(0xFFEE4D2D),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 22),
                      const Text('Ghi chú', style: TextStyle(fontSize: 12)),
                      TextField(
                        key: const Key('catalog_item_sheet_note'),
                        controller: _notesController,
                        maxLength: 500,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          hintText: 'Ít cay, không hành…',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFAAAAAA),
                          ),
                          counterText: '',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _SheetQuantityControl(
                  quantity: _quantity,
                  onDecrement:
                      _quantity <= 1
                          ? null
                          : () => setState(() => _quantity -= 1),
                  onIncrement: () => setState(() => _quantity += 1),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: AppButton(
                    key: const Key('catalog_item_sheet_add'),
                    expand: true,
                    label:
                        widget.item.isAvailable
                            ? 'Thêm · ${_sheetMoney(widget.item.displayedPrice * _quantity)}'
                            : widget.item.availability ==
                                CatalogMenuAvailability.soldOut
                            ? S.of(context).outOfStock
                            : S.of(context).unavailable,
                    onPressed:
                        widget.item.canAdd
                            ? () {
                              final notes = _notesController.text.trim();
                              if (widget.onAddWithDetails != null) {
                                widget.onAddWithDetails!(
                                  _quantity,
                                  notes.isEmpty ? null : notes,
                                );
                              } else {
                                widget.onAdd(
                                  _quantity,
                                  notes.isEmpty ? null : notes,
                                );
                              }
                            }
                            : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _SheetQuantityControl extends StatelessWidget {
  const _SheetQuantityControl({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback? onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) => Container(
    height: 44,
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFDDDDDD)),
      borderRadius: BorderRadius.circular(3),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          key: const Key('catalog_item_sheet_decrement'),
          tooltip: 'Giảm số lượng',
          onPressed: onDecrement,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 31, height: 42),
          icon: const Icon(Icons.remove, size: 15, color: Color(0xFFEE4D2D)),
        ),
        SizedBox(
          width: 22,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
          key: const Key('catalog_item_sheet_increment'),
          tooltip: 'Tăng số lượng',
          onPressed: onIncrement,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 31, height: 42),
          icon: const Icon(Icons.add, size: 15, color: Color(0xFFEE4D2D)),
        ),
      ],
    ),
  );
}

String _formattedDescription(CatalogMenuItemViewData item) =>
    item.description.trim().isEmpty
        ? 'Chuẩn vị, chế biến khi nhận đơn'
        : item.description;

String _sheetMoney(num value) =>
    '${NumberFormat('#,###', 'vi_VN').format(value)}đ';

class _MenuPrice extends StatelessWidget {
  const _MenuPrice({required this.item});

  final CatalogMenuItemViewData item;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (item.hasFlashSale)
        Text(
          '${item.catalogPrice.toStringAsFixed(0)} ₫',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      Text(
        '${item.displayedPrice.toStringAsFixed(0)} ₫',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    ],
  );
}

class _QuantityControl extends StatelessWidget {
  const _QuantityControl({required this.item, required this.onIntent});

  final CatalogMenuItemViewData item;
  final ValueChanged<CatalogRestaurantDetailIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.quantity > 0) ...[
          Semantics(
            button: true,
            enabled: true,
            label: strings.pilotRestaurantRemoveItem(item.name),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(3),
              ),
              child: IconButton(
                key: Key('menu_decrement_${item.id}'),
                tooltip: strings.pilotRestaurantRemoveItem(item.name),
                padding: EdgeInsets.zero,
                icon: Icon(
                  item.quantity > 1 ? Icons.remove : Icons.delete_outline,
                  size: 16,
                  color: scheme.onSurface,
                ),
                onPressed:
                    () => onIntent(
                      CatalogRestaurantDetailDecrementRequested(item.id!),
                    ),
              ),
            ),
          ),
          Semantics(
            label: '${item.quantity}',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${item.quantity}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
        Semantics(
          button: true,
          enabled: item.canAdd,
          label: strings.pilotRestaurantAddItem(item.name),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(3),
            ),
            child: IconButton(
              key: Key('menu_increment_${item.id}'),
              tooltip: strings.pilotRestaurantAddItem(item.name),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              onPressed:
                  item.canAdd
                      ? () => onIntent(
                        CatalogRestaurantDetailIncrementRequested(item.id!),
                      )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}

class CatalogRestaurantCartButton extends StatelessWidget {
  const CatalogRestaurantCartButton({
    super.key,
    required this.itemCount,
    required this.totalAmount,
    required this.onPressed,
  });

  final int itemCount;
  final double totalAmount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final isEmpty = itemCount == 0;
    final formattedTotal = '${totalAmount.toStringAsFixed(0)} ₫';
    return AppStickyAction(
      child: AppButton(
        label:
            isEmpty
                ? strings.pilotRestaurantEmptyCart
                : '${strings.pilotRestaurantViewCartLabel(itemCount)} · '
                    '$formattedTotal',
        semanticLabel:
            isEmpty
                ? strings.pilotRestaurantEmptyCart
                : '${strings.pilotRestaurantViewCart(itemCount)}, $formattedTotal',
        icon: Icons.shopping_bag_outlined,
        onPressed: isEmpty ? null : onPressed,
        expand: true,
      ),
    );
  }
}
