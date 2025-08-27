import 'exceptions.dart';
import 'failures.dart';

Failure mapExceptionToFailure(Exception e) {
  if (e is UnauthorizedException) return UnauthorizedFailure(e.message);
  if (e is ServerException) return ServerFailure(e.message);
  return ServerFailure("Unexpected error");
}
