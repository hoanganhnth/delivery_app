import 'package:flutter/material.dart';
import '../pages/notification_page.dart';

/// Compatibility route owner while callers migrate to [NotificationPage].
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) => const NotificationPage();
}
