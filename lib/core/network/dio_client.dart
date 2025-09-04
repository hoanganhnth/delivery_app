import 'dart:io';

import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'interceptors/request_interceptor.dart';
import 'interceptors/response_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class DioClient {
  final Future<String?> Function()? getToken;
  final Future<String?> Function()? onRefreshToken;

  late final Dio dio;

  DioClient({this.getToken, this.onRefreshToken}) {
    dio = Dio(
      BaseOptions(
        baseUrl: Platform.isAndroid ? ApiConstants.api : ApiConstants.apiIos,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: "application/json",
      ),
    );

    dio.interceptors.addAll([
      RequestInterceptor(getToken: getToken),
      ResponseInterceptor(),
      ErrorInterceptor(onRefreshToken: onRefreshToken),
    ]);
  }
}
