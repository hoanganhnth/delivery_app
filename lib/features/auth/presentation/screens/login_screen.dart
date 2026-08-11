import 'package:flutter/material.dart';

import '../pages/login_page.dart';

/// Compatibility route owner while callers migrate to [LoginPage].
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => const LoginPage();
}
