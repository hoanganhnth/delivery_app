import 'package:delivery_app/core/design_system/components/app_button.dart';
import 'package:delivery_app/core/design_system/components/app_navigation.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_intent.dart';
import 'package:delivery_app/features/cart/application/order_confirmation_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class OrderConfirmationView extends StatelessWidget {
  const OrderConfirmationView({
    super.key,
    required this.state,
    required this.onIntent,
    this.onHome,
  });

  final OrderConfirmationViewState state;
  final ValueChanged<OrderConfirmationIntent> onIntent;
  final VoidCallback? onHome;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);

    return Scaffold(
      appBar: AppTopBar(
        title: strings.orderConfirmed,
        onBack: onHome,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.page),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer.withValues(alpha: 0.35),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 80,
                      color: scheme.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    strings.orderConfirmed,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    strings.orderConfirmedSubtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  AppButton(
                    label: strings.trackOrder,
                    icon: Icons.delivery_dining,
                    expand: true,
                    onPressed: () =>
                        onIntent(const OrderConfirmationTrackingRequested()),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    variant: AppButtonVariant.secondary,
                    label: strings.backToHome,
                    icon: Icons.home_outlined,
                    expand: true,
                    onPressed: onHome,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
