import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';

import '../../application/catalog_restaurant_detail_effect.dart';
import '../../application/catalog_restaurant_detail_intent.dart';
import '../../application/catalog_restaurant_detail_state.dart';
import '../../application/catalog_restaurant_detail_view_model.dart';
import '../views/catalog_restaurant_detail_view.dart';
import '../components/catalog_restaurant_detail_parts.dart';

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
    final addressState = ref.watch(userAddressListProvider);
    final selectedAddress =
        addressState.selectedAddress ?? addressState.defaultAddress;
    return CatalogRestaurantDetailView(
      state: ref.watch(provider),
      previewMode: true,
      deliveryAddressLabel: selectedAddress?.label,
      onManageAddress:
          () => context.push('${AppRoutes.addressList}?context=home'),
      onOpenVoucher: () => context.push(AppRoutes.vouchers),
      onIntent:
          (intent) => unawaited(ref.read(provider.notifier).dispatch(intent)),
      onItemOpen:
          (item) => unawaited(
            showCatalogMenuItemSheet(
              context: context,
              item: item,
              onAdd: () {},
              onAddWithDetails:
                  (quantity, notes) => unawaited(
                    ref
                        .read(provider.notifier)
                        .dispatch(
                          CatalogRestaurantDetailAddRequested(
                            item.id!,
                            quantity: quantity,
                            notes: notes,
                          ),
                        ),
                  ),
            ),
          ),
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
      builder:
          (dialogContext) => AlertDialog(
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

/// Route adapter owns sheet navigation; content only emits callbacks.
Future<void> showCatalogMenuItemSheet({
  required BuildContext context,
  required CatalogMenuItemViewData item,
  required VoidCallback onAdd,
  void Function(int quantity, String? notes)? onAddWithDetails,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
  ),
  clipBehavior: Clip.antiAlias,
  builder:
      (sheetContext) => CatalogMenuItemSheet(
        item: item,
        onClose: () => Navigator.of(sheetContext).pop(),
        onAdd: (quantity, notes) {
          Navigator.of(sheetContext).pop();
          if (onAddWithDetails != null) {
            onAddWithDetails(quantity, notes);
          } else {
            onAdd();
          }
        },
      ),
);
