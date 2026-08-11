import 'package:delivery_app/features/catalog/presentation/pages/catalog_all_restaurants_page.dart';
import 'package:flutter/material.dart';

/// Compatibility route entry point; Catalog owns customer restaurant browsing.
class AllRestaurantsScreen extends StatelessWidget {
  const AllRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) => const CatalogAllRestaurantsPage();
}
