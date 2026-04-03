import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/biometric_entity.dart';
import '../providers/biometric_notifier.dart';

/// Widget for biometric login button
/// 
/// Features:
/// - 56x56 rounded square button
/// - Surface container background (#EDE7E0)
/// - Fingerprint or Face icon based on available biometric type
/// - Soft shadow and border
/// - Only shows if biometric is available and enabled
class BiometricLoginButton extends ConsumerStatefulWidget {
  const BiometricLoginButton({super.key});

  @override
  ConsumerState<BiometricLoginButton> createState() =>
      _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends ConsumerState<BiometricLoginButton> {
  @override
  Widget build(BuildContext context) {
    final biometricState = ref.watch(biometricProvider);

    if (!biometricState.isAvailable || !biometricState.isEnabled) {
      return const SizedBox.shrink();
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFEDE7E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFF4EEE7),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          biometricState.availableTypes.contains(BiometricType.face)
              ? Icons.face
              : Icons.fingerprint,
          size: 28,
          color: const Color(0xFF9C7A49),
        ),
        onPressed: () async {
          final biometricNotifier = ref.read(biometricProvider.notifier);

          // Show reasoning dialog to user
          final authenticated = await biometricNotifier
              .authenticateWithBiometric(
            'Đăng nhập bằng sinh trắc học',
          );

          if (authenticated) {
            // TODO: Implement biometric login with stored credentials
            // final authNotifier = ref.read(authProvider.notifier);
            // Get stored credentials and login
            // await authNotifier.login(...);
          }
        },
      ),
    );
  }
}
