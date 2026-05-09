import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';

class AuthFooter extends ConsumerWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 11,
            color: ref.colors.secondary.withValues(alpha: 0.6),
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: s.termsPrefix,
            ),
            TextSpan(
              text: s.termsOfService,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C160D),
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(text: s.termsAnd),
            TextSpan(
              text: s.privacyPolicy,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C160D),
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(text: s.termsDot),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
