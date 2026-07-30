import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

const testPhoneSize = Size(390, 812);

void useTestPhoneViewport(WidgetTester tester, {Size size = testPhoneSize}) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}

Future<void> pumpTestApp(
  WidgetTester tester, {
  required Widget child,
  List<Override> overrides = const [],
  Size viewport = testPhoneSize,
  ThemeData? theme,
}) async {
  useTestPhoneViewport(tester, size: viewport);
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: ScreenUtilInit(
        designSize: testPhoneSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, _) => MaterialApp(
          theme: theme,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: Scaffold(body: child),
        ),
      ),
    ),
  );
}

Future<void> pumpTestRouter(
  WidgetTester tester, {
  required GoRouter router,
  List<Override> overrides = const [],
  Size viewport = testPhoneSize,
  ThemeData? theme,
}) async {
  useTestPhoneViewport(tester, size: viewport);
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: ScreenUtilInit(
        designSize: testPhoneSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, _) => MaterialApp.router(
          routerConfig: router,
          theme: theme,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    ),
  );
}
