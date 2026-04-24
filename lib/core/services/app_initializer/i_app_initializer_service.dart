abstract class IAppInitializerService {
  /// Initialize core app services and session
  Future<void> initialize();

  /// Clean up data after logout
  Future<void> clearDataAfterLogout();
}
