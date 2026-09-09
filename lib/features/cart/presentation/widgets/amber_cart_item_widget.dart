import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Native phone cart row. The legacy name is kept for existing callers.
class AmberCartItemWidget extends StatelessWidget {
  const AmberCartItemWidget({
    super.key,
    required this.name,
    this.imageUrl,
    this.subtitle,
    required this.price,
    required this.quantity,
    this.onIncrease,
    this.onDecrease,
    this.onTap,
  });
  final String name;
  final String? imageUrl;
  final String? subtitle;
  final String price;
  final int quantity;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Icon(Icons.restaurant, color: scheme.onSurfaceVariant),
    );
    return Material(
      color: scheme.surface,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: imageUrl?.isNotEmpty == true
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, _) => placeholder,
                          errorWidget: (_, _, _) => placeholder,
                        )
                      : placeholder,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle?.isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: '− $name',
                            onPressed: onDecrease,
                            icon: const Icon(Icons.remove),
                            color: scheme.primary,
                          ),
                          Semantics(liveRegion: true, child: Text('$quantity')),
                          IconButton(
                            tooltip: '+ $name',
                            onPressed: onIncrease,
                            icon: const Icon(Icons.add),
                            color: scheme.primary,
                          ),
                        ],
                      ),
                    ),
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
