import 'package:delivery_app/core/error/dio_exception_handler.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('preserves typed 409 checkout conflict and details', () {
    final request = RequestOptions(path: '/orders');
    final failure = DioExceptionHandler.handleException(
      DioException(
        requestOptions: request,
        type: DioExceptionType.badResponse,
        response: Response<Map<String, dynamic>>(
          requestOptions: request,
          statusCode: 409,
          data: {
            'status': 0,
            'message': 'Giá đơn hàng đã thay đổi',
            'error': {
              'code': 'PRICE_CHANGED',
              'details': {
                'quote': {'quoteId': '00000000-0000-0000-0000-000000000001'},
              },
            },
          },
        ),
      ),
    );

    expect(failure, isA<ConflictFailure>());
    final conflict = failure as ConflictFailure;
    expect(conflict.code, 'PRICE_CHANGED');
    expect(conflict.message, 'Giá đơn hàng đã thay đổi');
    expect(conflict.details?['quote'], isA<Map<String, dynamic>>());
  });
}
