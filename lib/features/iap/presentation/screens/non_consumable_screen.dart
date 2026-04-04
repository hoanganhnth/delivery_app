import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/domain/entities/non_consumable_entity.dart';
import 'package:delivery_app/features/iap/presentation/providers/non_consumable_notifier.dart';
import 'package:delivery_app/features/iap/presentation/providers/non_consumable_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen for purchasing non-consumable products (unlockable features)
class NonConsumableScreen extends ConsumerWidget {
  const NonConsumableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(nonConsumableProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unlock Features'),
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
                onPressed: () => ref.refresh(nonConsumableProvider),
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
    NonConsumableState state,
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
          _buildUnlockedSummaryCard(context, state),
          const SizedBox(height: 24),

          // Popular Features Section
          if (state.popularProducts.isNotEmpty) ...[
            _buildSectionHeader(context, '⭐ Popular Features'),
            const SizedBox(height: 12),
            ...state.popularProducts.map((product) => _buildFeatureCard(
                  context,
                  ref,
                  product,
                  state.isLoading,
                )),
            const SizedBox(height: 24),
          ],

          // Premium Features Section
          if (state.premiumProducts.isNotEmpty) ...[
            _buildSectionHeader(context, '👑 Premium Features'),
            const SizedBox(height: 12),
            ...state.premiumProducts.map((product) => _buildFeatureCard(
                  context,
                  ref,
                  product,
                  state.isLoading,
                )),
            const SizedBox(height: 24),
          ],

          // All Available Features
          _buildSectionHeader(context, '🎯 All Features'),
          const SizedBox(height: 12),
          ...state.products.map((product) => _buildFeatureCard(
                context,
                ref,
                product,
                state.isLoading,
              )),
        ],
      ),
    );
  }

  Widget _buildUnlockedSummaryCard(
      BuildContext context, NonConsumableState state) {
    final unlockedCount = state.unlockedFeatures.length;
    final totalCount = FeatureType.values.length;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade600,
              Colors.purple.shade400,
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
                const Icon(Icons.lock_open, color: Colors.white, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Unlocked Features',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$unlockedCount',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '/ $totalCount',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: unlockedCount / totalCount,
              backgroundColor: Colors.white30,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              unlockedCount == totalCount
                  ? '🎉 All features unlocked!'
                  : '${totalCount - unlockedCount} features remaining',
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

  Widget _buildFeatureCard(
    BuildContext context,
    WidgetRef ref,
    NonConsumableEntity product,
    bool isLoading,
  ) {
    final isUnlocked = product.isUnlocked;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: isUnlocked
              ? Border.all(color: Colors.green, width: 2)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Feature Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? Colors.green.withValues(alpha: 0.1)
                      : context.colors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    product.featureType.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Feature Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.featureType.displayName,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (isUnlocked)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'UNLOCKED',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.featureType.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                    if (product.purchaseDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Unlocked on ${_formatDate(product.purchaseDate!)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Price & Unlock Button
              if (!isUnlocked)
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
                              .read(nonConsumableProvider.notifier)
                              .purchaseFeature(product.featureType),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.primary,
                        foregroundColor: context.colors.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
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
                          : const Text('Unlock'),
                    ),
                  ],
                )
              else
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 32,
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
