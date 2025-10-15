import 'package:delivery_app/core/network/dio/interceptors/error_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
void main() {
  group('ErrorInterceptor - Token Refresh Queue Mechanism', () {
    test('should only call refresh token once for multiple concurrent requests', () async {
      // Arrange
      int refreshCallCount = 0;
      int rejectCallCount = 0;

      final interceptor = ErrorInterceptor(
        onRefreshToken: () async {
          refreshCallCount++;
          // Simulate slow token refresh
          await Future.delayed(const Duration(milliseconds: 50));
          // Return null to skip retry (we only test queue mechanism)
          return null;
        },
        baseOptions: BaseOptions(baseUrl: 'https://api.test.com'),
      );

      // Act - Trigger 5 concurrent 401 errors
      for (int i = 0; i < 5; i++) {
        final err = DioException(
          requestOptions: RequestOptions(path: '/test$i'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/test$i'),
          ),
          type: DioExceptionType.badResponse,
        );

        final handler = _TestHandler(onReject: (_) => rejectCallCount++);
        // Don't await - simulate concurrent requests
        interceptor.onError(err, handler);
      }

      // Wait for token refresh to complete
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(refreshCallCount, 1, reason: 'Should only call refresh token once for concurrent requests');
      expect(rejectCallCount, 5, reason: 'All 5 requests should be rejected after null token');
    });

    test('should queue requests and process them after refresh completes', () async {
      // Arrange
      int refreshCallCount = 0;
      final List<String> executionOrder = [];

      final interceptor = ErrorInterceptor(
        onRefreshToken: () async {
          refreshCallCount++;
          executionOrder.add('refresh_start');
          await Future.delayed(const Duration(milliseconds: 50));
          executionOrder.add('refresh_complete');
          return 'new_token_abc';
        },
        baseOptions: BaseOptions(baseUrl: 'https://api.test.com'),
      );

      // Act - First request triggers refresh
      executionOrder.add('request1');
      final err1 = DioException(
        requestOptions: RequestOptions(path: '/test1'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/test1'),
        ),
        type: DioExceptionType.badResponse,
      );
      interceptor.onError(err1, _TestHandler());

      // Small delay to ensure first request starts refresh
      await Future.delayed(const Duration(milliseconds: 10));

      // Second request should be queued
      executionOrder.add('request2_queued');
      final err2 = DioException(
        requestOptions: RequestOptions(path: '/test2'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/test2'),
        ),
        type: DioExceptionType.badResponse,
      );
      interceptor.onError(err2, _TestHandler());

      // Wait for refresh to complete
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(refreshCallCount, 1, reason: 'Should only refresh once');
      expect(executionOrder[0], 'request1');
      expect(executionOrder[1], 'refresh_start');
      expect(executionOrder[2], 'request2_queued');
      expect(executionOrder.contains('refresh_complete'), true);
    });

    test('should handle refresh token failure and reject queued requests', () async {
      // Arrange
      int refreshCallCount = 0;
      int rejectCount = 0;
      final exception = Exception('Token refresh failed');

      final interceptor = ErrorInterceptor(
        onRefreshToken: () async {
          refreshCallCount++;
          await Future.delayed(const Duration(milliseconds: 30));
          throw exception;
        },
        baseOptions: BaseOptions(baseUrl: 'https://api.test.com'),
      );

      // Act - Trigger 3 concurrent 401 errors
      for (int i = 0; i < 3; i++) {
        final err = DioException(
          requestOptions: RequestOptions(path: '/test$i'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/test$i'),
          ),
          type: DioExceptionType.badResponse,
        );

        final handler = _TestHandler(onReject: (_) => rejectCount++);
        interceptor.onError(err, handler);
      }

      // Wait for refresh to fail
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(refreshCallCount, 1, reason: 'Should attempt refresh once even if it fails');
      expect(rejectCount, 3, reason: 'Should reject all 3 requests after refresh fails');
    });

    test('should reset state after refresh completes', () async {
      // Arrange
      int refreshCallCount = 0;

      final interceptor = ErrorInterceptor(
        onRefreshToken: () async {
          refreshCallCount++;
          await Future.delayed(const Duration(milliseconds: 30));
          return 'token_$refreshCallCount';
        },
        baseOptions: BaseOptions(baseUrl: 'https://api.test.com'),
      );

      // Act - First 401 error triggers refresh
      final err1 = DioException(
        requestOptions: RequestOptions(path: '/test1'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/test1'),
        ),
        type: DioExceptionType.badResponse,
      );
      interceptor.onError(err1, _TestHandler());

      // Wait for first refresh to complete
      await Future.delayed(const Duration(milliseconds: 60));

      // Act - Second 401 error should trigger new refresh (state was reset)
      final err2 = DioException(
        requestOptions: RequestOptions(path: '/test2'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/test2'),
        ),
        type: DioExceptionType.badResponse,
      );
      interceptor.onError(err2, _TestHandler());

      // Wait for second refresh to complete
      await Future.delayed(const Duration(milliseconds: 60));

      // Assert
      expect(refreshCallCount, 2, reason: 'Should refresh twice after state reset');
    });

    test('should handle null token from refresh', () async {
      // Arrange
      int refreshCallCount = 0;

      final interceptor = ErrorInterceptor(
        onRefreshToken: () async {
          refreshCallCount++;
          await Future.delayed(const Duration(milliseconds: 50));
          return null;
        },
        baseOptions: BaseOptions(baseUrl: 'https://api.test.com'),
      );

      // Act
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/test'),
        ),
        type: DioExceptionType.badResponse,
      );

      int rejectCount = 0;
      final handler = _TestHandler(onReject: (_) => rejectCount++);
      interceptor.onError(err, handler);

      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(refreshCallCount, 1);
      expect(rejectCount, 1, reason: 'Should reject when refresh returns null');
    });

    test('should not trigger refresh for non-401 errors', () async {
      // Arrange
      int refreshCallCount = 0;

      final interceptor = ErrorInterceptor(
        onRefreshToken: () async {
          refreshCallCount++;
          return 'should_not_be_called';
        },
        baseOptions: BaseOptions(baseUrl: 'https://api.test.com'),
      );

      // Act - 403 error
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          statusCode: 403,
          requestOptions: RequestOptions(path: '/test'),
        ),
        type: DioExceptionType.badResponse,
      );

      int rejectCount = 0;
      final handler = _TestHandler(onReject: (_) => rejectCount++);
      interceptor.onError(err, handler);

      await Future.delayed(const Duration(milliseconds: 50));
      // Assert
      expect(refreshCallCount, 0, reason: 'Should not refresh for non-401 errors');
      expect(rejectCount, 1, reason: 'Should reject non-401 errors immediately');
    });
  });
}

// Test helper class
class _TestHandler extends ErrorInterceptorHandler {
  final void Function(DioException)? onReject;

  _TestHandler({this.onReject});

  @override
  void reject(DioException error) {
    onReject?.call(error);
    // DON'T call super.reject() - it throws the error
    // We just want to count rejections
  }
}


