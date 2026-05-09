import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../../../../core/error/failures.dart';
import '../../../../generated/l10n.dart';
import '../providers/providers.dart';
import '../widgets/register_header.dart';
import '../widgets/register_form.dart';
import '../widgets/auth_footer.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to auth state changes
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.hasError) {
        _showErrorSnackBar(context, next.failure!);
      } else if (next.isAuthenticated) {
        _showSuccessSnackBar(context, S.of(context).registerSuccess);
        // Navigator.of(context).pop();
      }
    });

    return Scaffold(
      backgroundColor: ref.colors.background,
      body: const Column(
        children: [
          // Hero Header Section
          RegisterHeader(),
          
          // Main Registration Form
          Expanded(
            child: RegisterForm(),
          ),
          
          // Terms of Service Footer
          AuthFooter(),
        ],
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, Failure failure) {
    final s = S.of(context);
    String message;
    Color backgroundColor;
    
    if (failure is ValidationFailure) {
      message = failure.message;
      backgroundColor = Colors.orange;
    } else if (failure is ServerFailure) {
      message = s.registerFailed;
      backgroundColor = Colors.red;
    } else {
      message = s.unexpectedError;
      backgroundColor = Colors.red;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
