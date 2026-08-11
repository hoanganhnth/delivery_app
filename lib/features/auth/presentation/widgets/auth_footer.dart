import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final s = S.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontSize: 11,
            color: scheme.secondary.withValues(alpha: 0.6),
            height: 1.5,
          ),
          children: [
            TextSpan(text: s.termsPrefix),
            TextSpan(
              text: s.termsOfService,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(text: s.termsAnd),
            TextSpan(
              text: s.privacyPolicy,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
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
