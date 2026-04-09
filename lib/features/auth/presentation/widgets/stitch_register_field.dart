import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

/// Custom text field for register screen matching Stitch design
/// 
/// Features:
/// - Top label with uppercase styling
/// - Rounded corners (12px)
/// - Border with Amber Hearth outline color
/// - Icon prefix and optional suffix icon
/// - Optional helper text below the field
class StitchRegisterField extends ConsumerWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;
  final Widget? suffixIcon;
  final String? helperText;

  const StitchRegisterField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.enabled = true,
    this.suffixIcon,
    this.helperText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style:  TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: ref.colors.secondary,
              letterSpacing: 2,
            ),
          ),
        ),
        
        // Text field
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD9C3AE),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            enabled: enabled,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1C160D),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFFD9C3AE),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  icon,
                  color: ref.colors.secondary,
                  size: 22,
                ),
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              errorStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        
        // Helper text
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              helperText!,
              style: TextStyle(
                fontSize: 10,
                color: ref.colors.secondary.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
