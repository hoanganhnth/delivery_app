import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../i_storage.dart';
import '../hive_storage_impl.dart';

part 'storage_providers.g.dart';

@Riverpod(keepAlive: true)
IStorage storage(Ref ref) {
  return HiveStorageImpl();
}

/// Specialized storage for auth/secure data if needed
@Riverpod(keepAlive: true)
IStorage authStorage(Ref ref) {
  return HiveStorageImpl(boxName: 'auth_storage');
}
