import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';

/// Widget form địa chỉ giao hàng trong checkout
class DeliveryAddressCard extends StatelessWidget {
  final TextEditingController addressController;

  const DeliveryAddressCard({
    super.key,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TextFormField(
              controller: addressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Địa chỉ giao hàng',
                hintText:
                    'Nhập địa chỉ chi tiết: số nhà, đường, phường, quận...',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 40.w),
                  child: Icon(Icons.location_on_outlined),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Vui lòng nhập địa chỉ giao hàng';
                }
                return null;
              },
            ),
            SizedBox(height: 12.w),
            InkWell(
              onTap: () {
                // TODO: Open map to select location
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Tính năng chọn vị trí trên bản đồ sẽ được cập nhật sớm',
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, color: context.colors.primary),
                    SizedBox(width: 8.w),
                    Text(
                      'Chọn vị trí trên bản đồ',
                      style: TextStyle(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
