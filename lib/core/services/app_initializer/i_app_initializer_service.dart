/// Represents a named initialization task.
/// Core-level abstraction — no business knowledge.
typedef InitTask = Future<void> Function();

/// Core interface for app initialization orchestration.
/// Domain-agnostic: accepts a list of generic [InitTask] callbacks.
/// Feature layer decides WHAT to initialize; Core decides HOW.
abstract class IAppInitializerService {
  /// Run all registered initialization tasks.
  /// Returns true if critical tasks succeeded, false otherwise.
  Future<bool> initialize();

  /// Run all registered cleanup tasks (e.g. after logout).
  Future<void> cleanup();
}
