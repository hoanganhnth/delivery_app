import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:delivery_app/generated/l10n.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Thêm cấu hình đa ngôn ngữ
      localizationsDelegates: const [
        S.delegate, // Delegate sinh ra từ intl_utils
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      home: Scaffold(
        appBar: AppBar(title: const Text("Demo I18n")),
        body: Center(
          child: Text(S.of(context).test2), // Gọi từ intl_en.arb / intl_vi.arb
        ),
      ),
    );
  }
}
