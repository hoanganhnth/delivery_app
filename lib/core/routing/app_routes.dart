/// App route constants
/// This file contains all route paths used in the application
class AppRoutes {
  // Root routes
  static const String root = '/';
  static const String splash = '/splash';
  
  // Auth routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  
  // Main app routes
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  
  // Delivery routes
  static const String orders = '/orders';
  static const String orderDetails = '/orders/:orderId';
  static const String trackOrder = '/orders/:orderId/track';
  
  // Restaurant routes
  static const String restaurants = '/restaurants';
  static const String restaurantDetails = '/restaurants/:restaurantId';
  static const String menu = '/restaurants/:restaurantId/menu';
  
  // Cart and checkout
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String payment = '/payment';
  static const String orderConfirmation = '/order-confirmation';
  
  // Admin routes
  static const String admin = '/admin';
  static const String adminUsers = '/admin/users';
  static const String adminSettings = '/admin/settings';

  // Error routes
  static const String notFound = '/404';
  static const String error = '/error';
  
  // Helper methods to generate dynamic routes
  static String orderDetailsPath(String orderId) => '/orders/$orderId';
  static String trackOrderPath(String orderId) => '/orders/$orderId/track';
  static String restaurantDetailsPath(String restaurantId) => '/restaurants/$restaurantId';
  static String menuPath(String restaurantId) => '/restaurants/$restaurantId/menu';
}
