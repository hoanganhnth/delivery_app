class ApiConstants {
  ApiConstants._();
  static const api = "http://10.0.2.2:8079/api";
  static const apiIos = "http://localhost:8079/api";
  static const auth = "/auth";
  static const login = "$auth/login";
  static const socialLogin = "$auth/social-login";
  static const register = "$auth/register";
  static const refreshToken = "$auth/refresh-token";
  static const getProfile = "/users";

  static const getRestaurant = "/restaurants";
  static const getMenuItemsByRestaurant =
      "/menu-items/restaurant/{restaurantId}";
  static const getRestaurantNearBy = "/restaurants/nearby";
  static const order = "/orders";
  static const getOrdersByUser = "$order/my-orders";
  static const delivery = "/deliveries";

  // Notifications
  static const notifications = "/notifications";
  static const userNotifications = "$notifications/user";
  static const unreadNotifications = "$notifications/unread";
  static const unreadCount = "$notifications/unread-count";
  static const markAllRead = "$notifications/mark-all-read";

  // Tracking
  static const tracking = "/tracking";
  static const shipperLocations = "$tracking/shipper-locations";
}
