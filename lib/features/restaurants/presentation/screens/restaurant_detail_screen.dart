import 'package:flutter/material.dart';
import 'package:delivery_app/features/catalog/presentation/pages/catalog_restaurant_detail_page.dart';

/// Compatibility route owner while catalog callers migrate to the new page.
class RestaurantDetailScreen extends StatelessWidget {
  final num restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) =>
      CatalogRestaurantDetailPage(restaurantId: restaurantId);
}
