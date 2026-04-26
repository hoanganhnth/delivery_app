import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/notification/data/datasources/notification_api_service.dart';
import 'package:delivery_app/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:delivery_app/features/notification/domain/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_providers.g.dart';

// API Service Provider
@Riverpod(keepAlive: true)
NotificationApiService notificationApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return NotificationApiService(dio);
}

// Repository Provider
@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  final apiService = ref.watch(notificationApiServiceProvider);
  return NotificationRepositoryImpl(apiService);
}
