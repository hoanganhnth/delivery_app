class ApiConstants {
  ApiConstants._();
  static const api = "http://10.0.2.2:8079/api";
  static const apiIos = "http://localhost:8079/api";
  static const auth = "/auth";
  static const login = "$auth/login";
  static const register = "$auth/register";
  static const refreshToken = "$auth/refresh-token";
  static const getProfile = "/users";

  static const getRestaurant = "/restaurants";
  static const getMenuItemsByRestaurant =
      "/menu-items/restaurant/{restaurantId}";
  static const getRestaurantNearBy = "/restaurants/nearby";
}
