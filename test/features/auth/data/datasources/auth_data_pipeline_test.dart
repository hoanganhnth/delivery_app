import 'dart:convert';
import 'package:delivery_app/core/error/exceptions.dart';
import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:delivery_app/features/auth/data/dtos/login_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/social_login_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/register_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/refresh_token_response_dto.dart';
import 'package:delivery_app/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:delivery_app/features/auth/domain/usecases/social_login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../support/data_http_harness.dart';

const loginBody = {
  'email': 'c@test.dev',
  'password': 'Password1!',
  'deviceId': 'device',
  'deviceName': 'Phone',
  'deviceType': 'ANDROID',
  'ipAddress': '127.0.0.1',
};
const socialBody = {
  'provider': 'GOOGLE',
  'token': 'provider-token',
  'role': 'USER',
  'deviceId': 'device',
  'deviceName': 'Phone',
  'deviceType': 'ANDROID',
  'ipAddress': '127.0.0.1',
};
const authPayload = {
  'accessToken': 'access',
  'refreshToken': 'refresh',
  'user': {
    'id': 1,
    'email': 'c@test.dev',
    'name': 'Customer',
    'createdAt': '2026-10-01T10:00:00.000',
  },
};
const registration = {
  'authId': 10,
  'principalId': 10,
  'email': 'c@test.dev',
  'role': 'USER',
  'provisioningToken': 'handoff',
  'registrationHandle': 'handle',
  'expiresAt': '2026-10-01T10:00:00.000',
  'lifecycleStatus': 'PENDING_PROFILE',
};

void main() {
  final paths = [
    '/auth/login',
    '/auth/social-login',
    '/auth/register',
    '/auth/registrations/handle',
    '/users/registrations',
    '/auth/refresh-token',
    '/auth/logout',
    '/auth/forgot-password',
    '/auth/reset-password',
  ];
  final bodies = <Object?>[
    loginBody,
    socialBody,
    {'email': 'c@test.dev', 'password': 'Password1!', 'role': 'USER'},
    null,
    {'provisioningToken': 'handoff', 'fullName': 'Customer'},
    {'refreshToken': 'refresh'},
    {'refreshToken': 'refresh'},
    {'email': 'c@test.dev'},
    {
      'token': 'abcdefghijklmnopqrstuvwxyzABCDEFGH',
      'newPassword': 'Password2!',
    },
  ];
  final payloads = <Object?>[
    authPayload,
    authPayload,
    registration,
    {
      'principalId': 10,
      'status': 'PENDING_PROFILE',
      'nextAction': 'CREATE_PROFILE',
      'profileLinked': false,
      'expiresAt': '2026-10-01T10:00:00.000',
    },
    {
      'id': 1,
      'authId': 10,
      'email': 'c@test.dev',
      'role': 'USER',
      'fullName': 'Customer',
    },
    {'accessToken': 'access', 'refreshToken': 'refresh'},
    null,
    null,
    null,
  ];
  for (var operation = 0; operation < paths.length; operation++) {
    for (final scenario in ['success', '401', '500', 'timeout', 'malformed']) {
      test('${paths[operation]} $scenario through real Retrofit', () async {
        final http = DataHttpHarness();
        final source = AuthRemoteDataSourceImpl(AuthApiService(http.dio));
        http.timeout = scenario == 'timeout';
        http.reply(
          operation == 3 ? 'GET' : 'POST',
          paths[operation],
          scenario == 'malformed'
              ? {'status': 'bad', 'data': {}}
              : scenario == '401' || scenario == '500'
              ? {'message': 'Denied'}
              : dataEnvelope(payloads[operation]),
          code: int.tryParse(scenario) ?? (operation == 7 ? 202 : 200),
        );
        Future<Object?> call() async => switch (operation) {
          0 => await source.login(LoginRequestDto.fromJson(loginBody)),
          1 => await source.socialLogin(socialBody),
          2 => await source.register(
            RegisterRequestDto.fromJson(bodies[2] as Map<String, dynamic>),
          ),
          3 => await source.registrationStatus('handle'),
          4 => await source.registerUserProfile(
            UserRegistrationRequestDto.fromJson(
              bodies[4] as Map<String, dynamic>,
            ),
          ),
          5 => await source.refreshToken('refresh'),
          6 => await (() async {
            await source.logout('refresh');
            return null;
          })(),
          7 => await (() async {
            await source.requestPasswordReset('c@test.dev');
            return null;
          })(),
          _ => await (() async {
            await source.resetPassword(
              'abcdefghijklmnopqrstuvwxyzABCDEFGH',
              'Password2!',
            );
            return null;
          })(),
        };
        if (scenario == 'success') {
          final response = await call();
          if (operation < 6) {
            final dynamic envelope = response;
            expect(envelope.status, 1);
            expect(envelope.message, 'Success');
            expect(jsonDecode(jsonEncode(envelope.data)), payloads[operation]);
          } else {
            expect(response, isNull);
          }
        } else {
          await expectLater(
            call(),
            throwsA(
              scenario == 'timeout'
                  ? const NetworkException('Connection timeout')
                  : scenario == '401'
                  ? const UnauthorizedException('Denied')
                  : scenario == '500'
                  ? const ServerException('Denied')
                  : isA<Exception>().having(
                      (error) => error.toString(),
                      'malformed payload mapping',
                      startsWith(switch (operation) {
                        3 =>
                          'Exception: Unexpected registration recovery status error:',
                        5 => 'Exception: Unexpected token refresh error',
                        6 =>
                          'Exception: Unexpected auth session revocation error',
                        7 => 'Exception: Password reset request failed',
                        8 => 'Exception: Password reset failed',
                        _ => 'Exception: Unexpected error:',
                      }),
                    ),
            ),
          );
        }
        final request = http.requests.single;
        expect(request.method, operation == 3 ? 'GET' : 'POST');
        expect(request.path, paths[operation]);
        expect(request.queryParameters, isEmpty);
        // Retrofit passes DTOs to Dio, which serializes their toJson on the wire.
        final dynamic body = request.data;
        expect(
          body == null || body is Map ? body : body.toJson(),
          bodies[operation],
        );
      });
    }
  }
  for (final operation in ['logout', 'forgot', 'reset']) {
    test('$operation rejects an unsuccessful envelope', () async {
      final http = DataHttpHarness();
      final source = AuthRemoteDataSourceImpl(AuthApiService(http.dio));
      final path = operation == 'logout'
          ? '/auth/logout'
          : operation == 'forgot'
          ? '/auth/forgot-password'
          : '/auth/reset-password';
      http.reply('POST', path, dataEnvelope(null, status: 0));
      await expectLater(
        operation == 'logout'
            ? source.logout('refresh')
            : operation == 'forgot'
            ? source.requestPasswordReset('c@test.dev')
            : source.resetPassword('token', 'Password2!'),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'rejected envelope mapping',
            operation == 'logout'
                ? 'Exception: Unexpected auth session revocation error'
                : operation == 'forgot'
                ? 'Exception: Password reset request failed'
                : 'Exception: Password reset failed',
          ),
        ),
      );
    });
  }
  for (final scenario in ['success', 'rejected', 'timeout']) {
    test('social repository maps $scenario', () async {
      final http = DataHttpHarness();
      http.timeout = scenario == 'timeout';
      http.reply(
        'POST',
        '/auth/social-login',
        dataEnvelope(authPayload, status: scenario == 'rejected' ? 0 : 1),
      );
      final repo = AuthRepositoryImpl(
        AuthRemoteDataSourceImpl(AuthApiService(http.dio)),
      );
      final result = await repo.socialLogin(
        SocialLoginParams(
          provider: 'GOOGLE',
          token: 'provider-token',
          role: 'USER',
          deviceId: 'device',
          deviceName: 'Phone',
          deviceType: 'ANDROID',
          ipAddress: '127.0.0.1',
        ),
      );
      if (scenario == 'success') {
        result.fold((f) => fail(f.message), (u) {
          expect(u.accessToken, 'access');
          expect(u.refreshToken, 'refresh');
        });
      } else {
        result.fold(
          (f) => expect(
            f,
            scenario == 'timeout'
                ? isA<NetworkFailure>()
                : isA<ServerFailure>(),
          ),
          (_) => fail('Expected failure'),
        );
      }
      expect(
        (http.requests.single.data as SocialLoginRequestDto).toJson(),
        socialBody,
      );
    });
  }
  for (final recovery in [
    'linked',
    'pending',
    'rejected',
    'unreachable',
    'no-handle',
  ]) {
    test(
      'registration recovers interrupted profile handoff: $recovery',
      () async {
        final http = DataHttpHarness();
        http.reply(
          'POST',
          '/auth/register',
          dataEnvelope({
            ...registration,
            if (recovery == 'no-handle') 'registrationHandle': null,
          }),
        );
        http.reply('POST', '/users/registrations', {
          'message': 'Profile unavailable',
        }, code: 500);
        if (recovery != 'no-handle') {
          http.reply(
            'GET',
            '/auth/registrations/handle',
            recovery == 'unreachable'
                ? {'message': 'Status unavailable'}
                : dataEnvelope({
                    'principalId': 10,
                    'status': recovery == 'linked'
                        ? 'ACTIVE'
                        : 'PENDING_PROFILE',
                    'nextAction': recovery == 'linked'
                        ? 'LOGIN'
                        : 'CREATE_PROFILE',
                    'profileLinked': recovery == 'linked',
                  }, status: recovery == 'rejected' ? 0 : 1),
            code: recovery == 'unreachable' ? 503 : 200,
          );
        }
        final repo = AuthRepositoryImpl(
          AuthRemoteDataSourceImpl(AuthApiService(http.dio)),
        );
        final result = await repo.register(
          'Customer',
          'c@test.dev',
          'Password1!',
        );
        result.fold((f) => fail(f.message), (r) {
          expect(r.principalId, 10);
          expect(r.profileCreated, recovery == 'linked');
          expect(
            r.registrationHandle,
            recovery == 'no-handle' ? null : 'handle',
          );
          expect(r.expiresAt, DateTime(2026, 10, 1, 10));
          expect(
            r.recoveryMessage,
            recovery == 'linked' ? isNull : contains('Could not confirm'),
          );
        });
        expect(http.requests.map((r) => r.path).toList(), [
          '/auth/register',
          '/users/registrations',
          if (recovery != 'no-handle') '/auth/registrations/handle',
        ]);
        expect((http.requests[1].data as UserRegistrationRequestDto).toJson(), {
          'provisioningToken': 'handoff',
          'fullName': 'Customer',
        });
      },
    );
  }
  for (final operation in ['refresh', 'logout', 'forgot', 'reset']) {
    for (final timeout in [false, true]) {
      test('repository $operation maps timeout=$timeout', () async {
        final http = DataHttpHarness()..timeout = timeout;
        final path = switch (operation) {
          'refresh' => '/auth/refresh-token',
          'logout' => '/auth/logout',
          'forgot' => '/auth/forgot-password',
          _ => '/auth/reset-password',
        };
        http.reply(
          'POST',
          path,
          dataEnvelope(
            operation == 'refresh'
                ? {'accessToken': 'access', 'refreshToken': 'refresh'}
                : null,
          ),
        );
        final repo = AuthRepositoryImpl(
          AuthRemoteDataSourceImpl(AuthApiService(http.dio)),
        );
        final result = switch (operation) {
          'refresh' => await repo.refreshToken('refresh'),
          'logout' => await repo.logout('refresh'),
          'forgot' => await repo.requestPasswordReset('c@test.dev'),
          _ => await repo.resetPassword(
            'abcdefghijklmnopqrstuvwxyzABCDEFGH',
            'Password2!',
          ),
        };
        if (timeout) {
          result.fold((f) {
            expect(f, isA<NetworkFailure>());
            expect(f.message, 'Connection timeout');
          }, (_) => fail('Expected timeout'));
        } else {
          expect(result.isRight(), isTrue);
        }
      });
    }
  }
  test('DTO token and user fields survive JSON serialization', () {
    final auth = AuthDataDto.fromJson(authPayload);
    expect(
      AuthDataDto.fromJson(
        jsonDecode(jsonEncode(auth)) as Map<String, dynamic>,
      ),
      auth,
    );
    final refresh = RefreshTokenDataDto.fromJson({
      'accessToken': 'new',
      'refreshToken': 'rotated',
    });
    expect(RefreshTokenDataDto.fromJson(refresh.toJson()), refresh);
    expect(refresh.toEntity().refreshToken, 'rotated');
    final status = RegistrationStatusDataDto.fromJson({
      'principalId': 10,
      'status': 'ACTIVE',
      'nextAction': 'LOGIN',
      'profileLinked': true,
      'expiresAt': null,
    });
    expect(RegistrationStatusDataDto.fromJson(status.toJson()), status);
  });
}
