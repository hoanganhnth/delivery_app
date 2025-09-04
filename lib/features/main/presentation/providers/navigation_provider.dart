import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider để quản lý trạng thái tab hiện tại
final selectedTabProvider = StateProvider<AppTab>((ref) => AppTab.home);

/// Provider để quản lý việc chuyển tab
final navigationControllerProvider = Provider<NavigationController>((ref) {
  return NavigationController(ref);
});

class NavigationController {
  final Ref _ref;

  NavigationController(this._ref);

  /// Chuyển đến tab Home
  void goToHome() => _ref.read(selectedTabProvider.notifier).state = AppTab.home;

  /// Chuyển đến tab Restaurants
  void goToRestaurants() =>
      _ref.read(selectedTabProvider.notifier).state = AppTab.restaurants;

  /// Chuyển đến tab Cart
  void goToCart() =>
      _ref.read(selectedTabProvider.notifier).state = AppTab.cart;

  /// Chuyển đến tab Orders
  void goToOrders() =>
      _ref.read(selectedTabProvider.notifier).state = AppTab.orders;

  /// Chuyển đến tab Profile
  void goToProfile() =>
      _ref.read(selectedTabProvider.notifier).state = AppTab.profile;

  /// Chuyển đến tab bằng enum
  void goToTab(AppTab tab) {
    _ref.read(selectedTabProvider.notifier).state = tab;
  }

  /// Lấy tab hiện tại
  AppTab getCurrentTab() {
    return _ref.read(selectedTabProvider);
  }
}

/// Enum để định nghĩa các tab
enum AppTab {
  home(0, 'Home'),
  restaurants(1, 'Restaurants'),
  cart(2, 'Cart'),
  orders(3, 'Orders'),
  profile(4, 'Profile');

  const AppTab(this.tabIndex, this.label);

  final int tabIndex;
  final String label;
}
