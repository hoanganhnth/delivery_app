import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/domain/entities/consumable_entity.dart';
import 'package:delivery_app/features/iap/presentation/providers/consumable_notifier.dart';
import 'package:delivery_app/features/iap/presentation/providers/consumable_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen for purchasing consumable products (credits, vouchers)
class ConsumableScreen extends ConsumerWidget {
  const ConsumableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(consumableProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits & Vouchers'),
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
      ),
      body: stateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(consumableProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (state) => _buildContent(context, ref, state),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ConsumableState state,
  ) {
    // Show success message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        ref.read(consumableProvider.notifier).clearSuccessMessage();
      }

      // Show error message
      if (state.failure != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.failure!.message),
            backgroundColor: Colors.red,
          ),
        );
        ref.read(consumableProvider.notifier).clearError();
      }
    });

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(consumableProvider.notifier).loadProducts(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Credits Balance Card
          _buildCreditsBalanceCard(context, state),
          const SizedBox(height: 24),

          // Credits Products Section
          if (state.creditProducts.isNotEmpty) ...[
            _buildSectionHeader(context, '🚗 Delivery Credits'),
            const SizedBox(height: 12),
            ...state.creditProducts.map((product) => _buildConsumableCard(
                  context,
                  ref,
                  product,
                  state.isLoading,
                )),
            const SizedBox(height: 24),
          ],

          // Voucher Products Section
          if (state.voucherProducts.isNotEmpty) ...[
            _buildSectionHeader(context, '🏷️ Vouchers'),
            const SizedBox(height: 12),
            ...state.voucherProducts.map((product) => _buildConsumableCard(
                  context,
                  ref,
                  product,
                  state.isLoading,
                )),
            const SizedBox(height: 24),
          ],

          // Gift Card Products Section
          if (state.giftCardProducts.isNotEmpty) ...[
            _buildSectionHeader(context, '🎁 Gift Cards'),
            const SizedBox(height: 12),
            ...state.giftCardProducts.map((product) => _buildConsumableCard(
                  context,
                  ref,
                  product,
                  state.isLoading,
                )),
            const SizedBox(height: 24),
          ],

          // User Vouchers Section
          if (state.userVouchers.isNotEmpty) ...[
            _buildSectionHeader(context, '📦 My Vouchers'),
            const SizedBox(height: 12),
            ...state.userVouchers.map(
                (voucher) => _buildUserVoucherCard(context, ref, voucher)),
          ],
        ],
      ),
    );
  }

  Widget _buildCreditsBalanceCard(BuildContext context, ConsumableState state) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              context.colors.primary,
              context.colors.primary.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet,
                    color: Colors.white, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Credits Balance',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${state.creditsBalance}',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Delivery Credits',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildConsumableCard(
    BuildContext context,
    WidgetRef ref,
    ConsumableEntity product,
    bool isLoading,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  product.type.icon,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.product.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.product.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+${product.value.toInt()} ${product.type.displayName}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Price & Buy Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.product.price,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => ref
                          .read(consumableProvider.notifier)
                          .purchaseConsumable(product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.primary,
                    foregroundColor: context.colors.onPrimary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Buy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserVoucherCard(
    BuildContext context,
    WidgetRef ref,
    ConsumableEntity voucher,
  ) {
    final isExpired = voucher.isExpired;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isExpired ? Colors.grey[200] : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Voucher Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isExpired
                    ? Colors.grey[400]
                    : context.colors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  voucher.type.icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Voucher Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.product.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isExpired ? Colors.grey : null,
                    ),
                  ),
                  if (voucher.code != null)
                    Text(
                      'Code: ${voucher.code}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  if (voucher.expiryDate != null)
                    Text(
                      isExpired
                          ? 'Expired'
                          : 'Expires: ${_formatDate(voucher.expiryDate!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isExpired ? Colors.red : Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),

            // Value
            Text(
              voucher.type == ConsumableType.discountVoucher
                  ? '${voucher.value.toInt()}% OFF'
                  : '-\$${voucher.value.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isExpired ? Colors.grey : context.colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
