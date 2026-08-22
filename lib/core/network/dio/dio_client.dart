import 'dart:async';

import 'package:delivery_app/core/config/api_endpoint_controller.dart';
import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'token_storage.dart';

class DioClient {
  final TokenStorage? tokenStorage;
  final FutureOr<void> Function()? onUnauthorized;
  final ApiEndpointController? endpointController;

  late final Dio dio;

  DioClient({
    this.tokenStorage,
    this.onUnauthorized,
    this.endpointController,
    String? baseUrl,
  }) {
    final baseOptions = BaseOptions(
      baseUrl: baseUrl ?? endpointController?.apiBaseUrl ?? ApiConstants.api,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 30),
      contentType: "application/json",
    );

    dio = Dio(baseOptions);

    dio.interceptors.addAll([
      AuthInterceptor(
        dio: dio,
        tokenStorage: tokenStorage,
        onUnauthorized: onUnauthorized,
      ),
      LoggingInterceptor(),
    ]);

    endpointController?.addListener(_syncBaseUrl);
  }

  void _syncBaseUrl() {
    final controller = endpointController;
    if (controller != null) {
      dio.options.baseUrl = controller.apiBaseUrl;
    }
  }

  void dispose() {
    endpointController?.removeListener(_syncBaseUrl);
    dio.close(force: true);
  }
}
