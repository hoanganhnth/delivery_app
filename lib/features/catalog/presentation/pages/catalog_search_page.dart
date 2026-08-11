import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';

import '../../application/catalog_search_effect.dart';
import '../../application/catalog_search_intent.dart';
import '../../application/catalog_search_state.dart';
import '../../application/catalog_search_view_model.dart';
import '../views/catalog_search_view.dart';

class CatalogSearchPage extends ConsumerWidget {
  const CatalogSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<CatalogSearchViewState>(catalogSearchViewModelProvider, (
      previous,
      next,
    ) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(context, ref, envelope.id, envelope.effect));
        }
      }
    });

    return CatalogSearchView(
      state: ref.watch(catalogSearchViewModelProvider),
      onIntent: (intent) => unawaited(
        ref.read(catalogSearchViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(
    BuildContext context,
    WidgetRef ref,
    int effectId,
    CatalogSearchEffect effect,
  ) async {
    switch (effect) {
      case CatalogSearchNavigateToRestaurant(:final restaurantId):
        if (context.mounted) context.pushToRestaurantDetails(restaurantId);
    }
    await ref
        .read(catalogSearchViewModelProvider.notifier)
        .dispatch(CatalogSearchEffectConsumed(effectId));
  }
}
