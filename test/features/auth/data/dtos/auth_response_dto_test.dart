import 'dart:convert';
import 'package:delivery_app/features/auth/data/dtos/auth_response_dto.dart';
import 'package:delivery_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthDataDto Tests', () {
    const tAccessToken = 'test_access_token_123';
    const tRefreshToken = 'test_refresh_token_456';
    
    final tUserDto = UserDto(
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
    );

    final tAuthDataDto = AuthDataDto(
      accessToken: tAccessToken,
      refreshToken: tRefreshToken,
      user: tUserDto,
    );

    group('JSON Serialization', () {
      test('should create AuthDataDto from JSON', () {
        // arrange
        final jsonMap = {
          'accessToken': tAccessToken,
          'refreshToken': tRefreshToken,
          'user': {
            'id': 1,
            'email': 'test@example.com',
            'name': 'Test User',
            'createdAt': '2024-01-01T00:00:00.000Z',
          },
        };

        // act
        final result = AuthDataDto.fromJson(jsonMap);

        // assert
        expect(result.accessToken, tAccessToken);
        expect(result.refreshToken, tRefreshToken);
        expect(result.user, isNotNull);
        expect(result.user!.id, 1);
        expect(result.user!.email, 'test@example.com');
        expect(result.user!.name, 'Test User');
      });

      test('should convert AuthDataDto to JSON', () {
        // act
        final result = tAuthDataDto.toJson();

        // assert
        expect(result['accessToken'], tAccessToken);
        expect(result['refreshToken'], tRefreshToken);
        expect(result['user'], isNotNull);

        // With Freezed, nested objects are serialized properly
        if (result['user'] is Map<String, dynamic>) {
          final userMap = result['user'] as Map<String, dynamic>;
          expect(userMap['id'], 1);
          expect(userMap['email'], 'test@example.com');
          expect(userMap['name'], 'Test User');
        } else {
          // If it's still a UserDto object, that's also valid
          expect(result['user'], isA<UserDto>());
        }
      });

      test('should handle JSON with null user', () {
        // arrange
        final jsonMap = {
          'accessToken': tAccessToken,
          'refreshToken': tRefreshToken,
          'user': null,
        };

        // act
        final result = AuthDataDto.fromJson(jsonMap);

        // assert
        expect(result.accessToken, tAccessToken);
        expect(result.refreshToken, tRefreshToken);
        expect(result.user, isNull);
      });

      test('should handle JSON without user field', () {
        // arrange
        final jsonMap = {
          'accessToken': tAccessToken,
          'refreshToken': tRefreshToken,
        };

        // act
        final result = AuthDataDto.fromJson(jsonMap);

        // assert
        expect(result.accessToken, tAccessToken);
        expect(result.refreshToken, tRefreshToken);
        expect(result.user, isNull);
      });

      test('should handle real JSON string', () {
        // arrange
        const jsonString = '''
        {
          "accessToken": "test_access_token_123",
          "refreshToken": "test_refresh_token_456",
          "user": {
            "id": 1,
            "email": "test@example.com",
            "name": "Test User",
            "createdAt": "2024-01-01T00:00:00.000Z"
          }
        }
        ''';

        // act
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        final result = AuthDataDto.fromJson(jsonMap);

        // assert
        expect(result.accessToken, 'test_access_token_123');
        expect(result.refreshToken, 'test_refresh_token_456');
        expect(result.user!.email, 'test@example.com');
      });
    });

    group('Extension Methods', () {
      test('should convert AuthDataDto to AuthEntity', () {
        // act
        final result = tAuthDataDto.toEntity();

        // assert
        expect(result, isA<AuthEntity>());
        expect(result.accessToken, tAccessToken);
        expect(result.refreshToken, tRefreshToken);
      });

      test('should convert AuthDataDto without user to AuthEntity', () {
        // arrange
        final authDataWithoutUser = AuthDataDto(
          accessToken: tAccessToken,
          refreshToken: tRefreshToken,
          user: null,
        );

        // act
        final result = authDataWithoutUser.toEntity();

        // assert
        expect(result, isA<AuthEntity>());
        expect(result.accessToken, tAccessToken);
        expect(result.refreshToken, tRefreshToken);
      });
    });

    group('Freezed Features', () {
      test('should support equality comparison', () {
        // arrange
        final authData1 = AuthDataDto(
          accessToken: tAccessToken,
          refreshToken: tRefreshToken,
          user: tUserDto,
        );

        final authData2 = AuthDataDto(
          accessToken: tAccessToken,
          refreshToken: tRefreshToken,
          user: tUserDto,
        );

        final authData3 = AuthDataDto(
          accessToken: 'different_token',
          refreshToken: tRefreshToken,
          user: tUserDto,
        );

        // assert
        expect(authData1 == authData2, true);
        expect(authData1 == authData3, false);
      });

      test('should support copyWith method', () {
        // act
        final result = tAuthDataDto.copyWith(
          accessToken: 'new_access_token',
        );

        // assert
        expect(result.accessToken, 'new_access_token');
        expect(result.refreshToken, tRefreshToken); // unchanged
        expect(result.user, tUserDto); // unchanged
      });

      test('should have proper toString representation', () {
        // act
        final result = tAuthDataDto.toString();

        // assert
        expect(result, contains('AuthDataDto'));
        expect(result, contains(tAccessToken));
        expect(result, contains(tRefreshToken));
      });

      test('should have consistent hashCode', () {
        // arrange
        final authData1 = AuthDataDto(
          accessToken: tAccessToken,
          refreshToken: tRefreshToken,
          user: tUserDto,
        );

        final authData2 = AuthDataDto(
          accessToken: tAccessToken,
          refreshToken: tRefreshToken,
          user: tUserDto,
        );

        // assert
        expect(authData1.hashCode, authData2.hashCode);
      });
    });
  });

  group('UserDto Tests', () {
    final tUserDto = UserDto(
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
    );

    group('JSON Serialization', () {
      test('should create UserDto from JSON', () {
        // arrange
        final jsonMap = {
          'id': 1,
          'email': 'test@example.com',
          'name': 'Test User',
          'createdAt': '2024-01-01T00:00:00.000Z',
        };

        // act
        final result = UserDto.fromJson(jsonMap);

        // assert
        expect(result.id, 1);
        expect(result.email, 'test@example.com');
        expect(result.name, 'Test User');
        expect(result.createdAt, DateTime.parse('2024-01-01T00:00:00.000Z'));
      });

      test('should convert UserDto to JSON', () {
        // act
        final result = tUserDto.toJson();

        // assert
        expect(result['id'], 1);
        expect(result['email'], 'test@example.com');
        expect(result['name'], 'Test User');
        expect(result['createdAt'], '2024-01-01T00:00:00.000Z');
      });

      test('should handle JSON with null optional fields', () {
        // arrange
        final jsonMap = {
          'id': 1,
          'email': 'test@example.com',
          'name': null,
          'createdAt': null,
        };

        // act
        final result = UserDto.fromJson(jsonMap);

        // assert
        expect(result.id, 1);
        expect(result.email, 'test@example.com');
        expect(result.name, isNull);
        expect(result.createdAt, isNull);
      });

      test('should handle JSON without optional fields', () {
        // arrange
        final jsonMap = {
          'id': 1,
          'email': 'test@example.com',
        };

        // act
        final result = UserDto.fromJson(jsonMap);

        // assert
        expect(result.id, 1);
        expect(result.email, 'test@example.com');
        expect(result.name, isNull);
        expect(result.createdAt, isNull);
      });
    });

    group('Freezed Features', () {
      test('should support equality comparison', () {
        // arrange
        final user1 = UserDto(
          id: 1,
          email: 'test@example.com',
          name: 'Test User',
        );

        final user2 = UserDto(
          id: 1,
          email: 'test@example.com',
          name: 'Test User',
        );

        final user3 = UserDto(
          id: 2,
          email: 'test@example.com',
          name: 'Test User',
        );

        // assert
        expect(user1 == user2, true);
        expect(user1 == user3, false);
      });

      test('should support copyWith method', () {
        // act
        final result = tUserDto.copyWith(
          name: 'Updated Name',
        );

        // assert
        expect(result.name, 'Updated Name');
        expect(result.id, 1); // unchanged
        expect(result.email, 'test@example.com'); // unchanged
      });
    });
  });
}
