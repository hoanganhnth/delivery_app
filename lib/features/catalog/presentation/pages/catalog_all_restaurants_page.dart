import 'dart:async';

import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/design_system/components/preview_bottom_navigation.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_effect.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_intent.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_state.dart';
import 'package:delivery_app/features/catalog/application/catalog_all_restaurants_view_model.dart';
import 'package:delivery_app/features/catalog/presentation/views/catalog_all_restaurants_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogAllRestaurantsPage extends ConsumerStatefulWidget {
  const CatalogAllRestaurantsPage({super.key});

  @override
  ConsumerState<CatalogAllRestaurantsPage> createState() =>
      _CatalogAllRestaurantsPageState();
}

class _CatalogAllRestaurantsPageState
    extends ConsumerState<CatalogAllRestaurantsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(
          ref
              .read(catalogAllRestaurantsViewModelProvider.notifier)
              .dispatch(const CatalogAllRestaurantsLoadRequested()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CatalogAllRestaurantsViewState>(
      catalogAllRestaurantsViewModelProvider,
      (previous, next) {
        final handledIds = {
          for (final envelope in previous?.effects ?? const []) envelope.id,
        };
        for (final envelope in next.effects) {
          if (!handledIds.contains(envelope.id)) {
            unawaited(_handleEffect(envelope.id, envelope.effect));
          }
        }
      },
    );
    return CatalogAllRestaurantsView(
      state: ref.watch(catalogAllRestaurantsViewModelProvider),
      previewMode: true,
      onBack: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.main);
        }
      },
      onCart: () => context.go(AppRoutes.cart),
      bottomNavigationBar: PreviewBottomNavigation(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.main);
            case 1:
              context.go(AppRoutes.orders);
            case 2:
              context.go(AppRoutes.cart);
            case 3:
              context.go(AppRoutes.profile);
          }
        },
      ),
      onIntent: (intent) => unawaited(
        ref
            .read(catalogAllRestaurantsViewModelProvider.notifier)
            .dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(
    int effectId,
    CatalogAllRestaurantsEffect effect,
  ) async {
    if (!mounted) return;
    switch (effect) {
      case CatalogAllRestaurantsNavigateBack():
        if (context.canPop()) context.pop();
      case CatalogAllRestaurantsNavigateToSearch():
        context.push(AppRoutes.search);
      case CatalogAllRestaurantsNavigateToDetail(:final restaurantId):
        context.pushToRestaurantDetails(restaurantId.toString());
    }
    if (mounted) {
      await ref
          .read(catalogAllRestaurantsViewModelProvider.notifier)
          .dispatch(CatalogAllRestaurantsEffectConsumed(effectId));
    }
  }
}
