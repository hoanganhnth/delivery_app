import 'package:flutter/material.dart';
import 'package:delivery_app/features/catalog/presentation/pages/catalog_home_page.dart';

/// Compatibility route owner while catalog callers migrate to [CatalogHomePage].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const CatalogHomePage();
}
