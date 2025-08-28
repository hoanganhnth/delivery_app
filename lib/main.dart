import 'dart:async';

import 'package:delivery_app/core/app_setup.dart';
import 'package:delivery_app/core/routing/app_router.dart';
import 'package:delivery_app/firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // ✅ Khởi tạo Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Bắt lỗi Flutter framework
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      runApp(AppSetup.setupApp(child: const MainApp()));
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Delivery App',

      // Router configuration
      routerConfig: router,

      // Localization configuration
      localizationsDelegates: const [
        S.delegate, // Delegate sinh ra từ intl_utils
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      // Theme configuration
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      // Debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
