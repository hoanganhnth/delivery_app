import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';

class TrackingDeliveredCard extends StatelessWidget {
  const TrackingDeliveredCard({super.key});

  @override
  Widget build(BuildContext context) {
    const success = Color(0xFF229A69);
    return PreviewSurface(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 30),
      child: Column(
        children: [
          const Icon(Icons.check_circle_outline, size: 52, color: success),
          const SizedBox(height: 12),
          Text(
            S.of(context).deliveredSuccess,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: success,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            S.of(context).deliveredSuccessMessage,
            style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
