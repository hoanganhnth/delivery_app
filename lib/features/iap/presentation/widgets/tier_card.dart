import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/domain/entities/subscription_entity.dart';
import 'package:delivery_app/generated/l10n.dart';

class TierCard extends ConsumerWidget {
  final SubscriptionEntity subscription;
  final bool isLoading;
  final bool isCurrentTier;
  final TextTheme textTheme;
  final VoidCallback onSubscribe;

  const TierCard({
    super.key,
    required this.subscription,
    required this.isLoading,
    required this.isCurrentTier,
    required this.textTheme,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final tier = subscription.tier;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isCurrentTier
            ? BorderSide(color: ref.colors.primary, width: 2)
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
                          color: ref.colors.primary,
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
                      color: ref.colors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      s.iapCurrent,
                      style: const TextStyle(
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
                        color: ref.colors.primary,
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
                onPressed: isLoading || isCurrentTier ? null : onSubscribe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ref.colors.primary,
                  foregroundColor: ref.colors.onPrimary,
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
                    : Text(isCurrentTier ? s.iapCurrentPlan : s.iapStoreTabSubscribe),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
