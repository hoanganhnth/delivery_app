/// Interface for logging service
abstract class ILogger {
  /// Log debug message
  void d(dynamic message);

  /// Log info message
  void i(dynamic message);

  /// Log warning message
  void w(dynamic message);

  /// Log error message
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]);
}
