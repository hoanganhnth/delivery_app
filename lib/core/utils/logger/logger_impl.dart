import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as logger_pkg;
import '../../debug/debug_log_store.dart';
import 'i_logger.dart';

/// Implementation of ILogger using the logger package
class LoggerImpl implements ILogger {
  final logger_pkg.Logger _logger;

  LoggerImpl()
    : _logger = logger_pkg.Logger(
        printer: logger_pkg.PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 80,
          colors: true,
          printEmojis: true,
        ),
        level: logger_pkg.Level.debug,
      );

  @override
  void d(dynamic message) {
    DebugLogStore.instance.recordMessage(DebugLogLevel.debug, message);
    if (kDebugMode) _logger.d(message);
  }

  @override
  void i(dynamic message) {
    DebugLogStore.instance.recordMessage(DebugLogLevel.info, message);
    if (kDebugMode) _logger.i(message);
  }

  @override
  void w(dynamic message) {
    DebugLogStore.instance.recordMessage(DebugLogLevel.warning, message);
    if (kDebugMode) _logger.w(message);
  }

  @override
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    DebugLogStore.instance.recordMessage(DebugLogLevel.error, message);
    if (kDebugMode) {
      // Error objects from HTTP/socket libraries can retain request headers and
      // payloads. Log only the caller-owned metadata message.
      _logger.e(message);
    }
  }
}
