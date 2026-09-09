import 'package:delivery_app/core/design_system/components/app_image.dart';
import 'package:flutter/material.dart';

/// Compact, full-width restaurant row. Only supplied catalog facts are shown.
class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.name,
    this.imageUrl,
    this.rating,
    this.deliveryTime,
    this.category,
    this.priceLevel,
    this.distance,
    this.deliveryFee,
    this.isFreeDelivery = false,
    this.onTap,
    this.badgeLabel,
    this.promotionLabels = const [],
    this.metadataSeparator = '  ·  ',
  });

  final String name;
  final String? imageUrl;
  final double? rating;
  final String? deliveryTime;
  final String? category;
  final String? priceLevel;
  final String? distance;
  final String? deliveryFee;
  final bool isFreeDelivery;
  final VoidCallback? onTap;
  final String? badgeLabel;
  final List<String> promotionLabels;
  final String metadataSeparator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final details = [
      category,
      priceLevel,
    ].whereType<String>().where((value) => value.trim().isNotEmpty);
    final metadata = [
      if (rating != null) rating!.toStringAsFixed(1),
      if (distance?.trim().isNotEmpty == true) distance!,
      if (deliveryTime?.trim().isNotEmpty == true) deliveryTime!,
    ];
    return Material(
      color: scheme.surface,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppContentImage(
                imageUrl: imageUrl,
                semanticLabel: name,
                width: 86,
                height: 86,
                borderRadius: BorderRadius.circular(3),
                placeholderIcon: Icons.restaurant,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (badgeLabel != null)
                          Container(
                            margin: const EdgeInsets.only(right: 4, top: 2),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.primary,
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: Text(
                              badgeLabel!,
                              style: TextStyle(
                                color: scheme.onPrimary,
                                fontSize: 9,
                                height: 1.1,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (metadata.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            if (rating != null)
                              WidgetSpan(
                                child: Icon(
                                  Icons.star,
                                  size: 14,
                                  color: scheme.primary,
                                ),
                              ),
                            TextSpan(text: metadata.join(metadataSeparator)),
                          ],
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (details.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        details.join(' · '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (deliveryFee?.trim().isNotEmpty == true) ...[
                      const SizedBox(height: 7),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                isFreeDelivery
                                    ? scheme.primary
                                    : scheme.outlineVariant,
                          ),
                        ),
                        child: Text(
                          deliveryFee!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color:
                                isFreeDelivery
                                    ? scheme.primary
                                    : scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                    if (promotionLabels.isNotEmpty) ...[
                      const SizedBox(height: 7),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          for (
                            var index = 0;
                            index < promotionLabels.length;
                            index++
                          )
                            _PromotionTag(
                              label: promotionLabels[index],
                              highlighted: index == 0,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromotionTag extends StatelessWidget {
  const _PromotionTag({required this.label, required this.highlighted});

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            highlighted
                ? Colors.transparent
                : scheme.primary.withValues(alpha: .08),
        border: Border.all(
          color:
              highlighted
                  ? scheme.primary
                  : scheme.primary.withValues(alpha: .08),
        ),
        borderRadius: BorderRadius.circular(1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        child: Text(
          label,
          style: TextStyle(
            color:
                highlighted
                    ? scheme.primary
                    : scheme.primary.withValues(alpha: .78),
            fontSize: 9,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
