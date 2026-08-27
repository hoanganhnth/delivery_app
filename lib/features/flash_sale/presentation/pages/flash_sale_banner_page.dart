import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/routing/routing.dart';

import '../../application/flash_sale_view_model.dart';
import '../views/flash_sale_banner_view.dart';

class FlashSaleBannerPage extends ConsumerStatefulWidget {
  const FlashSaleBannerPage({super.key});

  @override
  ConsumerState<FlashSaleBannerPage> createState() =>
      _FlashSaleBannerPageState();
}

class _FlashSaleBannerPageState extends ConsumerState<FlashSaleBannerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(ref.read(flashSaleViewModelProvider.notifier).load());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlashSaleBannerView(
      state: ref.watch(flashSaleViewModelProvider),
      onRestaurantSelected: (restaurantId) =>
          context.pushToRestaurantDetails(restaurantId.toString()),
      onRefreshRequested: () => unawaited(
        ref.read(flashSaleViewModelProvider.notifier).load(force: true),
      ),
    );
  }
}
