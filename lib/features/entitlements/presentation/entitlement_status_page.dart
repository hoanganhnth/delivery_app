import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/entitlement_providers.dart';
import '../domain/entities/entitlement.dart';

class EntitlementStatusPage extends ConsumerWidget {
  const EntitlementStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinator = ref.watch(entitlementCoordinatorProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Entitlements')),
      body: FutureBuilder<EntitlementSnapshot>(
        future: coordinator.refresh(),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state?.status == EntitlementStatus.active) {
            return Center(
              child: Text('Active: ${state!.confirmedProductIds.join(', ')}'),
            );
          }
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Entitlement unavailable'),
                SizedBox(height: 8),
                Text('No local access has been granted.'),
              ],
            ),
          );
        },
      ),
    );
  }
}
