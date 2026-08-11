import 'package:flutter/material.dart';
import 'package:delivery_app/features/catalog/presentation/pages/catalog_search_page.dart';

/// Compatibility route owner while callers migrate to [CatalogSearchPage].
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => const CatalogSearchPage();
}
