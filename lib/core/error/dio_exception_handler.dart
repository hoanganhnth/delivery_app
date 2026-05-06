import 'package:delivery_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';
import 'failures.dart';

class DioExceptionHandler {
  static Failure handleException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network('Connection timeout');

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final message = exception.response?.data?['message'];
        
        if (message is String) {
          if (statusCode == 401) return Failure.unauthorized(message);
          if (statusCode == 404) return Failure.notFound(message);
          return Failure.server(message);
        }

        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              return Failure.validation('Bad request ($statusCode)');
            case 401:
              return const Failure.unauthorized();
            case 403:
              return const Failure.unauthorized('Forbidden access');
            case 404:
              return const Failure.notFound();
            case 500:
              return const Failure.server('Internal server error');
            default:
              return Failure.server('Server error ($statusCode)');
          }
        }
        return const Failure.server();

      case DioExceptionType.cancel:
        return const Failure.network('Request cancelled');

      case DioExceptionType.connectionError:
        return const Failure.network('No internet connection');

      case DioExceptionType.badCertificate:
        return const Failure.network('Certificate error');

      case DioExceptionType.unknown:
        return const Failure.network('Unknown network error');
    }
  }

  static AppException mapDioExceptionToException(DioException e) {
    final failure = handleException(e);
    return failure.when(
      server: (msg) => AppException.server(msg),
      unauthorized: (msg) => AppException.unauthorized(msg),
      validation: (msg) => AppException.validation(msg),
      network: (msg) => AppException.network(msg),
      cache: (msg) => AppException.cache(msg),
      location: (msg) => AppException.server(msg), // Fallback
      biometric: (msg) => AppException.server(msg), // Fallback
      notFound: (msg) => AppException.server(msg), // Fallback
      unexpected: (msg) => AppException.server(msg),
    );
  }
}
