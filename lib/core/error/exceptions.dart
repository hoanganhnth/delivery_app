import 'package:freezed_annotation/freezed_annotation.dart';

part 'exceptions.freezed.dart';

@freezed
sealed class AppException with _$AppException implements Exception {
  const factory AppException.server([@Default('Server error') String message]) = ServerException;
  const factory AppException.unauthorized([@Default('Unauthorized') String message]) = UnauthorizedException;
  const factory AppException.cache([@Default('Cache error') String message]) = CacheException;
  const factory AppException.network([@Default('Network error') String message]) = NetworkException;
  const factory AppException.validation([@Default('Validation error') String message]) = ValidationException;
}
