import 'package:delivery_app/features/cart/presentation/providers/checkout_voucher_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoucherSelectorCard extends ConsumerWidget {
  const VoucherSelectorCard({
    super.key,
    required this.restaurantId,
    required this.selectedVoucherId,
    required this.onChanged,
  });

  final int restaurantId;
  final int? selectedVoucherId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(checkoutVoucherWalletProvider);
    return wallet.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Row(
        children: [
          const Expanded(child: Text('Không thể tải ví voucher.')),
          TextButton(
            key: const Key('voucher-retry'),
            onPressed: () => ref.invalidate(checkoutVoucherWalletProvider),
            child: const Text('Thử lại'),
          ),
        ],
      ),
      data: (vouchers) {
        final applicable = vouchers
            .where((voucher) => voucher.appliesToRestaurant(restaurantId))
            .toList(growable: false);
        final value = applicable.any((item) => item.id == selectedVoucherId)
            ? selectedVoucherId
            : null;
        return DropdownButtonFormField<int?>(
          key: const Key('voucher-selector'),
          value: value,
          decoration: const InputDecoration(
            labelText: 'Chọn voucher',
            border: OutlineInputBorder(),
          ),
          items: [
            const DropdownMenuItem<int?>(
              value: null,
              child: Text('Không dùng voucher'),
            ),
            ...applicable.map(
              (voucher) => DropdownMenuItem<int?>(
                value: voucher.id,
                child: Text(
                  '${voucher.code} · ${voucher.displayBenefit}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
          onChanged: onChanged,
        );
      },
    );
  }
}
