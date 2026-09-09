import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/components/app_button.dart';
import 'package:delivery_app/core/design_system/components/app_fields.dart';
import 'package:delivery_app/generated/l10n.dart';

/// Accessible password field wrapper with show/hide toggle.
class AuthPasswordField extends StatelessWidget {
  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.obscurePassword,
    required this.onToggleVisibility,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.textInputAction,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscurePassword;
  final VoidCallback onToggleVisibility;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final tooltip = obscurePassword
        ? strings.showPassword
        : strings.hidePassword;

    return AppTextField(
      controller: controller,
      label: label,
      hintText: hint,
      errorText: errorText,
      obscureText: obscurePassword,
      enabled: enabled,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: AppIconButton(
        tooltip: tooltip,
        icon: obscurePassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        onPressed: enabled ? onToggleVisibility : null,
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}

/// ShopeeFood mark used by the customer preview authentication screens.
class ShopeeFoodPreviewMark extends StatelessWidget {
  const ShopeeFoodPreviewMark({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 60,
    height: 65,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          child: Container(
            width: 26,
            height: 18,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFEE4D2D), width: 3),
                left: BorderSide(color: Color(0xFFEE4D2D), width: 3),
                right: BorderSide(color: Color(0xFFEE4D2D), width: 3),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
        ),
        Positioned(
          top: 14,
          child: Container(
            width: 60,
            height: 51,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEE4D2D), width: 3),
            ),
            child: const Text(
              'S',
              style: TextStyle(
                color: Color(0xFFEE4D2D),
                fontSize: 42,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// The shared white, centered content frame from the customer preview.
class ShopeeFoodPreviewAuthShell extends StatelessWidget {
  const ShopeeFoodPreviewAuthShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 45, 24, 55),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: ShopeeFoodPreviewMark()),
                const SizedBox(height: 30),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShopeeFoodPreviewAuthButton extends StatelessWidget {
  const ShopeeFoodPreviewAuthButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 44,
    width: double.infinity,
    child: FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFFEE4D2D),
        foregroundColor: Colors.white,
        disabledBackgroundColor: const Color(0xFFE7B8AC),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      child: isLoading
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(label),
    ),
  );
}

/// Borderless-underlined input matching the preview auth form.
class ShopeeFoodPreviewAuthField extends StatelessWidget {
  const ShopeeFoodPreviewAuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.semanticLabel,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String hintText;
  final String? semanticLabel;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final field = TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: TextStyle(fontSize: 14, color: scheme.onSurface),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
        suffixIcon: suffixIcon,
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFDDDDDD)),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEE4D2D)),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFB3261E)),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFB3261E), width: 2),
        ),
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: 11, color: Color(0xFFB3261E)),
      ),
    );
    return Semantics(
      textField: true,
      label: semanticLabel ?? hintText,
      child: field,
    );
  }
}

String shopeeFoodPreviewTitle(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return trimmed;
  return '${trimmed.substring(0, 1).toUpperCase()}${trimmed.substring(1).toLowerCase()}';
}
