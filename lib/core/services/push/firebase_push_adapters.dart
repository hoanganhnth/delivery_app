import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/network/dio/interceptors/auth_interceptor.dart';
import 'package:delivery_app/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'push_notification_contracts.dart';
import 'push_persistence_adapter.dart';

class FirebasePushNativeAdapter implements PushNativePort {
  FirebasePushNativeAdapter([FirebaseMessaging? messaging])
    : _messaging = messaging ?? FirebaseMessaging.instance;

  final FirebaseMessaging _messaging;

  @override
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  @override
  Future<String?> getToken() async {
    final token = (await _messaging.getToken())?.trim();
    return token == null || token.isEmpty ? null : token;
  }

  @override
  Future<void> deleteToken() => _messaging.deleteToken();

  @override
  Future<PushMessageEnvelope?> getInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    return message == null ? null : remoteMessageEnvelope(message);
  }

  @override
  Stream<String> get tokenRefreshes => _messaging.onTokenRefresh;

  @override
  Stream<PushMessageEnvelope> get foregroundMessages =>
      FirebaseMessaging.onMessage.map(remoteMessageEnvelope);

  @override
  Stream<PushMessageEnvelope> get openedMessages =>
      FirebaseMessaging.onMessageOpenedApp.map(remoteMessageEnvelope);
}

PushMessageEnvelope remoteMessageEnvelope(RemoteMessage message) {
  return PushMessageEnvelope(
    data: Map<String, Object?>.from(message.data),
    title: message.notification?.title,
    body: message.notification?.body,
  );
}

class DioPushTokenBackendAdapter implements PushTokenBackendPort {
  DioPushTokenBackendAdapter(this._dio);

  final Dio _dio;

  @override
  Future<void> registerToken(String token) async {
    await _dio.post(ApiConstants.firebaseRegisterToken, data: {'token': token});
  }

  @override
  Future<void> unregisterToken(String token) async {
    await _dio.post(
      ApiConstants.firebaseUnregisterToken,
      data: {'token': token},
      options: Options(extra: {AuthInterceptor.skipAuthRefreshKey: true}),
    );
  }
}

class FlutterLocalPushPresentationAdapter implements PushPresentationPort {
  FlutterLocalPushPresentationAdapter([
    FlutterLocalNotificationsPlugin? notifications,
  ]) : _notifications = notifications ?? FlutterLocalNotificationsPlugin();

  static const _channel = AndroidNotificationChannel(
    'delivery_high_importance',
    'Delivery Notifications',
    description: 'Thông báo đơn hàng và giao hàng',
    importance: Importance.high,
    showBadge: true,
    playSound: true,
  );

  final FlutterLocalNotificationsPlugin _notifications;
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      ),
    );
    await _notifications.initialize(settings);
    if (Platform.isAndroid) {
      await _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_channel);
    }
  }

  @override
  Future<void> showForeground(
    PushWakeSignal signal, {
    String? title,
    String? body,
  }) async {
    if (title == null && body == null) return;
    await _notifications.show(
      signal.notificationId,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'delivery_high_importance',
          'Delivery Notifications',
          channelDescription: 'Thông báo đơn hàng và giao hàng',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode({
        'notificationId': signal.notificationId,
        'type': signal.type,
      }),
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  final preferences = await SharedPreferences.getInstance();
  await recordBackgroundPushWake(
    remoteMessageEnvelope(message),
    SharedPreferencesPushPersistence(preferences),
  );
}
