import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';
import '../../../../generated/l10n.dart';
import '../providers/providers.dart';
import '../widgets/login_header.dart';
import '../widgets/login_form.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // Check biometric availability when entering login screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(biometricProvider.notifier).checkBiometricAvailability();
      ref.read(biometricProvider.notifier).checkBiometricEnabled();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.hasError) {
        context.showErrorToast(next.failure!.message);
      } else if (next.isAuthenticated && !next.isLoginLoading) {
        context.showSuccessToast(S.of(context).loginSuccess);
        // Force refresh profile after login - don't use cache
        ref
            .read(profileProvider.notifier)
            .getUserProfile(forceRefresh: true, useCache: false);
        context.goToMain();
      }
    });

    return Scaffold(
      backgroundColor: ref.colors.background,
      body: Stack(
        children: [
          // Ambient blur effects
          Positioned(
            bottom: -64,
            left: -64,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: ref.colors.primary.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            right: -80,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: const Color(0xFFFFB866).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // Main content
          Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 448),
              decoration: BoxDecoration(
                color: ref.colors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  LoginHeader(),
                  Expanded(
                    child: LoginForm(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
