import 'i_logger.dart';
import 'logger_impl.dart';

/// Singleton logger for the application.
/// Provides static access to logging methods.
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  static AppLogger get instance => _instance;

  final ILogger _logger;

  AppLogger._internal() : _logger = LoggerImpl();

  // Instance methods (can be useful for injection if needed)
  void logDebug(dynamic message) => _logger.d(message);
  void logInfo(dynamic message) => _logger.i(message);
  void logWarn(dynamic message) => _logger.w(message);
  void logError(dynamic message, [dynamic error, StackTrace? st]) => _logger.e(message, error, st);

  // Static methods for direct access
  static void d(dynamic message) => _instance._logger.d(message);
  static void i(dynamic message) => _instance._logger.i(message);
  static void w(dynamic message) => _instance._logger.w(message);
  static void e(dynamic message, [dynamic error, StackTrace? st]) => 
      _instance._logger.e(message, error, st);

  static void debug(dynamic message) => _instance._logger.d(message);
  static void info(dynamic message) => _instance._logger.i(message);
  static void warn(dynamic message) => _instance._logger.w(message);
  static void error(dynamic message, [dynamic error, StackTrace? st]) => 
      _instance._logger.e(message, error, st);
}
