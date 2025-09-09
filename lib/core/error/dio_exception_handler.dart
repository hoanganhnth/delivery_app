import 'package:dio/dio.dart';
import 'failures.dart';

class DioExceptionHandler {
  static Failure handleException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final message = exception.response?.data?['message'];
        if (message is String) {
          return ServerFailure(message);
        }
        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              return ServerFailure('Bad request: $message');
            case 401:
              return const ServerFailure('Unauthorized');
            case 403:
              return const ServerFailure('Forbidden');
            case 404:
              return const ServerFailure('Not found');
            case 500:
              return const ServerFailure('Internal server error');
            default:
              return ServerFailure('Server error ($statusCode): $message');
          }
        }
        return ServerFailure('Server error: $message');

      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');

      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');

      case DioExceptionType.badCertificate:
        return const NetworkFailure('Certificate error');

      case DioExceptionType.unknown:
        return const NetworkFailure('Unknown network error');
    }
  }
}
