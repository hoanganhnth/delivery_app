import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';

class TrackingNoDataCard extends StatelessWidget {
  final int orderId;
  final bool canTrackingRealtime;
  final VoidCallback? onRetry;

  const TrackingNoDataCard({
    super.key,
    required this.orderId,
    required this.canTrackingRealtime,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return PreviewSurface(
      padding: const EdgeInsets.fromLTRB(24, 38, 24, 32),
      child: Column(
        children: [
          Icon(
            Icons.location_searching,
            size: 52,
            color: PreviewUi.muted(context),
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).noTrackingInfo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: PreviewUi.text(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).shipperNotStarted,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: 220,
            height: 44,
            child: FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Thử lại'),
              style: FilledButton.styleFrom(
                backgroundColor: PreviewUi.accent,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
