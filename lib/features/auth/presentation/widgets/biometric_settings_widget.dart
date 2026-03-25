import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/biometric_entity.dart' as app;
import '../providers/biometric_notifier.dart';
import '../providers/auth_notifier.dart';

class BiometricSettingsWidget extends ConsumerWidget {
  const BiometricSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We only need to show this if biometrics are available
    final biometricState = ref.watch(biometricProvider);

    // If not supported, don't show the widget
    if (!biometricState.isSupported) {
      return const SizedBox.shrink();
    }

    final availableBiometrics = biometricState.availableBiometrics;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getBiometricIcon(availableBiometrics),
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Biometric Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _getBiometricDescription(availableBiometrics),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: biometricState.isBiometricEnabled,
                  onChanged: biometricState.isSupported
                      ? (value) => _handleToggleBiometric(context, ref, value)
                      : null,
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            if (biometricState.isLoading)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: const LinearProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getBiometricIcon(List<app.BiometricType> types) {
    if (types.contains(app.BiometricType.face)) {
      return Icons.face;
    } else if (types.contains(app.BiometricType.fingerprint)) {
      return Icons.fingerprint;
    } else if (types.contains(app.BiometricType.iris)) {
      return Icons.remove_red_eye;
    }
    return Icons.security;
  }

  String _getBiometricDescription(List<app.BiometricType> types) {
    if (types.isEmpty) {
      return 'No biometric available';
    }

    final typeNames = types.map((t) => t.displayName).join(', ');
    return 'Use $typeNames to login quickly';
  }

  Future<void> _handleToggleBiometric(BuildContext context, WidgetRef ref, bool enable) async {
    final notifier = ref.read(biometricProvider.notifier);

    if (enable) {
      // User wants to enable, show dialog first
      final confirmed = await _showEnableBiometricDialog(context);
      if (confirmed == true) {
        // Authenticate first
        final authenticated = await notifier.authenticateWithBiometric(
          'Authenticate to enable biometric login',
        );

        if (authenticated) {
          if (context.mounted) {
            // Get access token from auth state
            final authState = ref.read(authProvider);
            if (authState.accessToken != null) {
              await notifier.enableBiometric(
                authState.accessToken!,
                refreshToken: authState.refreshToken,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã bật đăng nhập bằng sinh trắc học')),
              );
            }
          }
        }
      }
    } else {
      // Direct disable
      await notifier.disableBiometric();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã tắt đăng nhập bằng sinh trắc học')),
        );
      }
    }
  }

  Future<bool?> _showEnableBiometricDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enable Biometric Login'),
        content: const Text(
          'Do you want to enable biometric login? '
          'This will allow you to login quickly using your fingerprint or face.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }
}
