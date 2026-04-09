import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import '../../domain/entities/user_address_entity.dart';

/// Address Card Widget - Editorial style với icon tự động, popup menu, và default badge
class AddressCard extends ConsumerWidget {
  final UserAddressEntity address;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const AddressCard({
    super.key,
    required this.address,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    final isDefault = address.isDefault;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(ResponsiveSize.radiusL),
          border: isDefault
              ? Border.all(color: colors.primary, width: 2)
              : Border.all(color: colors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: colors.shadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _AddressCardHeader(
              address: address,
              isDefault: isDefault,
              onEdit: onEdit,
              onSetDefault: onSetDefault,
              onDelete: onDelete,
            ),

            // Divider
            Divider(height: 1, color: colors.divider),

            // Address details
            _AddressCardDetails(address: address),
          ],
        ),
      ),
    );
  }
}

/// Header với icon, label, default badge, và popup menu
class _AddressCardHeader extends ConsumerWidget {
  final UserAddressEntity address;
  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  const _AddressCardHeader({
    required this.address,
    required this.isDefault,
    required this.onEdit,
    required this.onSetDefault,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;

    return Padding(
      padding: EdgeInsets.all(ResponsiveSize.m),
      child: Row(
        children: [
          // Icon
          _AddressIconBox(label: address.label),
          SizedBox(width: ResponsiveSize.m),
          
          // Label & Default badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address.label,
                      style: TextStyle(
                        fontSize: ResponsiveSize.fontL,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    if (isDefault) ...[
                      SizedBox(width: ResponsiveSize.s),
                      _DefaultBadge(),
                    ],
                  ],
                ),
                if (address.recipientName.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    address.recipientName,
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontS,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // More options
          _AddressPopupMenu(
            isDefault: isDefault,
            onEdit: onEdit,
            onSetDefault: onSetDefault,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}

/// Icon box với màu tự động theo loại địa chỉ
class _AddressIconBox extends ConsumerWidget {
  final String label;

  const _AddressIconBox({required this.label});

  IconData _getAddressIcon() {
    final lowerLabel = label.toLowerCase();
    if (lowerLabel.contains('nhà') || lowerLabel.contains('home')) {
      return Icons.home_outlined;
    } else if (lowerLabel.contains('công ty') ||
        lowerLabel.contains('office') ||
        lowerLabel.contains('work')) {
      return Icons.business_outlined;
    } else if (lowerLabel.contains('trường') ||
        lowerLabel.contains('school')) {
      return Icons.school_outlined;
    }
    return Icons.location_on_outlined;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
      ),
      child: Icon(
        _getAddressIcon(),
        color: colors.primary,
        size: 22.w,
      ),
    );
  }
}

/// Badge "Mặc định"
class _DefaultBadge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.s,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusS),
      ),
      child: Text(
        'Mặc định',
        style: TextStyle(
          fontSize: ResponsiveSize.fontXs,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Popup menu cho edit/set default/delete
class _AddressPopupMenu extends ConsumerWidget {
  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  const _AddressPopupMenu({
    required this.isDefault,
    required this.onEdit,
    required this.onSetDefault,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: colors.textSecondary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
      ),
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit();
            break;
          case 'default':
            onSetDefault();
            break;
          case 'delete':
            onDelete();
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 20.w),
              SizedBox(width: ResponsiveSize.s),
              const Text('Chỉnh sửa'),
            ],
          ),
        ),
        if (!isDefault)
          PopupMenuItem(
            value: 'default',
            child: Row(
              children: [
                Icon(Icons.star_outline, size: 20.w),
                SizedBox(width: ResponsiveSize.s),
                const Text('Đặt mặc định'),
              ],
            ),
          ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 20.w, color: colors.error),
              SizedBox(width: ResponsiveSize.s),
              Text('Xóa', style: TextStyle(color: colors.error)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Chi tiết địa chỉ (phone + full address)
class _AddressCardDetails extends ConsumerWidget {
  final UserAddressEntity address;

  const _AddressCardDetails({required this.address});

  String _buildFullAddress() {
    final parts = <String>[];
    if (address.addressLine.isNotEmpty) parts.add(address.addressLine);
    if (address.ward.isNotEmpty) parts.add(address.ward);
    if (address.district.isNotEmpty) parts.add(address.district);
    if (address.city.isNotEmpty) parts.add(address.city);
    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;
    return Padding(
      padding: EdgeInsets.all(ResponsiveSize.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phone
          if (address.phoneNumber.isNotEmpty) ...[
            Row(
              children: [
                Icon(Icons.phone_outlined,
                    size: 16.w, color: colors.textSecondary),
                SizedBox(width: ResponsiveSize.s),
                Text(
                  address.phoneNumber,
                  style: TextStyle(
                    fontSize: ResponsiveSize.fontM,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: ResponsiveSize.s),
          ],
          // Full address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on_outlined,
                  size: 16.w, color: colors.textSecondary),
              SizedBox(width: ResponsiveSize.s),
              Expanded(
                child: Text(
                  _buildFullAddress(),
                  style: TextStyle(
                    fontSize: ResponsiveSize.fontM,
                    color: colors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
