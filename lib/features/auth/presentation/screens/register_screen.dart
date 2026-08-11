import 'package:flutter/material.dart';

import '../pages/register_page.dart';

/// Compatibility route owner while callers migrate to [RegisterPage].
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) => const RegisterPage();
}
