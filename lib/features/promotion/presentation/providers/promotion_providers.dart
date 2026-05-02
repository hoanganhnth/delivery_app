import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/_riverpod/authenticated_network_providers.dart';
import '../../data/data_sources/promotion_data_source.dart';
import '../../data/repositories_impl/promotion_repository_impl.dart';
import '../../domain/repositories/promotion_repository.dart';

part 'promotion_providers.g.dart';

// Provides the Promotion API Gateway URL
@riverpod
String promotionBaseUrl(Ref ref) {
  return 'http://localhost:8079/api/promotions'; // Use gateway URL!
}

@riverpod
PromotionDataSource promotionDataSource(Ref ref) {
  final authDio = ref.watch(authenticatedDioProvider);
  final promoDio = Dio(BaseOptions(
    baseUrl: ref.watch(promotionBaseUrlProvider),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  promoDio.interceptors.addAll(authDio.interceptors);
  return PromotionDataSource(promoDio);
}

@riverpod
PromotionRepository promotionRepository(Ref ref) {
  final dataSource = ref.watch(promotionDataSourceProvider);
  return PromotionRepositoryImpl(dataSource);
}
