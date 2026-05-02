import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification_service.g.dart';

/// ✅ Background message handler — must be top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
      '📩 [FCM Background] ${message.notification?.title}: ${message.notification?.body}');
}

/// ✅ Push Notification Service — manages FCM token lifecycle and message handling
class PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final Dio _dio;

  /// Android notification channel for high-importance notifications
  static const AndroidNotificationChannel _channel =
      AndroidNotificationChannel(
    'delivery_high_importance',
    'Delivery Notifications',
    description: 'Thông báo đơn hàng và giao hàng',
    importance: Importance.high,
    showBadge: true,
    playSound: true,
  );

  PushNotificationService(this._dio);

  /// Initialize FCM: request permissions, get token, setup listeners
  Future<void> initialize() async {
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

      debugPrint(
          '📱 [FCM] Permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        debugPrint('⚠️ [FCM] User denied notification permission');
        return;
      }

      // 2. Setup local notification channel (Android)
      await _setupLocalNotifications();

      // 3. Get FCM token and register with backend
      final token = await _messaging.getToken();
      if (token != null) {
        debugPrint(
            '📱 [FCM] Token obtained: ${token.substring(0, 20)}...');
        await _registerTokenWithBackend(token);
      }

      // 4. Listen for token refresh
      _messaging.onTokenRefresh.listen((newToken) {
        debugPrint('🔄 [FCM] Token refreshed');
        _registerTokenWithBackend(newToken);
      });

      // 5. Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // 6. Handle message tap (app opened from notification)
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

      // 7. Check for initial message (app opened from terminated state)
      final initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageOpenedApp(initialMessage);
      }

      // 8. Register background handler
      FirebaseMessaging.onBackgroundMessage(
          firebaseMessagingBackgroundHandler);

      debugPrint('✅ [FCM] Push notification service initialized');
    } catch (e) {
      debugPrint('💥 [FCM] Error initializing push notifications: $e');
    }
  }

  /// Setup local notification plugin for showing foreground notifications
  Future<void> _setupLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

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
        debugPrint(
            '📲 [LocalNotification] Tapped: ${response.payload}');
      },
    );

    // Create Android notification channel
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
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
      debugPrint('✅ [FCM] Token registered with backend');
    } catch (e) {
      debugPrint('⚠️ [FCM] Failed to register token with backend: $e');
    }
  }

  /// Unregister FCM token from backend (call on logout)
  Future<void> unregisterToken() async {
    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _dio.post(
          ApiConstants.firebaseUnregisterToken,
          data: {'token': token},
        );
        debugPrint('✅ [FCM] Token unregistered from backend');
      }
    } catch (e) {
      debugPrint('⚠️ [FCM] Failed to unregister token: $e');
    }
  }

  /// Handle foreground messages — show local notification
  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint(
        '📩 [FCM Foreground] ${message.notification?.title}: ${message.notification?.body}');

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
    debugPrint('📲 [FCM Opened] Data: ${message.data}');
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
