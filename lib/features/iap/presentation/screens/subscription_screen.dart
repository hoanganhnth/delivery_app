import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/features/iap/presentation/providers/subscription_notifier.dart';
import 'package:delivery_app/features/iap/presentation/providers/subscription_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Screen for managing subscription plans
class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(subscriptionProvider);
    final textTheme = Theme.of(context).textTheme;

    return _buildContent(context, ref, state, textTheme);
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    SubscriptionState state,
    TextTheme textTheme,
  ) {
    // Show success/error messages
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.successMessage!),
            backgroundColor: Colors.green,
          ),
        );
        ref.read(subscriptionProvider.notifier).clearSuccessMessage();
      }

      if (state.failure != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.failure!.message),
            backgroundColor: Colors.red,
          ),
        );
        ref.read(subscriptionProvider.notifier).clearError();
      }
    });

    return RefreshIndicator(
      onRefresh: () => ref
          .read(subscriptionProvider.notifier)
          .loadSubscriptionTiers(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Current Subscription Card
          if (state.activeSubscription != null)
            _buildActiveSubscriptionCard(context, state.activeSubscription!, textTheme),

          const SizedBox(height: 24),

          // Subscription Tiers
          Text(
            'Choose Your Plan',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          ...state.availableTiers.map((subscription) => _buildTierCard(
                context,
                ref,
                subscription,
                state.isLoading,
                state.activeSubscription?.tier == subscription.tier,
                textTheme,
              )),

          const SizedBox(height: 24),

          // Restore Purchases Button
          Center(
            child: TextButton.icon(
              onPressed: state.isLoading
                  ? null
                  : () => ref
                      .read(subscriptionProvider.notifier)
                      .restorePurchases(),
              icon: const Icon(Icons.restore),
              label: const Text('Restore Purchases'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSubscriptionCard(
    BuildContext context,
    SubscriptionEntity subscription,
    TextTheme textTheme,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
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
                const Icon(Icons.star, color: Colors.white, size: 28),
                const SizedBox(width: 8),
                Text(
                  'Current Plan',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subscription.tier.displayName,
              style: textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subscription.expiryDate != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Expires: ${subscription.expiryDate}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTierCard(
    BuildContext context,
    WidgetRef ref,
    SubscriptionEntity subscription,
    bool isLoading,
    bool isCurrentTier,
    TextTheme textTheme,
  ) {
    final tier = subscription.tier;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isCurrentTier
            ? BorderSide(color: context.colors.primary, width: 2)
            : BorderSide.none,
      ),
      elevation: isCurrentTier ? 8 : 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tier.displayName,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subscription.product.price,
                        style: textTheme.titleMedium?.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCurrentTier)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'CURRENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ...tier.benefits.map((benefit) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: context.colors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(benefit)),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading || isCurrentTier
                    ? null
                    : () => ref
                        .read(subscriptionProvider.notifier)
                        .purchaseSubscription(tier),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(isCurrentTier ? 'Current Plan' : 'Subscribe'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}