import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/splash_controller.dart';
import '../../../core/theme/theme_extensions.dart';

/// Splash Screen with Amber Hearth Design System
/// Features: Warm gradient background, editorial typography, soft stacking elevation
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
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
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
    ref.watch(splashControllerProvider);
    final splashController = ref.read(splashControllerProvider.notifier);
    final colors = ref.colors;

    return Scaffold(
      body: Container(
        // Warm gradient background - Orange-400 to warmer tone
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.primary,
              colors.primaryDark,
              const Color(0xFFd97706), // Warmer orange tone
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // Logo with soft stacking elevation and backdrop blur
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 140.w,
                          height: 140.w,
                          decoration: BoxDecoration(
                            // Glass effect with backdrop blur
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            // Amber-tinted shadow for "Hearth" warmth
                            boxShadow: [
                              BoxShadow(
                                color: ref.colors.secondary.withValues(alpha: 0.3),
                                blurRadius: 32,
                                offset: const Offset(0, 8),
                              ),
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.5),
                                blurRadius: 16,
                                offset: const Offset(0, -4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.local_fire_department_rounded,
                                  size: 72.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // App name with editorial typography - Black weight
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: Column(
                          children: [
                            Text(
                              'Delivery',
                              style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w900, // Black weight
                                color: Colors.white,
                                letterSpacing: -0.02, // Compact editorial feel
                                height: 1.1,
                                shadows: [
                                  Shadow(
                                    color: ref.colors.secondary.withValues(alpha: 0.5),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // Tagline with overline style
                            Text(
                              'URBAN HEARTH',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withValues(alpha: 0.9),
                                letterSpacing: 2.5,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Loading indicator with status
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          if (splashController.hasError)
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.error_outline_rounded,
                                color: Colors.white,
                                size: 32.w,
                              ),
                            )
                          else
                            SizedBox(
                              width: 32.w,
                              height: 32.w,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withValues(alpha: 0.9),
                                ),
                                strokeWidth: 3,
                              ),
                            ),

                          SizedBox(height: 16.h),

                          // Status text with warm styling
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              splashController.loadingMessage,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Retry button for error state
                          if (splashController.hasError) ...[
                            SizedBox(height: 24.h),
                            ElevatedButton(
                              onPressed: () {
                                final router = GoRouter.of(context);
                                ref
                                    .read(splashControllerProvider.notifier)
                                    .initializeApp(router);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: colors.primary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32.w,
                                  vertical: 16.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                elevation: 8,
                                shadowColor: ref.colors.secondary.withValues(alpha: 0.4),
                              ),
                              child: Text(
                                'Retry',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: 48.h),

                    // Tagline with editorial spacing
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        'Fast • Fresh • Delivered',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.85),
                          letterSpacing: 1.8,
                          height: 1.6,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
