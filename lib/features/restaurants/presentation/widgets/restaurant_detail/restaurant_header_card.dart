import 'package:delivery_app/features/restaurants/presentation/widgets/shared/restaurant_card.dart';
import 'package:flutter/material.dart';

/// Compact restaurant identity section used by checkout surfaces.
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
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: RestaurantCard(
      name: name,
      imageUrl: logoUrl,
      rating: rating,
      distance: distance,
      onTap: onTap,
    ),
  );
}
