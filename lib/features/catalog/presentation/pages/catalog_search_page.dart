import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/design_system/components/preview_bottom_navigation.dart';
import 'package:delivery_app/features/cart/application/cart_notifier.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/contracts/session_contract.dart';
import 'package:delivery_app/core/contracts/session_port_provider.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';

import '../../application/catalog_search_effect.dart';
import '../../application/catalog_search_intent.dart';
import '../../application/catalog_preview_fixtures.dart';
import '../../application/catalog_search_state.dart';
import '../../application/catalog_search_view_model.dart';
import '../views/catalog_search_view.dart';

class CatalogSearchPage extends ConsumerStatefulWidget {
  const CatalogSearchPage({super.key});

  @override
  ConsumerState<CatalogSearchPage> createState() => _CatalogSearchPageState();
}

class _CatalogSearchPageState extends ConsumerState<CatalogSearchPage> {
  StreamSubscription<SessionSnapshot>? _sessionSubscription;
  int? _loadedProfileId;
  int? _loadingProfileId;

  @override
  void initState() {
    super.initState();
    final session = ref.read(sessionPortProvider);
    _sessionSubscription = session.changes.listen((snapshot) {
      _loadAddresses(snapshot.profileId);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadAddresses(session.current.profileId);
      unawaited(
        ref
            .read(catalogSearchViewModelProvider.notifier)
            .dispatch(const CatalogSearchLoadRequested()),
      );
    });
  }

  @override
  void dispose() {
    unawaited(_sessionSubscription?.cancel());
    super.dispose();
  }

  void _loadAddresses(int? profileId) {
    final notifier = ref.read(userAddressListProvider.notifier);
    if (profileId == null || profileId <= 0) {
      _loadedProfileId = null;
      _loadingProfileId = null;
      notifier.clear();
      return;
    }
    if (profileId == _loadedProfileId || profileId == _loadingProfileId) {
      return;
    }

    _loadingProfileId = profileId;
    unawaited(() async {
      final loaded = await notifier.loadAddresses(profileId);
      if (!mounted) return;
      if (_loadingProfileId == profileId) _loadingProfileId = null;
      if (!loaded) return;
      _loadedProfileId = profileId;
      notifier.autoSelectDefaultAddress();
    }());
  }

  @override
  Widget build(BuildContext context) {
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

    final addressState = ref.watch(userAddressListProvider);
    final deliveryAddress =
        addressState.selectedAddress?.fullAddress ??
        addressState.defaultAddress?.fullAddress;
    final cartItemCount = ref.watch(cartProvider).value?.totalItems ?? 0;

    return CatalogSearchView(
      previewMode: true,
      state: ref.watch(catalogSearchViewModelProvider),
      deliveryAddress: deliveryAddress,
      onBack: () {
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.main);
        }
      },
      onManageAddress:
          () => context.push('${AppRoutes.addressList}?context=home'),
      onHome: () => context.go(AppRoutes.main),
      bottomNavigationBar: PreviewBottomNavigation(
        currentIndex: 0,
        cartItemCount: cartItemCount,
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
      onIntent:
          (intent) => unawaited(
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
        final parsedId = int.tryParse(restaurantId);
        final targetId =
            parsedId != null && parsedId > 0
                ? parsedId
                : catalogPreviewRestaurantIdFor(restaurantId);
        if (context.mounted && targetId != null) {
          context.pushToRestaurantDetails('$targetId');
        }
    }
    await ref
        .read(catalogSearchViewModelProvider.notifier)
        .dispatch(CatalogSearchEffectConsumed(effectId));
  }
}
