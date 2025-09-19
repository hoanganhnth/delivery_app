import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/splash_controller.dart';

/// Splash Screen with initialization logic
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    // Start animations
    _animationController.forward();

    // Initialize app
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final router = GoRouter.of(context);
      ref.read(splashControllerProvider.notifier).initializeApp(router);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(splashControllerProvider); // Watch for state changes
    final splashController = ref.read(splashControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.delivery_dining,
                        size: 80,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 32.w),

            // App name
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Delivery App',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),

            SizedBox(height: 48.w),

            // Loading indicator with status
            Column(
              children: [
                if (splashController.hasError)
                  Icon(Icons.error_outline, color: Colors.red, size: 32)
                else
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),

                SizedBox(height: 16.w),

                // Status text
                Text(
                  splashController.loadingMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: splashController.hasError
                        ? Colors.red
                        : Theme.of(context).primaryColor.withValues(alpha: 0.8),
                  ),
                ),

                // Retry button for error state
                if (splashController.hasError) ...[
                  SizedBox(height: 16.w),
                  ElevatedButton(
                    onPressed: () {
                      final router = GoRouter.of(context);
                      ref
                          .read(splashControllerProvider.notifier)
                          .initializeApp(router);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ],
            ),

            SizedBox(height: 64.w),

            // App version or tagline
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Fast • Fresh • Delivered',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
