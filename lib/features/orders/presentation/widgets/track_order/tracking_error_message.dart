import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';

class TrackingErrorMessage extends StatelessWidget {
  final String error;
  final VoidCallback? onClear;

  const TrackingErrorMessage({super.key, required this.error, this.onClear});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.error.withValues(alpha: 0.07),
        borderRadius: PreviewUi.controlRadius,
        border: Border.all(color: scheme.error.withValues(alpha: 0.24)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: scheme.error, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: TextStyle(color: scheme.error, fontSize: 13),
            ),
          ),
          if (onClear != null)
            IconButton(
              onPressed: onClear,
              tooltip: 'Đóng',
              icon: Icon(Icons.close, color: scheme.error, size: 20),
            ),
        ],
      ),
    );
  }
}
