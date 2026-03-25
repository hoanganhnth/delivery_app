import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_provider.g.dart';

/// Provider để quản lý trạng thái tab hiện tại
@riverpod
class SelectedTab extends _$SelectedTab {
  @override
  AppTab build() => AppTab.home;

  void setTab(AppTab tab) => state = tab;
}

/// Provider để quản lý việc chuyển tab
@riverpod
NavigationController navigationController(Ref ref) {
  return NavigationController(ref);
}

class NavigationController {
  final Ref _ref;

  NavigationController(this._ref);

  /// Chuyển đến tab Home
  void goToHome() => _ref.read(selectedTabProvider.notifier).setTab(AppTab.home);

  /// Chuyển đến tab Restaurants
  void goToRestaurants() =>
      _ref.read(selectedTabProvider.notifier).setTab(AppTab.restaurants);

  /// Chuyển đến tab Cart
  void goToCart() =>
      _ref.read(selectedTabProvider.notifier).setTab(AppTab.cart);

  /// Chuyển đến tab Orders
  void goToOrders() =>
      _ref.read(selectedTabProvider.notifier).setTab(AppTab.orders);

  /// Chuyển đến tab Profile
  void goToProfile() =>
      _ref.read(selectedTabProvider.notifier).setTab(AppTab.profile);

  /// Chuyển đến tab bằng enum
  void goToTab(AppTab tab) {
    _ref.read(selectedTabProvider.notifier).setTab(tab);
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
