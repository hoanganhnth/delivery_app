import 'package:delivery_app/features/iap/presentation/providers/subscription_notifier.dart';
import 'package:delivery_app/features/iap/presentation/providers/subscription_state.dart';
import 'package:delivery_app/features/iap/presentation/widgets/active_subscription_card.dart';
import 'package:delivery_app/features/iap/presentation/widgets/tier_card.dart';
import 'package:delivery_app/generated/l10n.dart';
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
    final s = S.of(context);

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
            ActiveSubscriptionCard(
              subscription: state.activeSubscription!,
              textTheme: textTheme,
            ),

          const SizedBox(height: 24),

          // Subscription Tiers
          Text(
            s.iapChoosePlan,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          ...state.availableTiers.map((subscription) => TierCard(
                subscription: subscription,
                isLoading: state.isLoading,
                isCurrentTier: state.activeSubscription?.tier == subscription.tier,
                textTheme: textTheme,
                onSubscribe: () => ref.read(subscriptionProvider.notifier).purchaseSubscription(subscription.tier),
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
              label: Text(s.iapRestorePurchases),
            ),
          ),
        ],
      ),
    );
  }
}