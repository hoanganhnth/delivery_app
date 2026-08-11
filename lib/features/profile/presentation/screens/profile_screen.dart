import 'package:flutter/material.dart';

import '../pages/profile_page.dart';

/// Compatibility route owner while callers migrate to [ProfilePage].
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => const ProfilePage();
}
