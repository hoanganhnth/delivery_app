import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/catalog_restaurant_detail_effect.dart';
import '../../application/catalog_restaurant_detail_intent.dart';
import '../../application/catalog_restaurant_detail_state.dart';
import '../../application/catalog_restaurant_detail_view_model.dart';
import '../views/catalog_restaurant_detail_view.dart';

class CatalogRestaurantDetailPage extends ConsumerStatefulWidget {
  const CatalogRestaurantDetailPage({super.key, required this.restaurantId});

  final num restaurantId;

  @override
  ConsumerState<CatalogRestaurantDetailPage> createState() =>
      _CatalogRestaurantDetailPageState();
}

class _CatalogRestaurantDetailPageState
    extends ConsumerState<CatalogRestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        ref
            .read(
              catalogRestaurantDetailViewModelProvider(
                widget.restaurantId,
              ).notifier,
            )
            .dispatch(const CatalogRestaurantDetailLoadRequested()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = catalogRestaurantDetailViewModelProvider(
      widget.restaurantId,
    );
    ref.listen<CatalogRestaurantDetailViewState>(provider, (previous, next) {
      final previousIds = {
        for (final effect in previous?.effects ?? const []) effect.id,
      };
      for (final envelope in next.effects) {
        if (!previousIds.contains(envelope.id)) {
          unawaited(_handleEffect(provider, envelope.id, envelope.effect));
        }
      }
    });
    return CatalogRestaurantDetailView(
      state: ref.watch(provider),
      onIntent: (intent) =>
          unawaited(ref.read(provider.notifier).dispatch(intent)),
    );
  }

  Future<void> _handleEffect(
    NotifierProvider<
      CatalogRestaurantDetailViewModel,
      CatalogRestaurantDetailViewState
    >
    provider,
    int effectId,
    CatalogRestaurantDetailEffect effect,
  ) async {
    switch (effect) {
      case CatalogRestaurantDetailNavigateBack():
        if (mounted && context.canPop()) context.pop();
      case CatalogRestaurantDetailNavigateToCart():
        if (mounted) context.pushCart();
      case CatalogRestaurantDetailConfirmRestaurantChange(:final menuItemId):
        if (mounted) await _showRestaurantChangeDialog(provider, menuItemId);
      case CatalogRestaurantDetailShowError(:final message):
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
    }
    await ref
        .read(provider.notifier)
        .dispatch(CatalogRestaurantDetailEffectConsumed(effectId));
  }

  Future<void> _showRestaurantChangeDialog(
    NotifierProvider<
      CatalogRestaurantDetailViewModel,
      CatalogRestaurantDetailViewState
    >
    provider,
    num menuItemId,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(dialogContext).cannotAddItem),
        content: Text(S.of(dialogContext).differentRestaurantError),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(S.of(dialogContext).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(S.of(dialogContext).clearCurrentCart),
          ),
        ],
      ),
    );
    if (confirm == true && mounted) {
      await ref
          .read(provider.notifier)
          .dispatch(
            CatalogRestaurantDetailRestaurantChangeConfirmed(menuItemId),
          );
    }
  }
}
