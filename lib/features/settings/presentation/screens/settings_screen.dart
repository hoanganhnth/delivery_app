import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

/// Compatibility route owner while callers migrate to [SettingsPage].
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.previewMode = false});

  final bool previewMode;

  @override
  Widget build(BuildContext context) => SettingsPage(previewMode: previewMode);
}
