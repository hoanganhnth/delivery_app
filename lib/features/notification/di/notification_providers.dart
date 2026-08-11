import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/features/notification/data/datasources/notification_api_service.dart';
import 'package:delivery_app/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:delivery_app/features/notification/domain/repositories/notification_repository.dart';

/// Feature composition root. Application code depends on the repository
/// abstraction; the REST/Dio implementation is selected only here.
final notificationApiServiceProvider = Provider<NotificationApiService>((ref) {
  return NotificationApiService(ref.watch(authenticatedDioProvider));
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(ref.watch(notificationApiServiceProvider));
});
