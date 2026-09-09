import 'package:delivery_app/features/user_address/application/address_list_state.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

const _addressPreviewAccent = Color(0xFFEE4D2D);

class AddressPreviewHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const AddressPreviewHeader({
    super.key,
    required this.title,
    required this.itemCount,
    required this.onBack,
    required this.onCart,
  });

  final String title;
  final int itemCount;
  final VoidCallback onBack;
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
    leading: IconButton(
      key: const Key('address_list_back'),
      tooltip: 'Quay lại',
      onPressed: onBack,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.arrow_back, color: _addressPreviewAccent),
    ),
    title: Text(
      title,
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
              key: const Key('address_list_cart_action'),
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
                    color: _addressPreviewAccent,
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

class AddressPreviewCard extends StatelessWidget {
  const AddressPreviewCard({
    super.key,
    required this.address,
    required this.isSelected,
    required this.isSelectMode,
    required this.onSelect,
    required this.onEdit,
  });

  final AddressListItemViewData address;
  final bool isSelected;
  final bool isSelectMode;
  final VoidCallback onSelect;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) => Material(
    color: isSelected
        ? PreviewUi.accentSurface(context, alpha: .06)
        : PreviewUi.surface(context),
    child: InkWell(
      onTap: isSelectMode ? onSelect : onEdit,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: _addressPreviewAccent)
              : Border(bottom: BorderSide(color: PreviewUi.divider(context))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Icon(
                _iconForLabel(address.label),
                color: PreviewUi.muted(context),
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.recipientName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (address.phoneNumber.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        address.phoneNumber,
                        style: TextStyle(
                          fontSize: 11,
                          color: PreviewUi.muted(context),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      address.fullAddress,
                      style: const TextStyle(fontSize: 12, height: 1.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Wrap(
                      spacing: 7,
                      runSpacing: 4,
                      children: [
                        _AddressTag(address.label),
                        if (address.isDefault)
                          const _AddressTag('Mặc định', accent: true),
                        if (isSelected)
                          const _AddressTag('Đã chọn', accent: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              key: ValueKey('address_preview_edit_${address.id}'),
              onPressed: onEdit,
              style: TextButton.styleFrom(
                foregroundColor: _addressPreviewAccent,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Sửa', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    ),
  );
}

class _AddressTag extends StatelessWidget {
  const _AddressTag(this.text, {this.accent = false});

  final String text;
  final bool accent;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: accent
          ? PreviewUi.accentSurface(context, alpha: .06)
          : PreviewUi.surface(context),
      border: Border.all(
        color: accent ? _addressPreviewAccent : PreviewUi.divider(context),
      ),
      borderRadius: BorderRadius.circular(1),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      child: Text(
        text,
        style: TextStyle(
          color: accent ? _addressPreviewAccent : PreviewUi.muted(context),
          fontSize: 10,
        ),
      ),
    ),
  );
}

IconData _iconForLabel(String label) {
  final lower = label.toLowerCase();
  if (lower.contains('nhà') || lower.contains('home')) {
    return Icons.home_outlined;
  }
  if (lower.contains('công ty') ||
      lower.contains('office') ||
      lower.contains('work')) {
    return Icons.business_outlined;
  }
  if (lower.contains('trường') || lower.contains('school')) {
    return Icons.school_outlined;
  }
  return Icons.location_on_outlined;
}
