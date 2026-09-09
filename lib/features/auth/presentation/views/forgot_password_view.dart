import 'package:flutter/material.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/password_recovery/password_recovery_state.dart';
import '../widgets/auth_components.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({
    super.key,
    required this.state,
    required this.onEmailChanged,
    required this.onSubmit,
    this.onBack,
  });

  final PasswordRecoveryState state;
  final ValueChanged<String> onEmailChanged;
  final VoidCallback onSubmit;
  final VoidCallback? onBack;

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.state.email);
  }

  @override
  void didUpdateWidget(covariant ForgotPasswordView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_emailController.text != widget.state.email) {
      _emailController.value = _emailController.value.copyWith(
        text: widget.state.email,
        selection: TextSelection.collapsed(offset: widget.state.email.length),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final scheme = Theme.of(context).colorScheme;
    final state = widget.state;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        leadingWidth: 44,
        leading: widget.onBack == null
            ? null
            : IconButton(
                tooltip: 'Quay lại',
                onPressed: state.isSubmitting ? null : widget.onBack,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back, color: Color(0xFFEE4D2D)),
              ),
        title: Text(
          shopeeFoodPreviewTitle(strings.forgotPasswordTitle),
          style: const TextStyle(
            color: Color(0xFF222222),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: const [SizedBox(width: 44)],
      ),
      body: ShopeeFoodPreviewAuthShell(
        title: strings.forgotPasswordPrompt,
        subtitle: strings.forgotPasswordInstruction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShopeeFoodPreviewAuthField(
              key: const Key('forgot_password_email'),
              controller: _emailController,
              hintText: 'Email',
              semanticLabel: strings.emailAddress,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              enabled: !state.isSubmitting,
              onChanged: widget.onEmailChanged,
              onSubmitted: (_) {
                if (!state.isSubmitting) widget.onSubmit();
              },
            ),
            const SizedBox(height: 20),
            ShopeeFoodPreviewAuthButton(
              key: const Key('forgot_password_submit'),
              label: shopeeFoodPreviewTitle(strings.forgotPasswordSubmit),
              isLoading: state.isSubmitting,
              onPressed: state.isSubmitting ? null : widget.onSubmit,
            ),
            if (state.isSubmitted) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(color: Color(0xFFFFF8F2)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFFEE4D2D),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        strings.forgotPasswordSent,
                        style: const TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
