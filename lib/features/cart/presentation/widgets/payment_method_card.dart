import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';

/// Widget chọn phương thức thanh toán trong checkout
class PaymentMethodCard extends ConsumerWidget {
  const PaymentMethodCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(Icons.payments, color: ref.colors.primary),
            SizedBox(width: 12.w),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tiền mặt (COD)',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text('Thanh toán khi nhận hàng'),
                ],
              ),
            ),
            const Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
