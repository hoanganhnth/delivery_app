import 'package:flutter/material.dart';

/// Shared restaurant identity card used by Cart and other bounded contexts.
/// It accepts display facts only and has no feature dependencies.
class RestaurantHeaderCard extends StatelessWidget {
  const RestaurantHeaderCard({
    super.key,
    required this.name,
    this.logoUrl,
    this.rating,
    this.distance,
    this.onTap,
  });

  final String name;
  final String? logoUrl;
  final double? rating;
  final String? distance;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: logoUrl == null ? null : NetworkImage(logoUrl!),
              child: logoUrl == null ? const Icon(Icons.restaurant) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ĐANG ĐẶT TẠI', style: TextStyle(fontSize: 10)),
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  if (rating != null || distance != null)
                    Text(
                      [
                        if (rating != null) '★ ${rating!.toStringAsFixed(1)}',
                        if (distance != null) distance!,
                      ].join(' • '),
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
