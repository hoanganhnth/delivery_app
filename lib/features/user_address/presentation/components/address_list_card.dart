import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/address_list_state.dart';

/// Reusable, Riverpod-free address row used by the address-list view.
class AddressListCard extends StatelessWidget {
  const AddressListCard({
    super.key,
    required this.address,
    required this.isSelected,
    required this.isBusy,
    this.isSelectMode = false,
    required this.onSelect,
    required this.onEdit,
    required this.onSetDefault,
    required this.onDelete,
  });

  final AddressListItemViewData address;
  final bool isSelected;
  final bool isBusy;
  final bool isSelectMode;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final active = isSelectMode && isSelected;
    return Card(
      elevation: 0,
      color: active ? scheme.primary.withValues(alpha: 0.05) : scheme.surface,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: active ? scheme.primary : scheme.outlineVariant,
          width: active ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: isBusy
            ? null
            : isSelectMode
            ? onSelect
            : onEdit,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AddressIcon(label: address.label, isDefault: address.isDefault),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _AddressDetails(address: address, isSelected: active),
              ),
              if (!isBusy)
                IconButton(
                  key: ValueKey('address_edit_${address.id}'),
                  onPressed: onEdit,
                  tooltip: S.of(context).addressEditTitle,
                  icon: const Icon(Icons.edit_outlined, size: 20),
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
      decoration: BoxDecoration(color: Colors.transparent),
      child: SizedBox(
        width: 24,
        height: 24,
        child: Icon(icon, color: scheme.onSurfaceVariant, size: 20),
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
        Text(
          address.recipientName,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        if (address.phoneNumber.trim().isNotEmpty)
          Text(
            address.phoneNumber,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        const SizedBox(height: 6),
        Text(
          address.fullAddress,
          style: theme.textTheme.bodySmall?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xxs,
          children: [
            Text(
              address.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
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
      borderRadius: BorderRadius.circular(2),
      border: Border.all(color: foreground),
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
