import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:delivery_app/core/network/dio/interceptors/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification_service.g.dart';

/// ✅ Background message handler — must be top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('[FCM] Background notification received');
}

/// ✅ Push Notification Service — manages FCM token lifecycle and message handling
abstract interface class PushNotificationPort {
  Future<void> initialize({required bool authenticated});
  Future<void> updateAuthentication(bool authenticated);
  Future<void> unregisterToken();
}

class PushNotificationService implements PushNotificationPort {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final Dio _dio;
  bool _authenticated = false;
  Future<void>? _initialization;
  Future<void>? _tokenSync;

  /// Android notification channel for high-importance notifications
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'delivery_high_importance',
    'Delivery Notifications',
    description: 'Thông báo đơn hàng và giao hàng',
    importance: Importance.high,
    showBadge: true,
    playSound: true,
  );

  PushNotificationService(this._dio);

  /// Initialize FCM: request permissions, get token, setup listeners
  @override
  Future<void> initialize({required bool authenticated}) async {
    _authenticated = authenticated;
    _initialization ??= _initializeOnce();
    await _initialization;
    if (_authenticated) {
      await syncTokenWithBackend();
    }
  }

  Future<void> _initializeOnce() async {
    try {
      // 1. Request permission (iOS + Android 13+)
      final settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('[FCM] Permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        debugPrint('[FCM] Notification permission denied');
        return;
      }

      // 2. Setup local notification channel (Android)
      await _setupLocalNotifications();

      // 3. Listen for token refresh. Backend sync is allowed only while the
      // app has an authenticated session.
      _messaging.onTokenRefresh.listen((newToken) {
        if (_authenticated) {
          _registerTokenWithBackend(newToken);
        }
      });

      // 4. Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // 5. Handle message tap (app opened from notification)
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // 6. Check for initial message (app opened from terminated state)
      final initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage);
      }

      // 7. Register background handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      debugPrint('[FCM] Push notification service initialized');
    } catch (_) {
      debugPrint('[FCM] Push notification initialization failed');
    }
  }

  @override
  Future<void> updateAuthentication(bool authenticated) async {
    _authenticated = authenticated;
    if (authenticated) {
      await syncTokenWithBackend();
    }
  }

  Future<void> syncTokenWithBackend() {
    if (!_authenticated) return Future<void>.value();
    return _tokenSync ??= _syncToken().whenComplete(() => _tokenSync = null);
  }

  Future<void> _syncToken() async {
    final token = await _messaging.getToken();
    if (token != null && _authenticated) {
      await _registerTokenWithBackend(token);
    }
  }

  /// Setup local notification plugin for showing foreground notifications
  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('[FCM] Local notification opened');
      },
    );

    // Create Android notification channel
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_channel);
    }
  }

  /// Register FCM token with the backend
  Future<void> _registerTokenWithBackend(String token) async {
    try {
      await _dio.post(
        ApiConstants.firebaseRegisterToken,
        data: {'token': token},
      );
      debugPrint('[FCM] Token registered with backend');
    } catch (_) {
      debugPrint('[FCM] Token registration failed');
    }
  }

  /// Unregister FCM token from backend (call on logout)
  @override
  Future<void> unregisterToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _dio.post(
          ApiConstants.firebaseUnregisterToken,
          data: {'token': token},
          options: Options(extra: {AuthInterceptor.skipAuthRefreshKey: true}),
        );
        debugPrint('[FCM] Token unregistered from backend');
      }
    } catch (_) {
      debugPrint('[FCM] Token unregistration failed');
    }
  }

  /// Handle foreground messages — show local notification
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('[FCM] Foreground notification received');

    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  /// Handle notification tap when app is in background/terminated
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('[FCM] Notification opened');
    // Navigation sẽ xử lý dựa trên message.data['relatedEntityType']
    // và message.data['relatedEntityId']
  }
}

/// ✅ Riverpod provider for PushNotificationService
@Riverpod(keepAlive: true)
PushNotificationService pushNotificationService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return PushNotificationService(dio);
}

/// Stable application-facing port. Tests override this provider without
/// constructing FirebaseMessaging or FlutterLocalNotificationsPlugin.
final pushNotificationPortProvider = Provider<PushNotificationPort>((ref) {
  return ref.watch(pushNotificationServiceProvider);
});
