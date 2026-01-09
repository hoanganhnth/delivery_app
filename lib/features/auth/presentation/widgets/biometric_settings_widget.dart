import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/widgets/toast/toast_extensions.dart';
import '../../domain/entities/biometric_entity.dart';
import '../providers/auth_providers.dart';
import '../providers/biometric_providers.dart';

/// Widget for biometric settings in profile/settings screen
class BiometricSettingsWidget extends ConsumerStatefulWidget {
  const BiometricSettingsWidget({super.key});

  @override
  ConsumerState<BiometricSettingsWidget> createState() =>
      _BiometricSettingsWidgetState();
}

class _BiometricSettingsWidgetState
    extends ConsumerState<BiometricSettingsWidget> {
  @override
  void initState() {
    super.initState();
    // Check biometric availability on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(biometricNotifierProvider.notifier).checkBiometricAvailability();
      ref.read(biometricNotifierProvider.notifier).checkBiometricEnabled();
    });
  }

  @override
  Widget build(BuildContext context) {
    final biometricState = ref.watch(biometricNotifierProvider);

    // Don't show if biometric is not available
    if (!biometricState.isAvailable) {
      return const SizedBox.shrink();
    }

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
                  _getBiometricIcon(biometricState.availableTypes),
                  size: 24.w,
                ),
                SizedBox(width: 12.w),
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
                        _getBiometricDescription(biometricState.availableTypes),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: biometricState.isEnabled,
                  onChanged:
                      biometricState.isLoading
                          ? null
                          : (value) => _handleToggleBiometric(value),
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

  IconData _getBiometricIcon(List<BiometricType> types) {
    if (types.contains(BiometricType.face)) {
      return Icons.face;
    } else if (types.contains(BiometricType.fingerprint)) {
      return Icons.fingerprint;
    } else if (types.contains(BiometricType.iris)) {
      return Icons.remove_red_eye;
    }
    return Icons.security;
  }

  String _getBiometricDescription(List<BiometricType> types) {
    if (types.isEmpty) {
      return 'No biometric available';
    }

    final typeNames = types.map((t) => t.displayName).join(', ');
    return 'Use $typeNames to login quickly';
  }

  Future<void> _handleToggleBiometric(bool enable) async {
    final notifier = ref.read(biometricNotifierProvider.notifier);

    if (enable) {
      // Show dialog to confirm and authenticate
      final confirmed = await _showEnableBiometricDialog();
      if (confirmed == true) {
        // Authenticate first
        final authenticated = await notifier.authenticateWithBiometric(
          'Authenticate to enable biometric login',
        );

        if (authenticated && mounted) {
          // Get current auth tokens from auth state
          final authState = ref.read(authStateProvider);

          if (authState.accessToken != null) {
            // Save tokens for biometric login
            await notifier.enableBiometric(
              authState.accessToken!,
              refreshToken: authState.refreshToken,
            );

            if (mounted) {
              context.showSuccessToast('Biometric login enabled successfully');
            }
          } else {
            if (mounted) {
              context.showErrorToast('Please login first to enable biometric');
            }
          }
        }
      }
    } else {
      // Disable biometric
      await notifier.disableBiometric();
      if (mounted) {
        context.showSuccessToast('Biometric login disabled');
      }
    }
  }

  Future<bool?> _showEnableBiometricDialog() {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
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
