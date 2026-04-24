import 'package:delivery_app/core/logger/app_logger.dart';
import 'i_app_initializer_service.dart';

/// Core implementation of IAppInitializerService.
/// Domain-agnostic: runs generic tasks, knows nothing about Auth/Profile.
class AppInitializerService implements IAppInitializerService {
  final List<InitTask> _initTasks;
  final List<InitTask> _cleanupTasks;

  AppInitializerService({
    required List<InitTask> initTasks,
    List<InitTask> cleanupTasks = const [],
  })  : _initTasks = initTasks,
        _cleanupTasks = cleanupTasks;

  @override
  Future<bool> initialize() async {
    try {
      AppLogger.i('AppInitializerService: Initializing...');

      await Future.wait(
        _initTasks.map((task) => task()),
      );

      AppLogger.i('AppInitializerService: Completed.');
      return true;
    } catch (e) {
      AppLogger.e('AppInitializerService: Init Failed: $e');
      return false;
    }
  }

  @override
  Future<void> cleanup() async {
    try {
      AppLogger.i('AppInitializerService: Cleaning up...');

      await Future.wait(
        _cleanupTasks.map((task) => task()),
      );

      AppLogger.i('AppInitializerService: Cleanup completed.');
    } catch (e) {
      AppLogger.e('AppInitializerService: Cleanup Failed: $e');
    }
  }
}
