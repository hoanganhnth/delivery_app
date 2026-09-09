import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';

class TrackingFindingShipperCard extends StatelessWidget {
  const TrackingFindingShipperCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewSurface(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 30),
      child: Column(
        children: [
          const Icon(
            Icons.person_search_outlined,
            size: 48,
            color: PreviewUi.accent,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).findingDriver,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: PreviewUi.text(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).mapWillShowWhenDriverAccepts,
            style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
