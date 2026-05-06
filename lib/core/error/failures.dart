import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.server([@Default('Server Failure') String message]) = ServerFailure;
  const factory Failure.unauthorized([@Default('Unauthorized') String message]) = UnauthorizedFailure;
  const factory Failure.validation([@Default('Validation Error') String message]) = ValidationFailure;
  const factory Failure.network([@Default('Network Error') String message]) = NetworkFailure;
  const factory Failure.cache([@Default('Cache Error') String message]) = CacheFailure;
  const factory Failure.location([@Default('Location Error') String message]) = LocationFailure;
  const factory Failure.biometric([@Default('Biometric Authentication Error') String message]) = BiometricFailure;
  const factory Failure.notFound([@Default('Resource Not Found') String message]) = NotFoundFailure;
  const factory Failure.unexpected([@Default('Unexpected Error') String message]) = UnexpectedFailure;
}
