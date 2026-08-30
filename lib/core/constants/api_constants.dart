import '../config/runtime_config.dart';

class ApiConstants {
  ApiConstants._();
  static String get api => RuntimeConfig.apiBaseUrl;
  static const auth = "/auth";
  static const login = "$auth/login";
  static const socialLogin = "$auth/social-login";
  static const register = "$auth/register";
  static const registrationStatus = "$auth/registrations/{handle}";
  static const userRegistration = "/users/registrations";
  static const refreshToken = "$auth/refresh-token";
  static const logout = "$auth/logout";
  static const forgotPassword = "$auth/forgot-password";
  static const resetPassword = "$auth/reset-password";
  static const getProfile = "/users";

  static const getRestaurant = "/restaurants";
  static const getMenuItemsByRestaurant =
      "/menu-items/restaurant/{restaurantId}";
  static const order = "/orders";
  static const getOrdersByUser = "$order/my-orders";
  static const customerRefundCases = "/settlement/refunds/my";
  static const customerPaymentCreate = "/settlement/payments/create";
  static String customerPaymentByReference(String paymentRef) =>
      '/settlement/payments/ref/${Uri.encodeComponent(paymentRef)}';
  static const delivery = "/deliveries";
  static const promotion = "/promotions";
  static const myVouchers = "$promotion/my-vouchers";
  static const voucherCapability = "$promotion/capability";
  static String collectVoucher(String code) =>
      "$promotion/collect/${Uri.encodeComponent(code)}";
  static const flashSales = "/flashsales";
  static const activeFlashSaleCampaigns = "$flashSales/public/campaigns";
  static String flashSaleCampaignItems(int campaignId) =>
      "$activeFlashSaleCampaigns/$campaignId/items";

  // Notifications
  static const notifications = "/notifications";
  static const userNotifications = "$notifications/user";
  static const unreadNotifications = "$notifications/unread";
  static const unreadCount = "$notifications/unread-count";
  static const markAllRead = "$notifications/mark-all-read";

  // Firebase FCM Token
  static const firebaseRegisterToken = "/firebase/register-token";
  static const firebaseUnregisterToken = "/firebase/unregister-token";
}
