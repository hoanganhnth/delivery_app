import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

/// Navigation helper class for easy navigation throughout the app
class NavigationHelper {
  /// Navigate to login screen
  static void goToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  /// Navigate to register screen
  static void goToRegister(BuildContext context) {
    context.go(AppRoutes.register);
  }

  /// Navigate to home screen
  static void goToHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  /// Navigate to profile screen
  static void goToProfile(BuildContext context) {
    context.go(AppRoutes.profile);
  }

  /// Navigate to settings screen
  static void goToSettings(BuildContext context) {
    context.go(AppRoutes.settings);
  }
  /// Navigate to main screen
  static void goToMain(BuildContext context) {
    context.go(AppRoutes.main);
  }

  /// Navigate to orders screen
  static void goToOrders(BuildContext context) {
    context.go(AppRoutes.orders);
  }

  /// Navigate to order details screen
  static void goToOrderDetails(BuildContext context, String orderId) {
    context.go(AppRoutes.orderDetailsPath(orderId));
  }

  /// Navigate to track order screen
  static void goToTrackOrder(BuildContext context, String orderId) {
    context.go(AppRoutes.trackOrderPath(orderId));
  }

  /// Navigate to restaurants screen
  static void goToRestaurants(BuildContext context) {
    context.go(AppRoutes.restaurants);
  }

  /// Navigate to restaurant details screen
  static void goToRestaurantDetails(BuildContext context, String restaurantId) {
    context.go(AppRoutes.restaurantDetailsPath(restaurantId));
  }

  /// Navigate to menu screen
  static void goToMenu(BuildContext context, String restaurantId) {
    context.go(AppRoutes.menuPath(restaurantId));
  }

  /// Navigate to cart screen
  static void goToCart(BuildContext context) {
    context.go(AppRoutes.cart);
  }

  /// Navigate to checkout screen
  static void goToCheckout(BuildContext context) {
    context.go(AppRoutes.checkout);
  }

  /// Navigate to payment screen
  static void goToPayment(BuildContext context) {
    context.go(AppRoutes.payment);
  }

  /// Navigate to order confirmation screen
  static void goToOrderConfirmation(BuildContext context) {
    context.go(AppRoutes.orderConfirmation);
  }

  /// Push navigation methods (keeps current screen in stack)
  
  /// Push login screen
  static void pushLogin(BuildContext context) {
    context.push(AppRoutes.login);
  }

  /// Push register screen
  static void pushRegister(BuildContext context) {
    context.push(AppRoutes.register);
  }

  /// Push profile screen
  static void pushProfile(BuildContext context) {
    context.push(AppRoutes.profile);
  }

  /// Push settings screen
  static void pushSettings(BuildContext context) {
    context.push(AppRoutes.settings);
  }

  /// Push order details screen
  static void pushOrderDetails(BuildContext context, String orderId) {
    context.push(AppRoutes.orderDetailsPath(orderId));
  }

  /// Push restaurant details screen
  static void pushRestaurantDetails(BuildContext context, String restaurantId) {
    context.push(AppRoutes.restaurantDetailsPath(restaurantId));
  }

  /// Push menu screen
  static void pushMenu(BuildContext context, String restaurantId) {
    context.push(AppRoutes.menuPath(restaurantId));
  }

  /// Push cart screen
  static void pushCart(BuildContext context) {
    context.push(AppRoutes.cart);
  }

  /// Utility methods

  /// Go back to previous screen
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  /// Go to root and clear all navigation stack
  static void goToRoot(BuildContext context) {
    context.go(AppRoutes.root);
  }

  /// Replace current screen with new one
  static void replaceWith(BuildContext context, String route) {
    context.pushReplacement(route);
  }

  /// Show modal bottom sheet with navigation
  static void showBottomSheetNavigation(
    BuildContext context, {
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => child,
    );
  }

  /// Show dialog with navigation options
  static void showNavigationDialog(
    BuildContext context, {
    required String title,
    required String content,
    required List<NavigationDialogAction> actions,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions.map((action) {
          return TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              action.onPressed?.call();
            },
            child: Text(action.label),
          );
        }).toList(),
      ),
    );
  }
}

/// Action for navigation dialog
class NavigationDialogAction {
  final String label;
  final VoidCallback? onPressed;

  NavigationDialogAction({
    required this.label,
    this.onPressed,
  });
}

/// Extension methods for easier navigation
extension NavigationExtension on BuildContext {
  /// Quick access to navigation helper methods
  void goToLogin() => NavigationHelper.goToLogin(this);
  void goToRegister() => NavigationHelper.goToRegister(this);
  void goToMain() => NavigationHelper.goToMain(this);
  void goToHome() => NavigationHelper.goToHome(this);
  void goToProfile() => NavigationHelper.goToProfile(this);
  void goToSettings() => NavigationHelper.goToSettings(this);
  void goToOrders() => NavigationHelper.goToOrders(this);
  void goToRestaurants() => NavigationHelper.goToRestaurants(this);
  void goToCart() => NavigationHelper.goToCart(this);
  
  void goToOrderDetails(String orderId) => NavigationHelper.goToOrderDetails(this, orderId);
  void goToRestaurantDetails(String restaurantId) => NavigationHelper.goToRestaurantDetails(this, restaurantId);
  void goToMenu(String restaurantId) => NavigationHelper.goToMenu(this, restaurantId);
  
  void pushLogin() => NavigationHelper.pushLogin(this);
  void pushRegister() => NavigationHelper.pushRegister(this);
  void pushProfile() => NavigationHelper.pushProfile(this);
  void pushSettings() => NavigationHelper.pushSettings(this);
  void pushCart() => NavigationHelper.pushCart(this);
  
  void goBack() => NavigationHelper.goBack(this);
  void goToRoot() => NavigationHelper.goToRoot(this);
}
