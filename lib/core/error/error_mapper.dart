import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'dio_exception_handler.dart';
import 'exceptions.dart';
import 'failures.dart';

Failure mapExceptionToFailure(Object e) {
  if (e is DioException) {
    if (e.error is AppException) {
      return mapExceptionToFailure(e.error!);
    }
    return DioExceptionHandler.handleException(e);
  }

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
    return const Failure.validation('Dữ liệu phản hồi không hợp lệ');
  }

  if (e is TypeError) {
    return const Failure.server('Dữ liệu phản hồi không hợp lệ');
  }

  // If it's already a failure, just return it
  if (e is Failure) {
    return e;
  }

  // Default fallback
  return const Failure.unexpected('Đã xảy ra lỗi. Vui lòng thử lại.');
}

extension AsyncValueUI on AsyncValue {
  /// Hiển thị thông báo lỗi nếu AsyncValue có lỗi
  void showSnackBarOnError(void Function(String message) showSnackBar) {
    if (hasError && !isLoading) {
      final error = this.error;
      if (error is Failure) {
        showSnackBar(error.message);
      } else {
        showSnackBar('Đã xảy ra lỗi. Vui lòng thử lại.');
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
      return 'Đã xảy ra lỗi. Vui lòng thử lại.';
    }
    return null;
  }
}
