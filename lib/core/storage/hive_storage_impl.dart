import 'package:hive_flutter/hive_flutter.dart';
import 'i_storage.dart';

/// Implementation of IStorage using Hive
class HiveStorageImpl implements IStorage {
  final String boxName;
  Box? _box;

  HiveStorageImpl({this.boxName = 'app_storage'});

  Future<Box> get _getBox async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox(boxName);
    }
    return _box!;
  }

  @override
  Future<void> save<T>(String key, T value) async {
    final box = await _getBox;
    await box.put(key, value);
  }

  @override
  Future<T?> read<T>(String key) async {
    final box = await _getBox;
    return box.get(key) as T?;
  }

  @override
  Future<void> delete(String key) async {
    final box = await _getBox;
    await box.delete(key);
  }

  @override
  Future<void> clear() async {
    final box = await _getBox;
    await box.clear();
  }

  @override
  Future<bool> has(String key) async {
    final box = await _getBox;
    return box.containsKey(key);
  }
}
