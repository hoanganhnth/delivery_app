import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/design_system/design_system.dart';

import '../di/entitlement_providers.dart';
import '../domain/entities/entitlement.dart';

class EntitlementStatusPage extends ConsumerStatefulWidget {
  const EntitlementStatusPage({super.key});

  @override
  ConsumerState<EntitlementStatusPage> createState() =>
      _EntitlementStatusPageState();
}

class _EntitlementStatusPageState
    extends ConsumerState<EntitlementStatusPage> {
  late final Future<EntitlementSnapshot> _snapshotFuture;

  @override
  void initState() {
    super.initState();
    _snapshotFuture = ref.read(entitlementCoordinatorProvider).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreviewUi.canvas(context),
      appBar: PreviewPageHeader(
        title: 'Entitlements',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      body: FutureBuilder<EntitlementSnapshot>(
        future: _snapshotFuture,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state?.status == EntitlementStatus.active) {
            return ListView(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              children: [
                for (final product in state!.confirmedProductIds)
                  PreviewSurface(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text('Active: $product')),
                      ],
                    ),
                  ),
              ],
            );
          }
          final message = switch (state?.status) {
            EntitlementStatus.pending => (
              'Entitlement pending',
              'Access is waiting for server confirmation.',
            ),
            EntitlementStatus.revoked => (
              'Entitlement revoked',
              'No active access is available for this account.',
            ),
            _ => (
              'Entitlement unavailable',
              'No local access has been granted.',
            ),
          };
          return Center(
            child: PreviewSurface(
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, size: 40),
                  const SizedBox(height: 16),
                  Text(message.$1),
                  const SizedBox(height: 8),
                  Text(
                    message.$2,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: PreviewUi.muted(context)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
