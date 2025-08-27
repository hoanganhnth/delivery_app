import 'exceptions.dart';
import 'failures.dart';

Failure mapExceptionToFailure(Exception e) {
  if (e is UnauthorizedException) {
    return UnauthorizedFailure(e.message);
  }
  if (e is ServerException) {
    return ServerFailure(e.message);
  }

  // Handle other common exception types
  if (e is FormatException) {
    return ValidationFailure('Invalid data format: ${e.message}');
  }

  if (e is TypeError) {
    return ServerFailure('Data type error: ${e.toString()}');
  }

  // Default fallback
  return ServerFailure('Unexpected error: ${e.toString()}');
}
