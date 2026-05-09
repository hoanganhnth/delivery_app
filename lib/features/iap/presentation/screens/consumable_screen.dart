import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/presentation/providers/consumable_notifier.dart';
import 'package:delivery_app/features/iap/presentation/providers/consumable_state.dart';
import 'package:delivery_app/features/iap/presentation/widgets/consumable_card.dart';
import 'package:delivery_app/features/iap/presentation/widgets/user_voucher_card.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen for purchasing consumable products (credits, vouchers)
class ConsumableScreen extends ConsumerWidget {
  const ConsumableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(consumableProvider);
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.iapCreditsVouchersTitle),
        backgroundColor: ref.colors.primary,
        foregroundColor: ref.colors.onPrimary,
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
                child: Text(s.iapRetry),
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
    final s = S.of(context);

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
          _buildCreditsBalanceCard(context, ref, state),
          const SizedBox(height: 24),

          // Credits Products Section
          if (state.creditProducts.isNotEmpty) ...[
            _buildSectionHeader(context, '🚗 ${s.iapDeliveryCredits}'),
            const SizedBox(height: 12),
            ...state.creditProducts.map((product) => ConsumableCard(
                  product: product,
                  isLoading: state.isLoading,
                  onBuy: () => ref.read(consumableProvider.notifier).purchaseConsumable(product),
                )),
            const SizedBox(height: 24),
          ],

          // Voucher Products Section
          if (state.voucherProducts.isNotEmpty) ...[
            _buildSectionHeader(context, '🏷️ ${s.iapVouchers}'),
            const SizedBox(height: 12),
            ...state.voucherProducts.map((product) => ConsumableCard(
                  product: product,
                  isLoading: state.isLoading,
                  onBuy: () => ref.read(consumableProvider.notifier).purchaseConsumable(product),
                )),
            const SizedBox(height: 24),
          ],

          // Gift Card Products Section
          if (state.giftCardProducts.isNotEmpty) ...[
            _buildSectionHeader(context, '🎁 ${s.iapGiftCards}'),
            const SizedBox(height: 12),
            ...state.giftCardProducts.map((product) => ConsumableCard(
                  product: product,
                  isLoading: state.isLoading,
                  onBuy: () => ref.read(consumableProvider.notifier).purchaseConsumable(product),
                )),
            const SizedBox(height: 24),
          ],

          // User Vouchers Section
          if (state.userVouchers.isNotEmpty) ...[
            _buildSectionHeader(context, '📦 ${s.iapMyVouchers}'),
            const SizedBox(height: 12),
            ...state.userVouchers.map((voucher) => UserVoucherCard(voucher: voucher)),
          ],
        ],
      ),
    );
  }

  Widget _buildCreditsBalanceCard(BuildContext context, WidgetRef ref, ConsumableState state) {
    final s = S.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              ref.colors.primary,
              ref.colors.primary.withValues(alpha: 0.8),
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
                  s.iapCreditsBalance,
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
              s.iapDeliveryCredits,
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
}
