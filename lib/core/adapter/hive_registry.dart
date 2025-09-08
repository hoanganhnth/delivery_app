
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/profile/data/models/user_model.dart';
import '../../features/cart/data/adapters/cart_dto_adapter.dart';
import '../../features/cart/data/adapters/cart_item_dto_adapter.dart';

/// Hive Type IDs - Centralized management to prevent conflicts
class HiveTypeIds {
  static const int cartItemDto = 0;
  static const int cartDto = 2;
  static const int userModel = 1;
}

/// Centralized Hive adapter registry
class HiveAdapterRegistry {
  /// Register all Hive adapters with their type IDs
  static void registerAllAdapters() {
    // Cart adapters
    Hive.registerAdapter(CartItemDtoAdapter());
    Hive.registerAdapter(CartDtoAdapter());

    // User adapters
    Hive.registerAdapter(UserModelAdapter());

    // Add more adapters here as needed
  }

  /// Get list of all registered adapter type IDs for validation
  static List<int> getRegisteredTypeIds() {
    return [
      HiveTypeIds.cartItemDto,
      HiveTypeIds.cartDto,
      HiveTypeIds.userModel,
    ];
  }

  /// Validate that all type IDs are unique
  static bool validateTypeIds() {
    final typeIds = getRegisteredTypeIds();
    final uniqueIds = typeIds.toSet();
    return typeIds.length == uniqueIds.length;
  }
}
