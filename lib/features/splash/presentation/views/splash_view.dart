import 'package:delivery_app/core/design_system/components/app_button.dart';
import 'package:delivery_app/core/design_system/foundations/app_spacing.dart';
import 'package:delivery_app/features/splash/application/splash_intent.dart';
import 'package:delivery_app/features/splash/application/splash_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Pure Amber Hearth startup visual. It only animates and emits retry intent.
class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.state, required this.onIntent});

  final SplashViewState state;
  final ValueChanged<SplashIntent> onIntent;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 1200),
    vsync: this,
  )..forward();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final strings = S.of(context);
    final retryLabel = strings.authRetry;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.primary,
              scheme.primaryContainer,
              scheme.surfaceContainerHighest,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.page),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const SizedBox(
                        width: 140,
                        height: 140,
                        child: Icon(
                          Icons.local_fire_department_rounded,
                          size: 72,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      'URBAN HEARTH',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(height: 56),
                    if (widget.state.hasError)
                      const Icon(
                        Icons.error_outline_rounded,
                        color: Colors.white,
                        size: 32,
                      )
                    else
                      const SizedBox(
                        height: 32,
                        width: 32,
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      widget.state.loadingMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.state.hasError) ...[
                      const SizedBox(height: AppSpacing.md),
                      AppButton(
                        label: retryLabel,
                        onPressed: () =>
                            widget.onIntent(const SplashRetryRequested()),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      'Fast • Fresh • Delivered',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
