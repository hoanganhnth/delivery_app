import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import '../../../../core/logger/app_logger.dart';
import '../models/user_model.dart';

abstract class ProfileLocalDataSource {
  Future<Either<Exception, UserModel?>> getCachedUserProfile();
  Future<Either<Exception, void>> cacheUserProfile(UserModel user);
  Future<Either<Exception, void>> clearCachedUserProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _boxName = 'user_profile';
  static const String _userKey = 'current_user';

  @override
  Future<Either<Exception, UserModel?>> getCachedUserProfile() async {
    try {
      // AppLogger.i('ProfileLocalDataSource: Getting cached user profile');
      final box = await Hive.openBox<UserModel>(_boxName);
      final user = box.get(_userKey);
      // AppLogger.i('ProfileLocalDataSource: Cached user found: ${user != null}');
      return right(user);
    } catch (e) {
      // AppLogger.e('ProfileLocalDataSource: Error getting cached profile - $e');
      return left(Exception('Failed to get cached profile'));
    }
  }

  @override
  Future<Either<Exception, void>> cacheUserProfile(UserModel user) async {
    try {
      // AppLogger.i('ProfileLocalDataSource: Caching user profile');
      final box = await Hive.openBox<UserModel>(_boxName);
      await box.put(_userKey, user);
      // AppLogger.i('ProfileLocalDataSource: User profile cached successfully');
      return right(null);
    } catch (e) {
      // AppLogger.e('ProfileLocalDataSource: Error caching profile - $e');
      return left(Exception('Failed to cache profile'));
    }
  }

  @override
  Future<Either<Exception, void>> clearCachedUserProfile() async {
    try {
      // AppLogger.i('ProfileLocalDataSource: Clearing cached user profile');
      final box = await Hive.openBox<UserModel>(_boxName);
      await box.delete(_userKey);
      // AppLogger.i('ProfileLocalDataSource: Cached profile cleared successfully');
      return right(null);
    } catch (e) {
      // AppLogger.e('ProfileLocalDataSource: Error clearing cached profile - $e');
      return left(Exception('Failed to clear cached profile'));
    }
  }
}
