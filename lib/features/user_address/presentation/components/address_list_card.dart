import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../../application/address_list_state.dart';

/// Reusable, Riverpod-free address row used by the address-list view.
class AddressListCard extends StatelessWidget {
  const AddressListCard({
    super.key,
    required this.address,
    required this.isSelected,
    required this.isBusy,
    required this.onSelect,
    required this.onEdit,
    required this.onSetDefault,
    required this.onDelete,
  });

  final AddressListItemViewData address;
  final bool isSelected;
  final bool isBusy;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.card,
        side: BorderSide(
          color: address.isDefault || isSelected
              ? scheme.primary
              : scheme.outlineVariant,
          width: address.isDefault || isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: isBusy ? null : onSelect,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.card),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AddressIcon(label: address.label, isDefault: address.isDefault),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _AddressDetails(
                  address: address,
                  isSelected: isSelected,
                ),
              ),
              if (isBusy)
                const Padding(
                  padding: EdgeInsets.all(AppSpacing.xs),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else
                PopupMenuButton<_AddressMenuAction>(
                  tooltip: 'Tùy chọn địa chỉ',
                  onSelected: (action) => switch (action) {
                    _AddressMenuAction.edit => onEdit(),
                    _AddressMenuAction.setDefault => onSetDefault(),
                    _AddressMenuAction.delete => onDelete(),
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: _AddressMenuAction.edit,
                      child: ListTile(
                        leading: Icon(Icons.edit_outlined),
                        title: Text('Chỉnh sửa'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    if (!address.isDefault)
                      const PopupMenuItem(
                        value: _AddressMenuAction.setDefault,
                        child: ListTile(
                          leading: Icon(Icons.star_outline),
                          title: Text('Đặt làm mặc định'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    const PopupMenuItem(
                      value: _AddressMenuAction.delete,
                      child: ListTile(
                        leading: Icon(Icons.delete_outline, color: Colors.red),
                        title: Text('Xóa', style: TextStyle(color: Colors.red)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _AddressMenuAction { edit, setDefault, delete }

class _AddressIcon extends StatelessWidget {
  const _AddressIcon({required this.label, required this.isDefault});

  final String label;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    final lowerCase = label.toLowerCase();
    final icon = lowerCase.contains('nhà') || lowerCase.contains('home')
        ? Icons.home_outlined
        : lowerCase.contains('công ty') ||
              lowerCase.contains('office') ||
              lowerCase.contains('work')
        ? Icons.business_outlined
        : lowerCase.contains('trường') || lowerCase.contains('school')
        ? Icons.school_outlined
        : Icons.location_on_outlined;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: AppRadii.control,
      ),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Icon(icon, color: scheme.onPrimaryContainer),
      ),
    );
  }
}

class _AddressDetails extends StatelessWidget {
  const _AddressDetails({required this.address, required this.isSelected});

  final AddressListItemViewData address;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xxs,
          children: [
            Text(
              address.label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            if (address.isDefault)
              _Pill(
                icon: Icons.star,
                text: 'Mặc định',
                background: scheme.primaryContainer,
                foreground: scheme.onPrimaryContainer,
              ),
            if (isSelected)
              _Pill(
                icon: Icons.check,
                text: 'Đã chọn',
                background: scheme.secondaryContainer,
                foreground: scheme.onSecondaryContainer,
              ),
          ],
        ),
        if (address.recipientName.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            address.phoneNumber.trim().isEmpty
                ? address.recipientName
                : '${address.recipientName} · ${address.phoneNumber}',
            style: theme.textTheme.bodyMedium,
          ),
        ],
        const SizedBox(height: AppSpacing.xs),
        Text(
          address.fullAddress,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.35,
          ),
        ),
        if (address.hasCoordinates) ...[
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.gps_fixed, size: 16, color: scheme.primary),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                'Đã định vị',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.primary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.icon,
    required this.text,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: background,
      borderRadius: AppRadii.pillRadius,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: foreground),
          const SizedBox(width: 3),
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}
