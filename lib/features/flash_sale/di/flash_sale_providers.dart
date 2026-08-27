import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/runtime_config.dart';
import '../../../core/network/_riverpod/network_providers.dart';
import '../data/datasources/flash_sale_remote_data_source.dart';
import '../data/datasources/flash_sale_remote_data_source_impl.dart';
import '../data/repositories/flash_sale_repository_impl.dart';
import '../domain/entities/flash_sale_item_entity.dart';
import '../domain/repositories/flash_sale_repository.dart';
import '../domain/usecases/flash_sale_usecases.dart';

final flashSaleRemoteDataSourceProvider = Provider<FlashSaleRemoteDataSource>(
  (ref) => FlashSaleRemoteDataSourceImpl(ref.watch(dioProvider)),
);

final flashSaleCheckoutEnabledProvider = Provider<bool>(
  (ref) => RuntimeConfig.flashSaleCheckoutEnabled,
);

final flashSaleRepositoryProvider = Provider<FlashSaleRepository>(
  (ref) => FlashSaleRepositoryImpl(
    remoteDataSource: ref.watch(flashSaleRemoteDataSourceProvider),
  ),
);

final getActiveFlashSaleCampaignsUseCaseProvider =
    Provider<GetActiveFlashSaleCampaignsUseCase>(
      (ref) => GetActiveFlashSaleCampaignsUseCase(
        ref.watch(flashSaleRepositoryProvider),
      ),
    );

final getFlashSaleCampaignItemsUseCaseProvider =
    Provider<GetFlashSaleCampaignItemsUseCase>(
      (ref) => GetFlashSaleCampaignItemsUseCase(
        ref.watch(flashSaleRepositoryProvider),
      ),
    );

final restaurantFlashSaleItemsProvider = FutureProvider.autoDispose
    .family<Map<int, FlashSaleItemEntity>, int>((ref, restaurantId) async {
      if (!ref.watch(flashSaleCheckoutEnabledProvider)) return const {};
      if (restaurantId <= 0) {
        throw const FormatException('Invalid restaurant identity');
      }
      final result = await ref
          .read(flashSaleRepositoryProvider)
          .getRestaurantItems(restaurantId);
      return result.fold(
        (failure) => throw Exception(failure.message),
        (items) =>
            Map.unmodifiable({for (final item in items) item.menuItemId: item}),
      );
    });
