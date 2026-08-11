import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';

import '../../application/catalog_home_effect.dart';
import '../../application/catalog_home_intent.dart';
import '../../application/catalog_home_state.dart';
import '../../application/catalog_home_view_model.dart';
import '../views/catalog_home_view.dart';

/// Riverpod and navigation adapter for the catalog landing tab.
class CatalogHomePage extends ConsumerStatefulWidget {
  const CatalogHomePage({super.key});

  @override
  ConsumerState<CatalogHomePage> createState() => _CatalogHomePageState();
}

class _CatalogHomePageState extends ConsumerState<CatalogHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref
            .read(catalogHomeViewModelProvider.notifier)
            .dispatch(const CatalogHomeLoadRequested()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CatalogHomeViewState>(catalogHomeViewModelProvider, (
      previous,
      next,
    ) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(envelope.id, envelope.effect));
        }
      }
    });

    return CatalogHomeView(
      state: ref.watch(catalogHomeViewModelProvider),
      onIntent: (intent) => unawaited(
        ref.read(catalogHomeViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(int effectId, CatalogHomeEffect effect) async {
    if (!mounted) return;
    switch (effect) {
      case CatalogHomeNavigateToSearch():
        context.push(AppRoutes.search);
      case CatalogHomeNavigateToAllRestaurants():
        context.pushToRestaurants();
      case CatalogHomeNavigateToAddresses():
        context.pushAddressList();
      case CatalogHomeNavigateToNotifications():
        context.push(AppRoutes.notifications);
      case CatalogHomeNavigateToCart():
        context.pushCart();
      case CatalogHomeNavigateToRestaurant(:final restaurantId):
        context.pushToRestaurantDetails(restaurantId.toString());
    }
    await ref
        .read(catalogHomeViewModelProvider.notifier)
        .dispatch(CatalogHomeEffectConsumed(effectId));
  }
}
