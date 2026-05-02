import 'dart:async';

import 'package:delivery_app/core/app_setup.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/theme/theme.dart';
import 'package:delivery_app/core/storage/adapter/hive_registry.dart';
import 'package:delivery_app/firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:delivery_app/core/services/push_notification_service.dart';
import 'features/auth/presentation/providers/di/storage_di_providers.dart';
import 'features/auth/presentation/providers/di/auth_network_providers.dart' as auth_net;
import 'package:delivery_app/core/network/_riverpod/authenticated_network_providers.dart' as core_net;

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // ✅ Load environment variables
      await dotenv.load();

      // ✅ Khởi tạo Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // ✅ Cấu hình timeago locale cho tiếng Việt
      timeago.setLocaleMessages('vi', timeago.ViMessages());
      timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());

      // ✅ Khởi tạo SharedPreferences
      final sharedPreferences = await SharedPreferences.getInstance();
      
      // ✅ Khởi tạo Hive và đăng ký adapters
      await AppSetup.initializeHive();
      
      // ✅ Đăng ký Hive adapters thêm
      HiveAdapterRegistry.registerAllAdapters();
      
      // ✅ Khởi tạo Mapbox
      AppSetup.initializeMapbox();

      // ✅ Đăng ký FCM background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      
      // Bắt lỗi Flutter framework
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      runApp(
        AppSetup.setupApp(
          child: const MainApp(),
          additionalOverrides: [
            sharedPreferencesProvider.overrideWithValue(sharedPreferences),
            // 🔑 Conditional override: Chỉ override khi user đã login
            core_net.authenticatedDioProvider.overrideWith((ref) {
              return ref.watch(auth_net.authAwareDioProvider);
              // final authState = ref.watch(authProvider);
              
              // // ✅ Nếu đã login, dùng authAwareDio (có token)
              // if (authState.isAuthenticated && authState.accessToken != null) {
              //   return ref.watch(auth_net.authAwareDioProvider);
              // }
              
              // // ❌ Chưa login, dùng Dio mặc định (không token)
              // return ref.watch(dioProvider);
            }),
          ],
        ),
      );
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  bool _fcmInitialized = false;

  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  Future<void> _initFCM() async {
    if (_fcmInitialized) return;
    _fcmInitialized = true;
    // Delay to allow providers to be ready
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    try {
      final pushService = ref.read(pushNotificationServiceProvider);
      await pushService.initialize();
    } catch (e) {
      debugPrint('⚠️ FCM init error (will retry on auth): $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);

    return ScreenUtilInit(
      // Thiết kế kích thước chuẩn iPhone X/11/12/13 mini
      designSize: const Size(390, 812),
      // Đảm bảo text scale theo kích thước màn hình
      minTextAdapt: true,
      // Split screen support cho tablet
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Delivery App',

          // Router configuration
          routerConfig: router,

          // Theme configuration
          theme: theme.themeData,

          // Localization configuration
          localizationsDelegates: const [
            S.delegate, // Delegate sinh ra từ intl_utils
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,

          // Debug banner
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
