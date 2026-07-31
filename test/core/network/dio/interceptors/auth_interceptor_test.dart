import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:delivery_app/core/constants/api_constants.dart';
import 'package:delivery_app/core/network/dio/interceptors/auth_interceptor.dart';
import 'package:delivery_app/core/network/dio/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthInterceptor', () {
    test(
      '401 without refresh token terminates concurrent requests once',
      () async {
        final clearGate = Completer<void>();
        final storage = _FakeTokenStorage(
          accessToken: 'expired-access',
          onClear: () => clearGate.future,
        );
        var unauthorizedCalls = 0;
        final adapter = _ScriptedAdapter((_) => _jsonResponse(401));
        final dio = _createDio(adapter: adapter);
        dio.interceptors.add(
          AuthInterceptor(
            dio: dio,
            tokenStorage: storage,
            onUnauthorized: () async => unauthorizedCalls++,
          ),
        );

        final first = dio.get<dynamic>('/orders');
        await storage.clearStarted.future;
        final second = dio.get<dynamic>('/orders');
        await adapter.secondCallStarted.future;
        clearGate.complete();

        await expectLater(first, throwsA(isA<DioException>()));
        await expectLater(second, throwsA(isA<DioException>()));
        expect(storage.clearCalls, 1);
        expect(unauthorizedCalls, 1);
        expect(adapter.callsFor('/orders'), 2);
      },
    );

    test('401 without an attached bearer token is passed through', () async {
      final storage = _FakeTokenStorage();
      var unauthorizedCalls = 0;
      final adapter = _ScriptedAdapter((_) => _jsonResponse(401));
      final dio = _createDio(adapter: adapter);
      dio.interceptors.add(
        AuthInterceptor(
          dio: dio,
          tokenStorage: storage,
          onUnauthorized: () => unauthorizedCalls++,
        ),
      );

      await expectLater(
        dio.get<dynamic>('/public-resource'),
        throwsA(isA<DioException>()),
      );
      expect(storage.clearCalls, 0);
      expect(unauthorizedCalls, 0);
    });

    for (final authPath in <String>[
      ApiConstants.login,
      ApiConstants.register,
      ApiConstants.socialLogin,
      ApiConstants.refreshToken,
      ApiConstants.logout,
    ]) {
      test('401 from $authPath never starts refresh or logout', () async {
        final storage = _FakeTokenStorage(
          accessToken: 'stale-access',
          refreshToken: 'valid-refresh',
        );
        var unauthorizedCalls = 0;
        final adapter = _ScriptedAdapter((_) => _jsonResponse(401));
        final refreshAdapter = _ScriptedAdapter((_) => _jsonResponse(500));
        final dio = _createDio(adapter: adapter);
        final refreshDio = _createDio(adapter: refreshAdapter);
        dio.interceptors.add(
          AuthInterceptor(
            dio: dio,
            refreshDio: refreshDio,
            tokenStorage: storage,
            onUnauthorized: () => unauthorizedCalls++,
          ),
        );

        await expectLater(
          dio.post<dynamic>(authPath),
          throwsA(isA<DioException>()),
        );
        expect(refreshAdapter.totalCalls, 0);
        expect(storage.clearCalls, 0);
        expect(unauthorizedCalls, 0);
      });
    }

    test(
      'request opt-out prevents FCM cleanup from entering auth flow',
      () async {
        final storage = _FakeTokenStorage(
          accessToken: 'expired-access',
          refreshToken: 'valid-refresh',
        );
        var unauthorizedCalls = 0;
        final adapter = _ScriptedAdapter((_) => _jsonResponse(401));
        final dio = _createDio(adapter: adapter);
        dio.interceptors.add(
          AuthInterceptor(
            dio: dio,
            tokenStorage: storage,
            onUnauthorized: () => unauthorizedCalls++,
          ),
        );

        await expectLater(
          dio.post<dynamic>(
            ApiConstants.firebaseUnregisterToken,
            options: Options(extra: {AuthInterceptor.skipAuthRefreshKey: true}),
          ),
          throwsA(isA<DioException>()),
        );
        expect(storage.clearCalls, 0);
        expect(unauthorizedCalls, 0);
      },
    );

    test(
      'concurrent 401 responses share one refresh and persist the rotated pair',
      () async {
        final storage = _FakeTokenStorage(
          accessToken: 'expired-access',
          refreshToken: 'current-refresh',
        );
        final refreshGate = Completer<ResponseBody>();
        final adapter = _ScriptedAdapter((options) {
          final authorization = options.headers['Authorization'];
          return authorization == 'Bearer expired-access'
              ? _jsonResponse(401)
              : _jsonResponse(200, body: {'data': options.path});
        });
        final refreshAdapter = _ScriptedAdapter((_) => refreshGate.future);
        final dio = _createDio(adapter: adapter);
        dio.interceptors.add(
          AuthInterceptor(
            dio: dio,
            refreshDio: _createDio(adapter: refreshAdapter),
            tokenStorage: storage,
          ),
        );

        final orders = dio.get<dynamic>('/orders');
        await refreshAdapter.firstCallStarted.future;
        final profile = dio.get<dynamic>('/profile');
        await adapter.secondCallStarted.future;
        refreshGate.complete(
          _jsonResponse(
            200,
            body: {
              'data': {
                'accessToken': 'rotated-access',
                'refreshToken': 'rotated-refresh',
              },
            },
          ),
        );

        await Future.wait([orders, profile]);
        expect(refreshAdapter.callsFor(ApiConstants.refreshToken), 1);
        expect(adapter.callsFor('/orders'), 2);
        expect(adapter.callsFor('/profile'), 2);
        expect(storage.accessToken, 'rotated-access');
        expect(storage.refreshToken, 'rotated-refresh');
        expect(storage.saveCalls, 1);
        expect(storage.clearCalls, 0);
      },
    );

    test(
      'a retried request that remains 401 terminates without deadlock',
      () async {
        final storage = _FakeTokenStorage(
          accessToken: 'expired-access',
          refreshToken: 'valid-refresh',
        );
        var unauthorizedCalls = 0;
        final adapter = _ScriptedAdapter((_) => _jsonResponse(401));
        final refreshAdapter = _ScriptedAdapter(
          (_) => _jsonResponse(
            200,
            body: {
              'data': {
                'accessToken': 'new-access',
                'refreshToken': 'new-refresh',
              },
            },
          ),
        );
        final dio = _createDio(adapter: adapter);
        dio.interceptors.add(
          AuthInterceptor(
            dio: dio,
            refreshDio: _createDio(adapter: refreshAdapter),
            tokenStorage: storage,
            onUnauthorized: () => unauthorizedCalls++,
          ),
        );

        await expectLater(
          dio.get<dynamic>('/orders').timeout(const Duration(seconds: 2)),
          throwsA(anything),
        );
        expect(adapter.callsFor('/orders'), 2);
        expect(refreshAdapter.callsFor(ApiConstants.refreshToken), 1);
        expect(storage.clearCalls, 1);
        expect(unauthorizedCalls, 1);
      },
    );
  });
}

Dio _createDio({required HttpClientAdapter adapter}) {
  return Dio(BaseOptions(baseUrl: 'http://gateway.test/api'))
    ..httpClientAdapter = adapter;
}

ResponseBody _jsonResponse(
  int statusCode, {
  Map<String, dynamic> body = const {'message': 'unauthorized'},
}) {
  return ResponseBody.fromString(
    jsonEncode(body),
    statusCode,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );
}

class _ScriptedAdapter implements HttpClientAdapter {
  final FutureOr<ResponseBody> Function(RequestOptions options) respond;
  final List<RequestOptions> calls = [];
  final Completer<void> firstCallStarted = Completer<void>();
  final Completer<void> secondCallStarted = Completer<void>();

  _ScriptedAdapter(this.respond);

  int get totalCalls => calls.length;

  int callsFor(String path) => calls.where((call) => call.path == path).length;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls.add(options);
    if (!firstCallStarted.isCompleted) firstCallStarted.complete();
    if (calls.length == 2 && !secondCallStarted.isCompleted) {
      secondCallStarted.complete();
    }
    return respond(options);
  }

  @override
  void close({bool force = false}) {}
}

class _FakeTokenStorage implements TokenStorage {
  String? accessToken;
  String? refreshToken;
  final Future<void> Function()? onClear;
  final Completer<void> clearStarted = Completer<void>();
  int clearCalls = 0;
  int saveCalls = 0;

  _FakeTokenStorage({this.accessToken, this.refreshToken, this.onClear});

  @override
  Future<void> clearTokens() async {
    clearCalls++;
    if (!clearStarted.isCompleted) clearStarted.complete();
    await onClear?.call();
    accessToken = null;
    refreshToken = null;
  }

  @override
  Future<String?> getAccessToken() async => accessToken;

  @override
  Future<String?> getRefreshToken() async => refreshToken;

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    saveCalls++;
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }
}
