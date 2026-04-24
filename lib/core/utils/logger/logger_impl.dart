import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as logger_pkg;
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
          level: kReleaseMode ? logger_pkg.Level.error : logger_pkg.Level.debug,
        );

  @override
  void d(dynamic message) => _logger.d(message);

  @override
  void i(dynamic message) => _logger.i(message);

  @override
  void w(dynamic message) => _logger.w(message);

  @override
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
