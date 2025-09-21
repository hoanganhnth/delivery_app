import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import '../../domain/entities/user_address_entity.dart';

class AddressItemWidget extends StatelessWidget {
  final UserAddressEntity address;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onSetDefault;

  const AddressItemWidget({
    super.key,
    required this.address,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
        child: Padding(
          padding: EdgeInsets.all(ResponsiveSize.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.orange,
                    size: ResponsiveSize.iconSize,
                  ),
                  SizedBox(width: ResponsiveSize.s),
                  Expanded(
                    child: Text(
                      address.label,
                      style: TextStyle(
                        fontSize: ResponsiveSize.fontL,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  if (address.isDefault)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveSize.s,
                        vertical: ResponsiveSize.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(ResponsiveSize.radiusS),
                      ),
                      child: Text(
                        'Mặc định',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveSize.fontXs,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(width: ResponsiveSize.s),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.grey[600],
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit?.call();
                          break;
                        case 'delete':
                          onDelete?.call();
                          break;
                        case 'set_default':
                          onSetDefault?.call();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Chỉnh sửa'),
                          ],
                        ),
                      ),
                      if (!address.isDefault)
                        const PopupMenuItem(
                          value: 'set_default',
                          child: Row(
                            children: [
                              Icon(Icons.star, size: 18),
                              SizedBox(width: 8),
                              Text('Đặt làm mặc định'),
                            ],
                          ),
                        ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Xóa', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: ResponsiveSize.s),
              Text(
                _getFullAddress(),
                style: TextStyle(
                  fontSize: ResponsiveSize.fontM,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (address.latitude != null && address.longitude != null) ...[
                SizedBox(height: ResponsiveSize.xs),
                Row(
                  children: [
                    Icon(
                      Icons.gps_fixed,
                      size: ResponsiveSize.fontS,
                      color: Colors.green,
                    ),
                    SizedBox(width: ResponsiveSize.xs),
                    Text(
                      'Đã định vị',
                      style: TextStyle(
                        fontSize: ResponsiveSize.fontS,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getFullAddress() {
    final parts = [
      address.addressLine,
      address.ward,
      address.district,
      address.city,
    ];
    
    return parts.where((part) => part.isNotEmpty).join(', ');
  }
}
