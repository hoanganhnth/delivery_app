import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/support_coordinator.dart';
import '../di/support_providers.dart';
import '../domain/entities/support_conversation.dart';

class SupportPage extends ConsumerWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinator = ref.watch(supportCoordinatorProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Support')),
      body: FutureBuilder<SupportState>(
        future: coordinator.load(),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state?.status == SupportStatus.open) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: state!.messages.map((message) => Text(message.body)).toList(),
            );
          }
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Support unavailable'),
                SizedBox(height: 8),
                Text('Please try again later.'),
              ],
            ),
          );
        },
      ),
    );
  }
}
