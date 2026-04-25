import 'package:flutter/material.dart';

/// Editorial header với decorative line (Stitch style)
/// Sử dụng cho section headers với branding elements
class EditorialHeader extends StatelessWidget {
  final String subtitle;
  final String title;
  final String? titleHighlight; // Part of title to highlight
  final String? description;
  final Color? lineColor;
  final Color? subtitleColor;
  final Color? titleColor;
  final Color? highlightColor;
  final double? maxDescriptionWidth;

  const EditorialHeader({
    super.key,
    required this.subtitle,
    required this.title,
    this.titleHighlight,
    this.description,
    this.lineColor,
    this.subtitleColor,
    this.titleColor,
    this.highlightColor,
    this.maxDescriptionWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Decorative line + subtitle
        Row(
          children: [
            Container(
              height: 8,
              width: 32,
              decoration: BoxDecoration(
                color: lineColor ?? theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              subtitle.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                color: subtitleColor ?? theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Main title with optional highlight
        if (titleHighlight != null) ...[
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                height: 1.1,
                letterSpacing: -1.0,
                color: titleColor ?? theme.colorScheme.onSurface,
              ),
              children: [
                TextSpan(text: _getTitleBeforeHighlight()),
                if (_getTitleBeforeHighlight().isNotEmpty) const TextSpan(text: '\n'),
                TextSpan(
                  text: titleHighlight,
                  style: TextStyle(
                    color: highlightColor ?? theme.colorScheme.primary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          Text(
            title,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: -1.0,
              color: titleColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
        // Description
        if (description != null) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: maxDescriptionWidth ?? 280,
            child: Text(
              description!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: subtitleColor ?? theme.colorScheme.secondary,
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _getTitleBeforeHighlight() {
    if (titleHighlight == null) return title;
    final index = title.indexOf(titleHighlight!);
    if (index == -1) return title;
    return title.substring(0, index).trim();
  }
}
