import 'package:delivery_app/core/error/dio_exception_handler.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('response transformation timeout is an explicit failure', () {
    final failure = DioExceptionHandler.handleException(DioException(
      requestOptions: RequestOptions(path: '/restaurants'),
      type: DioExceptionType.transformTimeout,
    ));
    expect(failure, const Failure.network('Response processing timeout'));
  });
}
