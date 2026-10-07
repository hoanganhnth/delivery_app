import 'package:delivery_app/core/error/failures.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:delivery_app/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:delivery_app/features/profile/data/dtos/user_profile_dto.dart';
import 'package:delivery_app/features/profile/data/dtos/update_profile_request_dto.dart';
import 'package:delivery_app/features/profile/data/models/user_model.dart';
import 'package:delivery_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:delivery_app/features/profile/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import '../../../../support/data_http_harness.dart';

const profile = <String, dynamic>{
  'id': 1,
  'authId': 10,
  'email': 'customer@test.dev',
  'role': 'USER',
  'fullName': 'Customer',
  'phone': '0900000001',
  'dob': '2000-01-02',
  'avatarUrl': 'avatar.png',
  'address': '1 Lê Lợi',
  'createdAt': '2026-10-01T10:00:00',
  'updatedAt': '2026-10-02T11:00:00',
};

class MemoryProfileCache implements ProfileLocalDataSource {
  UserModel? user;
  String mode = 'success';
  void check() {
    if (mode == 'throw') throw StateError('disk unavailable');
  }

  @override
  Future<Either<Exception, UserModel?>> getCachedUserProfile() async {
    check();
    return mode == 'failure' ? left(Exception('read')) : right(user);
  }

  @override
  Future<Either<Exception, void>> cacheUserProfile(UserModel value) async {
    check();
    if (mode == 'failure') return left(Exception('write'));
    user = value;
    return right(null);
  }

  @override
  Future<Either<Exception, void>> clearCachedUserProfile() async {
    check();
    if (mode == 'failure') return left(Exception('clear'));
    user = null;
    return right(null);
  }
}

class RecordingWriter extends Mock implements BinaryWriter {
  final fields = <Object?>[];
  @override
  void writeByte(int value) => fields.add(value);
  @override
  void write<T>(T value, {bool writeTypeId = true}) => fields.add(value);
}

class RecordingReader extends Mock implements BinaryReader {
  RecordingReader(this.fields);
  final List<Object?> fields;
  int offset = 0;
  @override
  int readByte() => fields[offset++] as int;
  @override
  dynamic read([int? typeId]) => fields[offset++];
}

void main() {
  for (final update in [false, true]) {
    for (final scenario in [
      'success',
      'rejected',
      'null',
      '401',
      '500',
      'timeout',
      'malformed',
    ]) {
      test('${update ? 'PUT' : 'GET'} profile $scenario', () async {
        final http = DataHttpHarness();
        final cache = MemoryProfileCache();
        final repository = ProfileRepositoryImpl(
          remoteDataSource: ProfileRemoteDataSourceImpl(
            ProfileApiService(http.dio),
          ),
          localDataSource: cache,
        );
        http.timeout = scenario == 'timeout';
        http.reply(
          update ? 'PUT' : 'GET',
          '/users',
          scenario == 'malformed'
              ? dataEnvelope({'authId': 'bad'})
              : scenario == '401' || scenario == '500'
              ? {'message': 'Denied'}
              : dataEnvelope(
                  scenario == 'null' ? null : profile,
                  status: scenario == 'rejected' ? 0 : 1,
                ),
          code: int.tryParse(scenario) ?? 200,
        );
        final user = UserProfileDto.fromJson(profile).toEntity();
        final result = update
            ? await repository.updateUserProfile(user)
            : await repository.getUserProfile();
        final request = http.requests.single;
        expect(request.path, '/users');
        expect(request.method, update ? 'PUT' : 'GET');
        expect(request.queryParameters, isEmpty);
        expect(
          request.data,
          update
              ? {
                  'fullName': 'Customer',
                  'phone': '0900000001',
                  'dob': '2000-01-02',
                  'address': '1 Lê Lợi',
                }
              : isNull,
        );
        if (scenario == 'success') {
          result.fold((f) => fail(f.message), (value) => expect(value, user));
          expect(cache.user?.toEntity(), user);
        } else {
          result.fold((f) {
            expect(
              f,
              scenario == 'timeout'
                  ? isA<NetworkFailure>()
                  : scenario == '401'
                  ? isA<UnauthorizedFailure>()
                  : scenario == 'malformed'
                  ? isA<UnexpectedFailure>()
                  : isA<ServerFailure>(),
            );
            if (scenario == 'timeout') expect(f.message, 'Connection timeout');
            if (scenario == '401' || scenario == '500') {
              expect(f.message, 'Denied');
            }
          }, (_) => fail('Expected failure'));
          expect(cache.user, isNull);
        }
      });
    }
  }
  for (final mode in ['success', 'failure', 'throw']) {
    test('cache read/write/clear $mode', () async {
      final cache = MemoryProfileCache()..mode = mode;
      final http = DataHttpHarness();
      final repository = ProfileRepositoryImpl(
        remoteDataSource: ProfileRemoteDataSourceImpl(
          ProfileApiService(http.dio),
        ),
        localDataSource: cache,
      );
      final user = UserProfileDto.fromJson(profile).toEntity();
      if (mode == 'success') {
        (await repository.getCachedUserProfile()).fold(
          (f) => fail(f.message),
          (u) => expect(u, isNull),
        );
      }
      final stored = await repository.cacheUserProfile(user);
      final read = await repository.getCachedUserProfile();
      final cleared = await repository.clearCachedUserProfile();
      if (mode == 'success') {
        expect(stored.isRight(), isTrue);
        expect(cleared.isRight(), isTrue);
        read.fold((f) => fail(f.message), (u) => expect(u, user));
        expect(cache.user, isNull);
      } else {
        for (final result in [stored, read, cleared]) {
          result.fold(
            (f) => expect(f, isA<CacheFailure>()),
            (_) => fail('Expected cache failure'),
          );
        }
      }
    });
  }
  test(
    'profile/model mappers preserve fields and handle invalid and absent dates',
    () {
      final dto = UserProfileDto.fromJson(profile);
      final entity = dto.toEntity();
      expect(entity.id, 1);
      expect(entity.authId, 10);
      expect(entity.email, 'customer@test.dev');
      expect(entity.role, 'USER');
      expect(entity.fullName, 'Customer');
      expect(entity.phone, '0900000001');
      expect(entity.dob, DateTime(2000, 1, 2));
      expect(entity.avatarUrl, 'avatar.png');
      expect(entity.address, '1 Lê Lợi');
      expect(entity.createdAt, DateTime(2026, 10, 1, 10));
      expect(entity.updatedAt, DateTime(2026, 10, 2, 11));
      expect(UserProfileDto.fromJson(dto.toJson()), dto);
      final converted = UserProfileDtoExtension.fromEntity(entity);
      expect(converted.toEntity(), entity);
      final model = UserModelExtension.fromEntity(entity);
      expect(UserModel.fromJson(model.toJson()), model);
      expect(model.toEntity(), entity);
      final update = UpdateProfileRequestDtoExtension.fromEntity(entity);
      expect(UpdateProfileRequestDto.fromJson(update.toJson()), update);
      for (final date in [null, 'invalid']) {
        expect(
          dto
              .copyWith(dob: date, createdAtString: date, updatedAtString: date)
              .toEntity()
              .dob,
          isNull,
        );
        expect(
          model
              .copyWith(dob: date, createdAtString: date, updatedAtString: date)
              .toEntity()
              .createdAt,
          isNull,
        );
      }
      const minimal = UserEntity(authId: 10, email: 'c@test.dev', role: 'USER');
      expect(UserProfileDtoExtension.fromEntity(minimal).dob, isNull);
      expect(UserModelExtension.fromEntity(minimal).toEntity(), minimal);
      expect(UpdateProfileRequestDtoExtension.fromEntity(minimal).toJson(), {
        'fullName': null,
        'phone': null,
        'dob': null,
        'address': null,
      });
    },
  );
  test(
    'Hive adapter writes stable field indexes and reads the complete model',
    () {
      final model = UserModelExtension.fromEntity(
        UserProfileDto.fromJson(profile).toEntity(),
      );
      final writer = RecordingWriter();
      final adapter = UserModelAdapter();
      adapter.write(writer, model);
      expect(writer.fields, [
        11,
        0,
        1,
        1,
        10,
        2,
        'customer@test.dev',
        3,
        'USER',
        4,
        'Customer',
        5,
        '0900000001',
        6,
        '2000-01-02T00:00:00.000',
        7,
        'avatar.png',
        8,
        '1 Lê Lợi',
        9,
        '2026-10-01T10:00:00.000',
        10,
        '2026-10-02T11:00:00.000',
      ]);
      expect(adapter.read(RecordingReader(writer.fields)), model);
      expect(adapter, UserModelAdapter());
      expect(adapter.hashCode, adapter.typeId.hashCode);
      expect(adapter == Object(), isFalse);
    },
  );
}
