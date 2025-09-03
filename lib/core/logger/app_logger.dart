import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,       // số dòng stacktrace khi log
      errorMethodCount: 5,  // stacktrace khi error
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
    level: kReleaseMode ? Level.error : Level.debug, 
  );

  static void d(dynamic message) => _logger.d(message);
  static void i(dynamic message) => _logger.i(message);
  static void w(dynamic message) => _logger.w(message);
  static void e(dynamic message, [dynamic error, StackTrace? st]) =>
      _logger.e(message, error: error, stackTrace: st);
}
