import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('network logging never records headers or payload bodies', () {
    final source = File(
      'lib/core/network/dio/interceptors/logging_interceptor.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('options.headers')));
    expect(source, isNot(contains('options.data')));
    expect(source, isNot(contains('response.data')));
    expect(source, isNot(contains('response?.data')));
  });

  test('expired-session callback cannot invoke authenticated logout cleanup', () {
    final wiring = File(
      'lib/features/auth/presentation/providers/di/auth_network_providers.dart',
    ).readAsStringSync();
    final profile = File(
      'lib/features/profile/presentation/pages/profile_page.dart',
    ).readAsStringSync();
    final pushBackend = File(
      'lib/core/services/push/firebase_push_adapters.dart',
    ).readAsStringSync();

    expect(wiring, contains('onUnauthorized: authNotifier.handleUnauthorized'));
    expect(wiring, isNot(contains('onUnauthorized: authNotifier.logout')));
    expect(profile, isNot(contains('appInitializerServiceProvider).cleanup')));
    expect(pushBackend, contains('AuthInterceptor.skipAuthRefreshKey'));
  });

  test('auth, socket, map and order logs never include user payloads', () {
    final auth = File(
      'lib/features/auth/data/datasources/auth_remote_datasource_impl.dart',
    ).readAsStringSync();
    final socket = File(
      'lib/core/network/socket/socket_client.dart',
    ).readAsStringSync();
    final map = File(
      'lib/features/orders/data/services/mapbox_map_service.dart',
    ).readAsStringSync();
    final order = File(
      'lib/features/orders/data/datasources/order_remote_datasource_impl.dart',
    ).readAsStringSync();

    expect(auth, isNot(contains(r'${request.email}')));
    expect(socket, isNot(contains(r'Nhận: $message')));
    expect(socket, isNot(contains(r'Gửi: $message')));
    expect(map, isNot(contains('origin=\$origin')));
    expect(map, isNot(contains('destination=\$destination')));
    expect(order, isNot(contains('with reason: \$reason')));
  });
}
