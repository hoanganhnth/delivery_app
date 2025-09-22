import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/routing/navigation_helper.dart';
import '../../../user_address/domain/entities/user_address_entity.dart';
import '../../../user_address/presentation/providers/user_address_providers.dart';
import '../../../profile/presentation/providers/profile_providers.dart';

/// Widget hiển thị địa chỉ giao hàng được chọn hoặc button để chọn địa chỉ
class SelectedAddressCard extends ConsumerStatefulWidget {
  final TextEditingController? addressController;
  final Function(UserAddressEntity?)? onAddressSelected;

  const SelectedAddressCard({
    super.key,
    this.addressController,
    this.onAddressSelected,
  });

  @override
  ConsumerState<SelectedAddressCard> createState() => _SelectedAddressCardState();
}

class _SelectedAddressCardState extends ConsumerState<SelectedAddressCard> {
  @override
  void initState() {
    super.initState();
    // Load addresses when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAddresses();
    });
  }

  void _loadAddresses() {
    final user = ref.read(profileStateProvider).user;
    if (user?.id != null) {
      ref.read(userAddressListProvider.notifier).loadAddresses(user!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(userAddressListProvider);
    final selectedAddress = addressState.selectedAddress ?? 
        addressState.addresses.where((addr) => addr.isDefault).firstOrNull;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _navigateToAddressList(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: selectedAddress != null
              ? _buildSelectedAddress(context, selectedAddress)
              : _buildNoAddressState(context),
        ),
      ),
    );
  }

  Widget _buildSelectedAddress(BuildContext context, UserAddressEntity address) {
    // Tự động fill vào address controller nếu có
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.addressController != null) {
        final fullAddress = _buildFullAddressString(address);
        if (widget.addressController!.text != fullAddress) {
          widget.addressController!.text = fullAddress;
        }
      }
      widget.onAddressSelected?.call(address);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header với icon và action
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: context.colors.primary,
              size: 20,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Địa chỉ giao hàng',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            Text(
              'Thay đổi',
              style: TextStyle(
                fontSize: 14.sp,
                color: context.colors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: context.colors.primary,
            ),
          ],
        ),
        
        SizedBox(height: 12.w),
        
        // Address info
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Default label nếu là địa chỉ mặc định
            if (address.isDefault) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Mặc định',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
            ],
            
            // Address label
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: context.colors.outline),
              ),
              child: Text(
                address.label,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: context.colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(height: 8.w),
        
        // Recipient name and phone
        Text(
          '${address.recipientName} | ${address.phoneNumber}',
          style: TextStyle(
            fontSize: 14.sp,
            color: context.colors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        
        SizedBox(height: 4.w),
        
        // Full address
        Text(
          _buildFullAddressString(address),
          style: TextStyle(
            fontSize: 14.sp,
            color: context.colors.textSecondary,
            height: 1.4,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildNoAddressState(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: context.colors.textSecondary,
              size: 24,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chọn địa chỉ giao hàng',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    'Vui lòng chọn địa chỉ để tiếp tục đặt hàng',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: context.colors.primary,
            ),
          ],
        ),
      ],
    );
  }

  String _buildFullAddressString(UserAddressEntity address) {
    final parts = <String>[];
    
    if (address.addressLine.isNotEmpty) {
      parts.add(address.addressLine);
    }
    if (address.ward.isNotEmpty) {
      parts.add(address.ward);
    }
    if (address.district.isNotEmpty) {
      parts.add(address.district);
    }
    if (address.city.isNotEmpty) {
      parts.add(address.city);
    }
    
    return parts.join(', ');
  }

  void _navigateToAddressList(BuildContext context) {
    context.pushAddressList();
  }
}
