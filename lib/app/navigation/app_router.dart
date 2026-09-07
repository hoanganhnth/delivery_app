/// Pure Dart factory for creating the app's GoRouter.
///
/// No Riverpod, no BLoC — depends only on:
/// - [IAuthNotifier]: tells the router WHO is logged in and WHEN state changes
/// - [AppRouterConfig]: configuration (initial route, redirects, etc.)
///
/// This function can be tested in pure Dart unit tests by passing a mock
/// [IAuthNotifier] implementation, with no framework mocking needed.
library;

import 'package:delivery_app/features/home/presentation/pages/home_page.dart';
import 'package:delivery_app/features/orders/presentation/screens/order_detail_screen.dart';
import 'package:delivery_app/features/orders/presentation/screens/refund_status_history_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/features/auth/presentation/screens/login_screen.dart';
import 'package:delivery_app/features/auth/presentation/screens/register_screen.dart';
import 'package:delivery_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:delivery_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:delivery_app/features/notification/presentation/screens/notification_screen.dart';
import 'package:delivery_app/features/catalog/presentation/pages/catalog_search_page.dart';
import 'package:delivery_app/features/catalog/presentation/pages/catalog_all_restaurants_page.dart';
import 'package:delivery_app/features/catalog/presentation/pages/catalog_restaurant_detail_page.dart';
import 'package:delivery_app/features/main/presentation/pages/main_screen.dart';
import 'package:delivery_app/features/profile/profile.dart';
import 'package:delivery_app/features/settings/settings.dart';
import 'package:delivery_app/features/debug/debug.dart';
import 'package:delivery_app/features/orders/orders.dart';
import 'package:delivery_app/features/livestream/presentation/livestream_viewer_page.dart';
import 'package:delivery_app/features/entitlements/presentation/entitlement_status_page.dart';
import 'package:delivery_app/features/promotion/presentation/pages/voucher_wallet_page.dart';
import 'package:delivery_app/features/support/presentation/support_page.dart';
import 'package:delivery_app/features/cart/cart.dart';
import 'package:delivery_app/features/user_address/presentation/screens/address_list_screen.dart';
import 'package:delivery_app/features/user_address/application/address_list_context.dart';
import 'package:delivery_app/features/user_address/presentation/screens/add_edit_address_screen.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:delivery_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/core/routing/constants/app_routes.dart';
import 'package:delivery_app/core/routing/models/app_router_config.dart';
import 'package:delivery_app/core/routing/models/i_auth_checker.dart';
import 'package:delivery_app/core/routing/guards/guard_manager.dart';

final _livestreamUuid = RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$',
);

/// Replaceable screen factory for router tests and previews. Production keeps
/// the concrete pages below; tests can verify redirects and route parameters
/// without constructing network, storage, Firebase or Mapbox dependencies.
class AppRouterPages {
  const AppRouterPages();

  Widget splash() => const SplashScreen();
  Widget login() => const LoginScreen();
  Widget register() => const RegisterScreen();
  Widget forgotPassword() => const ForgotPasswordPage();
  Widget resetPassword(String token) => ResetPasswordPage(token: token);
  Widget main() => const MainScreen();
  Widget search() => const CatalogSearchPage();
  Widget notifications() => const NotificationScreen();
  Widget home() => const HomePage();
  Widget profile() => const ProfileScreen();
  Widget settings() => const SettingsScreen();
  Widget entitlements() => const EntitlementStatusPage();
  Widget vouchers() => const VoucherWalletPage();
  Widget support() => const SupportPage();
  Widget debugTools() => const DebugToolsScreen();
  Widget orders() => const OrdersScreen();
  Widget refundHistory() => const RefundStatusHistoryScreen();
  Widget orderDetail(int orderId) => OrderDetailScreen(orderId: orderId);
  Widget restaurants() => const CatalogAllRestaurantsPage();
  Widget restaurantDetail(int restaurantId) =>
      CatalogRestaurantDetailPage(restaurantId: restaurantId);
  Widget livestreamViewer(String livestreamId) =>
      LivestreamViewerPage(livestreamId: livestreamId);
  Widget cart() => const CartScreen();
  Widget checkout() => const CheckoutScreen();
  Widget orderConfirmation() => const OrderConfirmationScreen();
  Widget addressList({
    AddressListContext selectionContext = AddressListContext.management,
    bool? isSelectMode,
  }) => AddressListScreen(
    selectionContext: selectionContext,
    isSelectMode: isSelectMode,
  );
  Widget addAddress() => const AddEditAddressScreen();
  Widget editAddress(UserAddressEntity? address, {int? addressId}) =>
      AddEditAddressScreen(address: address, addressId: addressId);
  Widget notFound() => const NotFoundScreen();
  Widget error() => const ErrorScreen();
}

/// Creates the application's [GoRouter].
///
/// - [authNotifier] is used both as `refreshListenable` (reactive) and as
///   [IAuthChecker] (readable state) for [GuardManager]. No duplicate state.
/// - [config] controls initial location, redirect on/off, debug logging, etc.
GoRouter createAppRouter({
  required IAuthNotifier authNotifier,
  required AppRouterConfig config,
  AppRouterPages pages = const AppRouterPages(),
}) {
  final guardManager = GuardManager(authNotifier);

  return GoRouter(
    refreshListenable: authNotifier,
    initialLocation: config.initialLocation,
    debugLogDiagnostics: config.debugLogDiagnostics,
    redirect: config.enableRedirects
        ? (context, state) {
            // Splash handles its own navigation — skip guard
            if (state.uri.path == AppRoutes.splash) return null;
            return guardManager.applyAuthGuard(context, state);
          }
        : null,
    routes: [
      // Root route — redirect to splash
      GoRoute(
        path: AppRoutes.root,
        name: 'root',
        redirect: (context, state) => AppRoutes.splash,
      ),

      // Splash
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => pages.splash(),
      ),

      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => pages.login(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => pages.register(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => pages.forgotPassword(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'reset-password',
        builder: (context, state) =>
            pages.resetPassword(state.uri.queryParameters['token'] ?? ''),
      ),
      // Main navigation
      GoRoute(
        path: AppRoutes.main,
        name: 'main',
        builder: (context, state) => pages.main(),
      ),
      GoRoute(
        path: AppRoutes.search,
        name: 'search',
        builder: (context, state) => pages.search(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications',
        builder: (context, state) => pages.notifications(),
      ),

      // Home route redirects to main navigation shell
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        redirect: (context, state) => AppRoutes.main,
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => pages.profile(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => pages.settings(),
      ),
      GoRoute(
        path: AppRoutes.entitlements,
        name: 'entitlements',
        builder: (context, state) => pages.entitlements(),
      ),
      GoRoute(
        path: AppRoutes.support,
        name: 'support',
        builder: (context, state) => pages.support(),
      ),
      GoRoute(
        path: AppRoutes.vouchers,
        name: 'vouchers',
        builder: (context, state) => pages.vouchers(),
      ),
      if (kDebugMode)
        GoRoute(
          path: AppRoutes.debugTools,
          name: 'debug-tools',
          builder: (context, state) => pages.debugTools(),
        ),

      // Orders
      GoRoute(
        path: AppRoutes.orders,
        name: 'orders',
        builder: (context, state) => pages.orders(),
        routes: [
          GoRoute(
            path: ':orderId',
            name: 'order-details',
            builder: (context, state) {
              final orderId = parsePositiveRouteId(
                state.pathParameters['orderId'],
              );
              return orderId == null
                  ? pages.notFound()
                  : pages.orderDetail(orderId);
            },
            routes: [
              GoRoute(
                path: 'track',
                name: 'track-order',
                builder: (context, state) {
                  final orderId = parsePositiveRouteId(
                    state.pathParameters['orderId'],
                  );
                  return orderId == null
                      ? pages.notFound()
                      : pages.orderDetail(orderId);
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.refundHistory,
        name: 'refund-history',
        builder: (context, state) => pages.refundHistory(),
      ),

      // Restaurants
      GoRoute(
        path: AppRoutes.restaurants,
        name: 'restaurants',
        builder: (context, state) => pages.restaurants(),
        routes: [
          GoRoute(
            path: ':restaurantId',
            name: 'restaurant-details',
            builder: (context, state) {
              final restaurantId = parsePositiveRouteId(
                state.pathParameters['restaurantId'],
              );
              return restaurantId == null
                  ? pages.notFound()
                  : pages.restaurantDetail(restaurantId);
            },
          ),
        ],
      ),

      // Cart & checkout
      GoRoute(
        path: AppRoutes.cart,
        name: 'cart',
        builder: (context, state) => pages.cart(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        name: 'checkout',
        builder: (context, state) => pages.checkout(),
      ),
      GoRoute(
        path: AppRoutes.orderConfirmation,
        name: 'order-confirmation',
        builder: (context, state) => pages.orderConfirmation(),
      ),
      GoRoute(
        path: AppRoutes.livestreamViewer,
        name: 'livestream-viewer',
        builder: (context, state) {
          final livestreamId = state.pathParameters['livestreamId'] ?? '';
          return _livestreamUuid.hasMatch(livestreamId)
              ? pages.livestreamViewer(livestreamId)
              : pages.notFound();
        },
      ),

      // Address management
      GoRoute(
        path: AppRoutes.addressList,
        name: 'address-list',
        builder: (context, state) {
          final extra = state.extra;
          final legacySelectMode =
              state.uri.queryParameters['selectMode'] == 'true' ||
              state.extra == true ||
              (extra is Map && extra['selectMode'] == true);
          final contextValue =
              state.uri.queryParameters['context'] ??
              (extra is Map ? extra['context']?.toString() : null);
          final selectionContext = switch (contextValue) {
            'home' => AddressListContext.home,
            'checkout' => AddressListContext.checkout,
            _ => AddressListContext.management,
          };
          return pages.addressList(
            selectionContext: legacySelectMode
                ? AddressListContext.home
                : selectionContext,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.addAddress,
        name: 'add-address',
        builder: (context, state) => pages.addAddress(),
      ),
      GoRoute(
        path: AppRoutes.editAddress,
        name: 'edit-address',
        builder: (context, state) {
          final address = state.extra is UserAddressEntity
              ? state.extra! as UserAddressEntity
              : null;
          final addressId = parsePositiveRouteId(
            state.uri.queryParameters['addressId'],
          );
          return pages.editAddress(address, addressId: addressId);
        },
      ),

      // 404
      GoRoute(
        path: AppRoutes.notFound,
        name: 'not-found',
        builder: (context, state) => pages.notFound(),
      ),
    ],
    errorBuilder: (context, state) => pages.error(),
  );
}

int? parsePositiveRouteId(String? rawValue) {
  final value = int.tryParse(rawValue ?? '');
  return value != null && value > 0 ? value : null;
}

/// Navigation extension for [GoRouter] — named-route shortcuts.
extension GoRouterExtension on GoRouter {
  void pushLogin() => pushNamed('login');
  void pushRegister() => pushNamed('register');
  void pushForgotPassword() => pushNamed('forgot-password');
  void pushResetPassword(String token) =>
      pushNamed('reset-password', queryParameters: {'token': token});
  void pushHome() => pushNamed('home');
  void pushProfile() => pushNamed('profile');
  void pushSettings() => pushNamed('settings');
  void pushEntitlements() => pushNamed('entitlements');
  void pushVouchers() => pushNamed('vouchers');
  void pushSupport() => pushNamed('support');
  void pushDebugTools() => pushNamed('debug-tools');
  void pushOrders() => pushNamed('orders');
  void pushRefundHistory() => pushNamed('refund-history');
  void pushRestaurants() => pushNamed('restaurants');
  void pushCart() => pushNamed('cart');

  void pushOrderDetails(String orderId) =>
      pushNamed('order-details', pathParameters: {'orderId': orderId});

  void pushRestaurantDetails(String restaurantId) => pushNamed(
    'restaurant-details',
    pathParameters: {'restaurantId': restaurantId},
  );

  void pushLivestream(String livestreamId) => pushNamed(
    'livestream-viewer',
    pathParameters: {'livestreamId': livestreamId},
  );

  void pushAddressList() => pushNamed('address-list');
  void pushAddAddress() => pushNamed('add-address');
  void pushEditAddress(UserAddressEntity address) =>
      pushNamed('edit-address', extra: address);
}
