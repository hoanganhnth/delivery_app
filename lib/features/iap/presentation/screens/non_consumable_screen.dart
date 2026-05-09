import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/presentation/providers/non_consumable_notifier.dart';
import 'package:delivery_app/features/iap/presentation/providers/non_consumable_state.dart';
import 'package:delivery_app/features/iap/presentation/widgets/feature_card.dart';
import 'package:delivery_app/features/iap/presentation/widgets/unlocked_summary_card.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen for purchasing non-consumable products (unlockable features)
class NonConsumableScreen extends ConsumerWidget {
  const NonConsumableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(nonConsumableProvider);
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.iapUnlockFeaturesTitle),
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
                onPressed: () => ref.refresh(nonConsumableProvider),
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
    NonConsumableState state,
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
        ref.read(nonConsumableProvider.notifier).clearSuccessMessage();
      }

      // Show error message
      if (state.failure != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.failure!.message),
            backgroundColor: Colors.red,
          ),
        );
        ref.read(nonConsumableProvider.notifier).clearError();
      }
    });

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(nonConsumableProvider.notifier).loadProducts(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Unlocked Features Summary
          UnlockedSummaryCard(state: state),
          const SizedBox(height: 24),

          // Popular Features Section
          if (state.popularProducts.isNotEmpty) ...[
            _buildSectionHeader(context, s.iapPopularFeatures),
            const SizedBox(height: 12),
            ...state.popularProducts.map((product) => FeatureCard(
                  product: product,
                  isLoading: state.isLoading,
                  onUnlock: () => ref.read(nonConsumableProvider.notifier).purchaseFeature(product.featureType),
                )),
            const SizedBox(height: 24),
          ],

          // Premium Features Section
          if (state.premiumProducts.isNotEmpty) ...[
            _buildSectionHeader(context, s.iapPremiumFeatures),
            const SizedBox(height: 12),
            ...state.premiumProducts.map((product) => FeatureCard(
                  product: product,
                  isLoading: state.isLoading,
                  onUnlock: () => ref.read(nonConsumableProvider.notifier).purchaseFeature(product.featureType),
                )),
            const SizedBox(height: 24),
          ],

          // All Available Features
          _buildSectionHeader(context, s.iapAllFeatures),
          const SizedBox(height: 12),
          ...state.products.map((product) => FeatureCard(
                product: product,
                isLoading: state.isLoading,
                onUnlock: () => ref.read(nonConsumableProvider.notifier).purchaseFeature(product.featureType),
              )),
        ],
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
