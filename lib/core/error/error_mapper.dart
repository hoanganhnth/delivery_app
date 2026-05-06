import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'exceptions.dart';
import 'failures.dart';

Failure mapExceptionToFailure(Object e) {
  if (e is UnauthorizedException) {
    return Failure.unauthorized(e.message);
  }
  if (e is ServerException) {
    return Failure.server(e.message);
  }
  if (e is NetworkException) {
    return Failure.network(e.message);
  }
  if (e is ValidationException) {
    return Failure.validation(e.message);
  }

  // Handle other common exception types
  if (e is FormatException) {
    return Failure.validation('Invalid data format: ${e.message}');
  }

  if (e is TypeError) {
    return Failure.server('Data type error: ${e.toString()}');
  }

  // If it's already a failure, just return it
  if (e is Failure) {
    return e;
  }

  // Default fallback
  return Failure.unexpected('Unexpected error: ${e.toString()}');
}

extension AsyncValueUI on AsyncValue {
  /// Hiển thị thông báo lỗi nếu AsyncValue có lỗi
  void showSnackBarOnError(
    void Function(String message) showSnackBar,
  ) {
    if (hasError && !isLoading) {
      final error = this.error;
      if (error is Failure) {
        showSnackBar(error.message);
      } else {
        showSnackBar(error.toString());
      }
    }
  }

  /// Lấy thông báo lỗi thân thiện
  String? get errorMessage {
    if (hasError) {
      final error = this.error;
      if (error is Failure) {
        return error.message;
      }
      return error.toString();
    }
    return null;
  }
}
