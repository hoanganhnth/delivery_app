import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';

/// Utility class để chuyển tab từ bất kỳ đâu trong app
/// Sử dụng: NavigationUtils.goToTab(ref, AppTab.restaurants);
class NavigationUtils {
  /// Chuyển đến tab bằng enum
  static void goToTab(WidgetRef ref, AppTab tab) {
    ref.read(selectedTabProvider.notifier).state = tab;
  }

  /// Chuyển đến tab bằng index
  static void goToTabByIndex(WidgetRef ref, int index) {
    if (index >= 0 && index < AppTab.values.length) {
      ref.read(selectedTabProvider.notifier).state = AppTab.values[index];
    }
  }

  /// Chuyển đến Home tab
  static void goToHome(WidgetRef ref) {
    ref.read(selectedTabProvider.notifier).state = AppTab.home;
  }

  /// Chuyển đến Restaurants tab
  static void goToRestaurants(WidgetRef ref) {
    ref.read(selectedTabProvider.notifier).state = AppTab.restaurants;
  }

  /// Chuyển đến Cart tab
  static void goToCart(WidgetRef ref) {
    ref.read(selectedTabProvider.notifier).state = AppTab.cart;
  }

  /// Chuyển đến Orders tab
  static void goToOrders(WidgetRef ref) {
    ref.read(selectedTabProvider.notifier).state = AppTab.orders;
  }

  /// Chuyển đến Profile tab
  static void goToProfile(WidgetRef ref) {
    ref.read(selectedTabProvider.notifier).state = AppTab.profile;
  }

  /// Lấy tab hiện tại
  static AppTab getCurrentTab(WidgetRef ref) {
    return ref.read(selectedTabProvider);
  }

  /// Kiểm tra xem có phải tab hiện tại không
  static bool isCurrentTab(WidgetRef ref, AppTab tab) {
    return ref.read(selectedTabProvider) == tab;
  }
}
