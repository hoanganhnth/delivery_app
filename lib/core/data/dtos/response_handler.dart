import 'package:delivery_app/core/error/exceptions.dart';
import 'package:dio/dio.dart';
// import 'package:fpdart/fpdart.dart';
import '../../error/dio_exception_handler.dart';
// import 'base_response_dto.dart';

/// Class tiện ích để xử lý response chung cho tất cả API calls
class ResponseHandler {
  /// Xử lý response chung cho tất cả API calls
  // static Either<Exception, R> handleResponse<T, R>(
  //   BaseResponseDto<T> response,
  //   R Function(T) transform,
  // ) {
  //   if (response.isSuccess && response.data != null) {
  //     return right(transform(response.data as T));
  //   } else {
  //     return left(Exception(response.message));
  //   }
  // }

  /// Xử lý response đơn giản (trả về data trực tiếp)
  // static Either<Exception, T> handleSimpleResponse<T>(
  //   BaseResponseDto<T> response,
  // ) {
  //   return handleResponse(response, (data) => data);
  // }

  /// Xử lý response cho boolean (thường dùng cho delete, update operations)
  // static Either<Exception, bool> handleBooleanResponse(
  //   BaseResponseDto<bool> response, {
  //   bool defaultValue = true,
  // }) {
  //   if (response.isSuccess) {
  //     return right(response.data ?? defaultValue);
  //   } else {
  //     return left(Exception(response.message));
  //   }
  // }

  /// Map DioException thành Exception để phù hợp với interface
  

  /// Wrapper chung cho việc gọi API với error handling
  // static Future<Either<Exception, T>> safeApiCall<T>(
  //   Future<T> Function() apiCall,
  // ) async {
  //   try {
  //     final result = await apiCall();
  //     return right(result);
  //   } on DioException catch (e) {
  //     return left(mapDioExceptionToException(e));
  //   } catch (e) {
  //     return left(Exception('Unexpected error: ${e.toString()}'));
  //   }
  // }

  /// Wrapper cho API call với response handling
  // static Future<Either<Exception, R>> safeApiCallWithResponse<T, R>(
  //   Future<BaseResponseDto<T>> Function() apiCall,
  //   R Function(T) transform,
  // ) async {
  //   try {
  //     final response = await apiCall();
  //     return handleResponse(response, transform);
  //   } on DioException catch (e) {
  //     return left(mapDioExceptionToException(e));
  //   } catch (e) {
  //     return left(Exception('Unexpected error: ${e.toString()}'));
  //   }
  // }

  // /// Wrapper đơn giản cho API call với response handling
  // static Future<Either<Exception, T>> safeApiCallSimple<T>(
  //   Future<BaseResponseDto<T>> Function() apiCall,
  // ) async {
  //   return safeApiCallWithResponse(apiCall, (data) => data);
  // }
}
