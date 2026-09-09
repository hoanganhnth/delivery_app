import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/splash/application/splash_intent.dart';
import 'package:delivery_app/features/splash/application/splash_state.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Native startup surface; startup decisions remain in the ViewModel.
class SplashView extends StatelessWidget {
  const SplashView({super.key, required this.state, required this.onIntent});
  final SplashViewState state;
  final ValueChanged<SplashIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: PreviewSurface(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius: PreviewUi.controlRadius,
                      ),
                      child: const SizedBox(
                        width: 72,
                        height: 72,
                        child: Icon(
                          Icons.restaurant,
                          size: 42,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Delivery',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: scheme.primary,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Món ngon giao tận nơi',
                      style: TextStyle(
                        color: PreviewUi.muted(context),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (state.hasError)
                      Icon(
                        Icons.error_outline_rounded,
                        color: scheme.error,
                        size: 32,
                      )
                    else
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          color: PreviewUi.accent,
                          strokeWidth: 2.5,
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(state.loadingMessage, textAlign: TextAlign.center),
                    if (state.hasError) ...[
                      const SizedBox(height: 16),
                      AppButton(
                        label: S.of(context).authRetry,
                        onPressed: () => onIntent(const SplashRetryRequested()),
                      ),
                    ],
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
