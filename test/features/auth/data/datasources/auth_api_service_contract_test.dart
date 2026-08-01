import 'package:delivery_app/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:delivery_app/features/auth/data/dtos/login_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/register_request_dto.dart';
import 'package:delivery_app/features/auth/data/dtos/social_login_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

Map<String, dynamic> _response(Object? data) => {
  'status': 1,
  'message': 'Success',
  'data': data,
};

Map<String, dynamic> _authData() => {
  'accessToken': 'access-token',
  'refreshToken': 'refresh-token',
  'user': {'id': 7, 'email': 'customer@test.dev', 'name': 'Customer Test'},
};

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late AuthApiService service;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://gateway.test/api'));
    adapter = DioAdapter(dio: dio);
    service = AuthApiService(dio);
  });

  test('uses canonical login and social-login Gateway routes', () async {
    const loginRequest = LoginRequestDto(
      email: 'customer@test.dev',
      password: 'password',
      deviceId: 'web-device',
      deviceType: 'ANDROID',
    );
    const socialRequest = SocialLoginRequestDto(
      provider: 'GOOGLE',
      token: 'provider-token',
      role: 'USER',
    );
    adapter.onPost(
      '/auth/login',
      (server) => server.reply(200, _response(_authData())),
      data: loginRequest,
    );
    adapter.onPost(
      '/auth/social-login',
      (server) => server.reply(200, _response(_authData())),
      data: socialRequest,
    );

    final login = await service.login(loginRequest);
    final social = await service.socialLogin(socialRequest);

    expect(login.status, 1);
    expect(login.data?.accessToken, 'access-token');
    expect(social.status, 1);
    expect(social.data?.refreshToken, 'refresh-token');
  });

  test(
    'keeps the two-step registration handoff on public Gateway routes',
    () async {
      const registerRequest = RegisterRequestDto(
        email: 'new@test.dev',
        password: 'password',
        name: 'New Customer',
        role: 'USER',
      );
      const profileRequest = UserRegistrationRequestDto(
        provisioningToken: 'opaque-handoff',
        fullName: 'New Customer',
      );
      adapter.onPost(
        '/auth/register',
        (server) => server.reply(
          200,
          _response({
            'authId': 10,
            'email': 'new@test.dev',
            'role': 'USER',
            'provisioningToken': 'opaque-handoff',
          }),
        ),
        data: registerRequest,
      );
      adapter.onPost(
        '/users/registrations',
        (server) => server.reply(
          200,
          _response({
            'id': 11,
            'authId': 10,
            'email': 'new@test.dev',
            'role': 'USER',
            'fullName': 'New Customer',
          }),
        ),
        data: profileRequest,
      );

      final auth = await service.register(registerRequest);
      final profile = await service.registerUserProfile(profileRequest);

      expect(auth.data?.provisioningToken, 'opaque-handoff');
      expect(profile.data?.authId, 10);
    },
  );

  test('uses rotated refresh-token and logout routes', () async {
    final refreshRequest = {'refreshToken': 'refresh-token'};
    final logoutRequest = {'refreshToken': 'rotated-refresh-token'};
    adapter.onPost(
      '/auth/refresh-token',
      (server) => server.reply(
        200,
        _response({
          'accessToken': 'rotated-access-token',
          'refreshToken': 'rotated-refresh-token',
        }),
      ),
      data: refreshRequest,
    );
    adapter.onPost(
      '/auth/logout',
      (server) => server.reply(200, _response(null)),
      data: logoutRequest,
    );

    final refreshed = await service.refreshToken(refreshRequest);
    final loggedOut = await service.logout(logoutRequest);

    expect(refreshed.data?.accessToken, 'rotated-access-token');
    expect(refreshed.data?.refreshToken, 'rotated-refresh-token');
    expect(loggedOut.status, 1);
  });
}
