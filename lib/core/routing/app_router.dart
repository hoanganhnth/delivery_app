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
import 'package:delivery_app/features/support/presentation/screens/support_chat_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:delivery_app/features/auth/presentation/screens/login_screen.dart';
import 'package:delivery_app/features/auth/presentation/screens/register_screen.dart';
import 'package:delivery_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:delivery_app/features/main/presentation/pages/main_screen.dart';
import 'package:delivery_app/features/profile/profile.dart';
import 'package:delivery_app/features/settings/settings.dart';
import 'package:delivery_app/features/settings/presentation/screens/theme_settings_screen.dart';
import 'package:delivery_app/features/orders/orders.dart';
import 'package:delivery_app/features/restaurants/restaurants.dart';
import 'package:delivery_app/features/cart/cart.dart';
import 'package:delivery_app/features/livestream/presentation/screens/all_livestreams_screen.dart';
import 'package:delivery_app/features/livestream/presentation/screens/livestream_detail_screen.dart';
import 'package:delivery_app/features/user_address/presentation/screens/address_list_screen.dart';
import 'package:delivery_app/features/user_address/presentation/screens/add_edit_address_screen.dart';
import 'package:delivery_app/features/user_address/domain/entities/user_address_entity.dart';
import 'package:delivery_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/core/routing/constants/app_routes.dart';
import 'package:delivery_app/core/routing/models/app_router_config.dart';
import 'package:delivery_app/core/routing/models/i_auth_checker.dart';
import 'package:delivery_app/core/routing/guards/guard_manager.dart';

/// Creates the application's [GoRouter].
///
/// - [authNotifier] is used both as `refreshListenable` (reactive) and as
///   [IAuthChecker] (readable state) for [GuardManager]. No duplicate state.
/// - [config] controls initial location, redirect on/off, debug logging, etc.
GoRouter createAppRouter({
  required IAuthNotifier authNotifier,
  required AppRouterConfig config,
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
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Main navigation
      GoRoute(
        path: AppRoutes.main,
        name: 'main',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: AppRoutes.themeSettings,
        name: 'theme-settings',
        builder: (context, state) => const ThemeSettingsScreen(),
      ),

      // Home with nested profile
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Orders
      GoRoute(
        path: AppRoutes.orders,
        name: 'orders',
        builder: (context, state) => const OrdersScreen(),
        routes: [
          GoRoute(
            path: ':orderId',
            name: 'order-details',
            builder: (context, state) {
              final orderId = state.pathParameters['orderId']!;
              return OrderDetailScreen(orderId: num.tryParse(orderId) ?? 0);
            },
            routes: [
              GoRoute(
                path: 'track',
                name: 'track-order',
                builder: (context, state) {
                  final orderId = state.pathParameters['orderId']!;
                  return TrackOrderScreen(orderId: num.tryParse(orderId) ?? 0);
                },
              ),
            ],
          ),
        ],
      ),

      // Restaurants
      GoRoute(
        path: AppRoutes.restaurants,
        name: 'restaurants',
        builder: (context, state) => const AllRestaurantsScreen(),
        routes: [
          GoRoute(
            path: ':restaurantId',
            name: 'restaurant-details',
            builder: (context, state) {
              final restaurantId =
                  num.tryParse(state.pathParameters['restaurantId']!) ?? 1;
              return RestaurantDetailScreen(restaurantId: restaurantId);
            },
            routes: [
              GoRoute(
                path: 'menu',
                name: 'menu',
                builder: (context, state) {
                  final restaurantId = state.pathParameters['restaurantId']!;
                  return MenuScreen(restaurantId: restaurantId);
                },
              ),
            ],
          ),
        ],
      ),

      // Cart & checkout
      GoRoute(
        path: AppRoutes.cart,
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        name: 'checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: AppRoutes.payment,
        name: 'payment',
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: AppRoutes.orderConfirmation,
        name: 'order-confirmation',
        builder: (context, state) => const OrderConfirmationScreen(),
      ),

      // Livestream
      GoRoute(
        path: '/livestreams',
        name: 'livestreams',
        builder: (context, state) => const AllLivestreamsScreen(),
      ),
      GoRoute(
        path: '/livestream-detail/:id',
        name: 'livestream-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return LivestreamDetailScreen(livestreamId: id);
        },
      ),

      // Address management
      GoRoute(
        path: AppRoutes.addressList,
        name: 'address-list',
        builder: (context, state) => const AddressListScreen(),
      ),
      GoRoute(
        path: AppRoutes.addAddress,
        name: 'add-address',
        builder: (context, state) => const AddEditAddressScreen(),
      ),
      GoRoute(
        path: AppRoutes.editAddress,
        name: 'edit-address',
        builder: (context, state) {
          final address = state.extra as UserAddressEntity?;
          return AddEditAddressScreen(address: address);
        },
      ),

      // Support
      GoRoute(
        path: AppRoutes.supportChat,
        name: 'support-chat',
        builder: (context, state) => const SupportChatScreen(),
      ),

      // 404
      GoRoute(
        path: AppRoutes.notFound,
        name: 'not-found',
        builder: (context, state) => const NotFoundScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );
}

/// Navigation extension for [GoRouter] — named-route shortcuts.
extension GoRouterExtension on GoRouter {
  void pushLogin() => pushNamed('login');
  void pushRegister() => pushNamed('register');
  void pushHome() => pushNamed('home');
  void pushProfile() => pushNamed('profile');
  void pushSettings() => pushNamed('settings');
  void pushOrders() => pushNamed('orders');
  void pushRestaurants() => pushNamed('restaurants');
  void pushCart() => pushNamed('cart');

  void pushOrderDetails(String orderId) =>
      pushNamed('order-details', pathParameters: {'orderId': orderId});

  void pushRestaurantDetails(String restaurantId) => pushNamed(
        'restaurant-details',
        pathParameters: {'restaurantId': restaurantId},
      );

  void pushAddressList() => pushNamed('address-list');
  void pushAddAddress() => pushNamed('add-address');
  void pushEditAddress(UserAddressEntity address) =>
      pushNamed('edit-address', extra: address);
}
