import 'package:delivery_app/core/config/runtime_config.dart';
import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/features/auth/presentation/providers/di/auth_network_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogFlashSaleItem {
  const CatalogFlashSaleItem({
    required this.id,
    required this.restaurantId,
    required this.menuItemId,
    required this.flashSalePrice,
    required this.stockQuantity,
    required this.soldQuantity,
  });

  final int id;
  final int restaurantId;
  final int menuItemId;
  final double flashSalePrice;
  final int stockQuantity;
  final int soldQuantity;

  factory CatalogFlashSaleItem.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final restaurantId = json['restaurantId'];
    final menuItemId = json['menuItemId'];
    final price = json['flashSalePrice'];
    final stock = json['stockQuantity'];
    final sold = json['soldQuantity'];
    final status = json['status'];
    if (id is! num ||
        id.toInt() <= 0 ||
        restaurantId is! num ||
        restaurantId.toInt() <= 0 ||
        menuItemId is! num ||
        menuItemId.toInt() <= 0 ||
        price is! num ||
        price <= 0 ||
        stock is! num ||
        stock.toInt() <= 0 ||
        sold is! num ||
        sold.toInt() < 0 ||
        sold.toInt() > stock.toInt() ||
        status != 'APPROVED') {
      throw const FormatException('Invalid flash-sale catalog item');
    }
    return CatalogFlashSaleItem(
      id: id.toInt(),
      restaurantId: restaurantId.toInt(),
      menuItemId: menuItemId.toInt(),
      flashSalePrice: price.toDouble(),
      stockQuantity: stock.toInt(),
      soldQuantity: sold.toInt(),
    );
  }

  bool get hasStock => soldQuantity < stockQuantity;
}

class FlashSaleCatalogClient {
  const FlashSaleCatalogClient(this._dio);

  final Dio _dio;

  Future<Map<int, CatalogFlashSaleItem>> getRestaurantItems(
    int restaurantId,
  ) async {
    final campaigns = await _getList(ApiConstants.activeFlashSaleCampaigns);
    final byMenuItem = <int, CatalogFlashSaleItem>{};
    for (final campaign in campaigns) {
      final campaignId = campaign['id'];
      if (campaignId is! num || campaignId.toInt() <= 0) {
        throw const FormatException('Invalid flash-sale campaign identity');
      }
      final items = await _getList(
        ApiConstants.flashSaleCampaignItems(campaignId.toInt()),
      );
      for (final raw in items) {
        final item = CatalogFlashSaleItem.fromJson(raw);
        if (item.restaurantId != restaurantId || !item.hasStock) continue;
        if (byMenuItem.containsKey(item.menuItemId)) {
          throw const FormatException(
            'Multiple active flash-sale items target one menu item',
          );
        }
        byMenuItem[item.menuItemId] = item;
      }
    }
    return Map.unmodifiable(byMenuItem);
  }

  Future<List<Map<String, dynamic>>> _getList(String path) async {
    final response = await _dio.get<Map<String, dynamic>>(path);
    final envelope = response.data;
    if (envelope == null ||
        envelope['status'] != 1 ||
        envelope['data'] is! List) {
      throw const FormatException('Invalid flash-sale catalog envelope');
    }
    return (envelope['data'] as List<dynamic>)
        .map((item) {
          if (item is! Map) {
            throw const FormatException('Invalid flash-sale catalog payload');
          }
          return Map<String, dynamic>.from(item);
        })
        .toList(growable: false);
  }
}

final restaurantFlashSaleItemsProvider = FutureProvider.autoDispose
    .family<Map<int, CatalogFlashSaleItem>, int>((ref, restaurantId) async {
      if (!RuntimeConfig.flashSaleCheckoutEnabled) return const {};
      if (restaurantId <= 0) {
        throw const FormatException('Invalid restaurant identity');
      }
      return FlashSaleCatalogClient(
        ref.watch(authAwareDioProvider),
      ).getRestaurantItems(restaurantId);
    });
