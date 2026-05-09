import 'dart:io';

import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'token_storage.dart';

class DioClient {
  final TokenStorage? tokenStorage;
  final void Function()? onUnauthorized;

  late final Dio dio;

  DioClient({this.tokenStorage, this.onUnauthorized}) {
    final baseOptions = BaseOptions(
      baseUrl: Platform.isAndroid ? ApiConstants.api : ApiConstants.apiIos,
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
  }
}
