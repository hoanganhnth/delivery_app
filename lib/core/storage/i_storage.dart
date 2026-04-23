/// Interface for key-value storage service
abstract class IStorage {
  /// Save data to storage
  Future<void> save<T>(String key, T value);

  /// Read data from storage
  Future<T?> read<T>(String key);

  /// Delete data from storage
  Future<void> delete(String key);

  /// Clear all data from storage
  Future<void> clear();

  /// Check if key exists
  Future<bool> has(String key);
}
