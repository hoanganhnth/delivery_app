import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/contracts/session_contract.dart';
import 'package:delivery_app/core/contracts/session_port_provider.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/flash_sale/presentation/pages/flash_sale_banner_page.dart';
import 'package:delivery_app/features/user_address/application/address_list_notifier.dart';
import 'package:delivery_app/features/user_address/application/address_store_state.dart';

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
            .read(catalogHomeViewModelProvider.notifier)
            .dispatch(const CatalogHomeLoadRequested()),
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

      if (_loadingProfileId == profileId) {
        _loadingProfileId = null;
      }
      if (!loaded) {
        if (_loadedProfileId == profileId) {
          _loadedProfileId = null;
        }
        return;
      }

      _loadedProfileId = profileId;
      notifier.autoSelectDefaultAddress();
    }());
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

    ref.listen<UserAddressListState>(userAddressListProvider, (previous, next) {
      if (previous?.selectedAddress?.id != next.selectedAddress?.id) {
        unawaited(
          ref
              .read(catalogHomeViewModelProvider.notifier)
              .dispatch(const CatalogHomeLoadRequested()),
        );
      }
    });

    final addressState = ref.watch(userAddressListProvider);
    final deliveryAddress =
        addressState.selectedAddress?.fullAddress ??
        addressState.defaultAddress?.fullAddress;

    return CatalogHomeView(
      state: ref.watch(catalogHomeViewModelProvider),
      deliveryAddress: deliveryAddress,
      flashSaleBanner: const FlashSaleBannerPage(),
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
        await context.push('${AppRoutes.addressList}?context=home');
        if (mounted) {
          unawaited(
            ref
                .read(catalogHomeViewModelProvider.notifier)
                .dispatch(const CatalogHomeLoadRequested()),
          );
        }
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
