import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../tool/api_contract_check.dart';

Map<String, dynamic> _manifest(String name) =>
    jsonDecode(File('contracts/backend/$name.json').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  test('every app HTTP route exists and is exposed by the Gateway', () {
    final calls = discoverAppHttpCalls(Directory('lib'));
    expect(calls, isNotEmpty);
    expect(
      checkAppHttpCalls(
        calls,
        _manifest('http-contract'),
        _manifest('public-edge-manifest'),
      ),
      isEmpty,
    );
  });

  test(
    'detects missing controllers, wrong verbs and missing public exposure',
    () {
      final contract = _manifest('http-contract');
      final edge = _manifest('public-edge-manifest');
      expect(
        checkAppHttpCalls(
          [
            const AppHttpCall('GET', '/api/nonexistent', 'fixture.dart', 1),
            const AppHttpCall('DELETE', '/api/auth/login', 'fixture.dart', 2),
            const AppHttpCall(
              'GET',
              '/api/users/by-auth/{id}',
              'fixture.dart',
              3,
            ),
          ],
          contract,
          edge,
        ),
        [
          contains('MISSING_IN_BACKEND'),
          contains('MISSING_IN_BACKEND'),
          contains('NOT_PUBLIC'),
        ],
      );
      expect(
        normalizedRoute('/api/restaurants/{id:[0-9]+}'),
        '/api/restaurants/{}',
      );
      expect(
        normalizedRoute('/api/livestreams/{id:[0-9a-fA-F-]{36}}/join'),
        '/api/livestreams/{}/join',
      );
    },
  );

  test(
    'discovers constants, dynamic helpers and Retrofit without a route list',
    () {
      final root = Directory.systemTemp.createTempSync('app-contract-');
      addTearDown(() => root.deleteSync(recursive: true));
      Directory('${root.path}/core/constants').createSync(recursive: true);
      File('${root.path}/core/constants/api_constants.dart').writeAsStringSync(
        r'''
class ApiConstants {
  static const base = '/things';
  static const list = '$base/all';
  static String detail(int id) => '$base/$id';
}
''',
      );
      File('${root.path}/client.dart').writeAsStringSync(r'''
class Client {
  // @DELETE('/commented-route') must never count.
  @GET(ApiConstants.list)
  Future<void> list();
  Future<void> direct(int id) => _dio.post('/things/$id');
  Future<void> detail(int id) => _load(ApiConstants.detail(id));
  Future<void> _load(String path) => _dio.get(path);
}
''');
      final calls = discoverAppHttpCalls(root);
      expect(calls.map((c) => '${c.method} ${c.path}'), [
        'GET /api/things/all',
        'POST /api/things/{}',
        'GET /api/things/{}',
      ]);
      File(
        '${root.path}/unknown.dart',
      ).writeAsStringSync('void send() { _dio.get(unknownPath()); }');
      expect(() => discoverAppHttpCalls(root), throwsStateError);
    },
  );
}
