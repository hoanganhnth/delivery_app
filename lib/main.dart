import 'package:delivery_app/core/app_setup.dart';
import 'package:delivery_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/generated/l10n.dart';

void main() {
  runApp(AppSetup.setupApp(child: const MainApp()));
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),

      // Debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
