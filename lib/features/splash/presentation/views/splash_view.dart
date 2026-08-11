import 'package:delivery_app/features/splash/application/splash_intent.dart';
import 'package:delivery_app/features/splash/application/splash_state.dart';
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
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.primary,
              scheme.primaryContainer,
              const Color(0xFFD97706),
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
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x55000000),
                            blurRadius: 24,
                            offset: Offset(0, 8),
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
                    const SizedBox(height: 40),
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'URBAN HEARTH',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(height: 72),
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
                    const SizedBox(height: 16),
                    Text(
                      widget.state.loadingMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (widget.state.hasError) ...[
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () =>
                            widget.onIntent(const SplashRetryRequested()),
                        child: const Text('Retry'),
                      ),
                    ],
                    const SizedBox(height: 48),
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
