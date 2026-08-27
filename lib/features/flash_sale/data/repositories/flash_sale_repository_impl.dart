import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/flash_sale_campaign_entity.dart';
import '../../domain/entities/flash_sale_item_entity.dart';
import '../../domain/repositories/flash_sale_repository.dart';
import '../datasources/flash_sale_remote_data_source.dart';
import '../datasources/flash_sale_remote_data_source_impl.dart';

class FlashSaleRepositoryImpl implements FlashSaleRepository {
  const FlashSaleRepositoryImpl({
    required FlashSaleRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final FlashSaleRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<FlashSaleCampaignEntity>>>
  getActiveCampaigns() async {
    try {
      final models = await _remoteDataSource.getActiveCampaigns();
      return right(
        models.map((model) => model.toEntity()).toList(growable: false),
      );
    } on Exception catch (error) {
      return left(mapExceptionToFailure(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getCampaignItems(
    int campaignId,
  ) async {
    try {
      final models = await _remoteDataSource.getCampaignItems(campaignId);
      return right(
        models.map((model) => model.toEntity()).toList(growable: false),
      );
    } on Exception catch (error) {
      return left(mapExceptionToFailure(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FlashSaleItemEntity>>> getRestaurantItems(
    int restaurantId,
  ) async {
    if (restaurantId <= 0) {
      return left(const ValidationFailure('Invalid restaurant identity'));
    }
    try {
      final campaigns = await _remoteDataSource.getActiveCampaigns();
      final campaignItems = await Future.wait(
        campaigns.map(
          (campaign) => _remoteDataSource.getCampaignItems(campaign.id),
        ),
      );
      final items = <FlashSaleItemEntity>[];
      for (var index = 0; index < campaigns.length; index++) {
        final campaign = campaigns[index];
        for (final model in campaignItems[index]) {
          final item = model.toEntity();
          if (!item.isApproved ||
              item.restaurantId != restaurantId ||
              !item.hasStock) {
            continue;
          }
          items.add(
            FlashSaleItemEntity(
              id: item.id,
              campaignId: item.campaignId,
              restaurantId: item.restaurantId,
              menuItemId: item.menuItemId,
              originalPrice: item.originalPrice,
              flashSalePrice: item.flashSalePrice,
              stockQuantity: item.stockQuantity,
              soldQuantity: item.soldQuantity,
              status: item.status,
              campaignName: campaign.name,
              menuItemName: item.menuItemName,
              imageUrl: item.imageUrl,
            ),
          );
        }
      }
      final byMenuItem = <int, FlashSaleItemEntity>{};
      for (final item in items) {
        if (byMenuItem.containsKey(item.menuItemId)) {
          throw const FormatException(
            'Multiple active flash-sale items target one menu item',
          );
        }
        byMenuItem[item.menuItemId] = item;
      }
      return right(byMenuItem.values.toList(growable: false));
    } on Exception catch (error) {
      return left(mapExceptionToFailure(error));
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }
}

/// Compatibility client for callers that need a Gateway-only catalog lookup.
class FlashSaleCatalogClient {
  FlashSaleCatalogClient(Dio dio)
    : _repository = FlashSaleRepositoryImpl(
        remoteDataSource: FlashSaleRemoteDataSourceImpl(dio),
      );

  final FlashSaleRepository _repository;

  Future<Map<int, FlashSaleItemEntity>> getRestaurantItems(
    int restaurantId,
  ) async {
    final result = await _repository.getRestaurantItems(restaurantId);
    return result.fold(
      (failure) => switch (failure) {
        ValidationFailure() => throw FormatException(failure.message),
        _ => throw Exception(failure.message),
      },
      (items) =>
          Map.unmodifiable({for (final item in items) item.menuItemId: item}),
    );
  }
}
