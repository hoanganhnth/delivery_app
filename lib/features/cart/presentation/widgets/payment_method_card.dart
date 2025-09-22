import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../orders/domain/entities/order_entity.dart';

/// Widget chọn phương thức thanh toán trong checkout
class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod selectedPaymentMethod;
  final ValueChanged<PaymentMethod> onPaymentMethodChanged;

  const PaymentMethodCard({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
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
            _buildPaymentOption(
              context,
              PaymentMethod.cod,
              'Tiền mặt (COD)',
              'Thanh toán khi nhận hàng',
              Icons.payments,
            ),
            const Divider(),
            _buildPaymentOption(
              context,
              PaymentMethod.wallet,
              'Thanh toán online',
              'Thẻ tín dụng, ví điện tử...',
              Icons.credit_card,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    PaymentMethod method,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return RadioListTile<PaymentMethod>(
      value: method,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        if (value != null) {
          onPaymentMethodChanged(value);
        }
      },
      title: Row(
        children: [
          Icon(icon, color: context.colors.primary),
          SizedBox(width: 8.w),
          Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
      subtitle: Text(subtitle),
      contentPadding: EdgeInsets.zero,
    );
  }
}
