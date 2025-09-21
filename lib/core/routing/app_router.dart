import 'package:delivery_app/features/home/presentation/pages/home_page.dart';
import 'package:delivery_app/features/orders/presentation/screens/order_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/main/presentation/pages/main_screen.dart';
import '../../features/profile/profile.dart';
import '../../features/settings/settings.dart';
import '../../features/settings/presentation/screens/theme_settings_screen.dart';
import '../../features/orders/orders.dart';
import '../../features/restaurants/restaurants.dart';
import '../../features/cart/cart.dart';
import '../../features/user_address/presentation/screens/address_list_screen.dart';
import '../../features/user_address/presentation/screens/add_edit_address_screen.dart';
import '../../features/user_address/domain/entities/user_address_entity.dart';
import '../presentation/screens/splash_screen.dart';
import '../presentation/screens/error_screens.dart';
// import '../presentation/screens/admin_screen.dart';
import 'app_routes.dart';
import 'router_config.dart';
import 'guard_manager.dart';
import '../services/deep_link_service.dart';

/// Router provider for the entire app
final routerProvider = Provider<GoRouter>((ref) {
  final config = ref.watch(routerConfigProvider);
  final guardManager = GuardManager(ref);

  // Create router
  final router = GoRouter(
    initialLocation: config.initialLocation,
    debugLogDiagnostics: config.debugLogDiagnostics,
    redirect: config.enableRedirects
        ? (context, state) {
            final authState = ref.read(authStateProvider);
            final isAuthenticated = authState.isAuthenticated;

            // List of routes that don't require authentication
            final publicRoutes = [
              AppRoutes.login,
              AppRoutes.register,
              AppRoutes.forgotPassword,
              AppRoutes.splash,
              AppRoutes.root,
            ];

            final currentPath = state.uri.path;
            final isPublicRoute = publicRoutes.contains(currentPath);

            // Don't redirect from splash - let splash controller handle navigation
            if (currentPath == AppRoutes.splash) {
              return null;
            }

            // If user is not authenticated and trying to access protected route
            if (!isAuthenticated && !isPublicRoute) {
              return AppRoutes.login;
            }

            // If user is authenticated and trying to access auth routes, redirect to main
            if (isAuthenticated &&
                (currentPath == AppRoutes.login ||
                    currentPath == AppRoutes.register)) {
              return AppRoutes.main;
            }

            // No redirect needed
            return null;
          }
        : null,
    routes: [
      // Root route - redirect to splash
      GoRoute(
        path: AppRoutes.root,
        name: 'root',
        redirect: (context, state) => AppRoutes.splash,
      ),

      // Splash route
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth routes (with guest guard - redirect if already authenticated)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        redirect: guardManager.applyGuestGuard,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        redirect: guardManager.applyGuestGuard,
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        redirect: guardManager.applyGuestGuard,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Main navigation with bottom nav bar
      GoRoute(
        path: AppRoutes.main,
        name: 'main',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const MainScreen(),
      ),

      // Theme settings route (standalone)
      GoRoute(
        path: AppRoutes.themeSettings,
        name: 'theme-settings',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const ThemeSettingsScreen(),
      ),

      // Main app routes (with auth guard)
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const HomePage(),
        routes: [
          // Nested routes under home (inherit auth guard)
          GoRoute(
            path: 'profile',
            name: 'profile',
            // redirect: guardManager.applyAuthAndOnboarding,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Orders routes (with auth guard)
      GoRoute(
        path: AppRoutes.orders,
        name: 'orders',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const OrdersScreen(),
        routes: [
          GoRoute(
            path: ':orderId',
            name: 'order-details',
            redirect: guardManager.applyAuthGuard,
            builder: (context, state) {
              final orderId = state.pathParameters['orderId']!;
              return OrderDetailScreen(orderId: num.tryParse(orderId) ?? 0);
            },
            routes: [
              GoRoute(
                path: 'track',
                name: 'track-order',
                redirect: guardManager.applyAuthGuard,
                builder: (context, state) {
                  final orderId = state.pathParameters['orderId']!;
                  return TrackOrderScreen(orderId: orderId);
                },
              ),
            ],
          ),
        ],
      ),

      // Restaurants routes (with auth guard)
      GoRoute(
        path: AppRoutes.restaurants,
        name: 'restaurants',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const AllRestaurantsScreen(),
        routes: [
          GoRoute(
            path: ':restaurantId',
            name: 'restaurant-details',
            redirect: guardManager.applyAuthGuard,
            builder: (context, state) {
              final restaurantId =
                  num.tryParse(state.pathParameters['restaurantId']!) ?? 1;
              return RestaurantDetailScreen(restaurantId: restaurantId);
            },
            routes: [
              GoRoute(
                path: 'menu',
                name: 'menu',
                redirect: guardManager.applyAuthGuard,
                builder: (context, state) {
                  final restaurantId = state.pathParameters['restaurantId']!;
                  return MenuScreen(restaurantId: restaurantId);
                },
              ),
            ],
          ),
        ],
      ),

      // Cart and checkout routes (with auth guard)
      GoRoute(
        path: AppRoutes.cart,
        name: 'cart',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const CartScreen(),
      ),

      GoRoute(
        path: AppRoutes.checkout,
        name: 'checkout',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const CheckoutScreen(),
      ),

      GoRoute(
        path: AppRoutes.payment,
        name: 'payment',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const PaymentScreen(),
      ),

      GoRoute(
        path: AppRoutes.orderConfirmation,
        name: 'order-confirmation',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const OrderConfirmationScreen(),
      ),

      // Address management routes (with auth guard)
      GoRoute(
        path: AppRoutes.addressList,
        name: 'address-list',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const AddressListScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.addAddress,
        name: 'add-address',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const AddEditAddressScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.editAddress,
        name: 'edit-address',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) {
          final address = state.extra as UserAddressEntity?;
          return AddEditAddressScreen(address: address);
        },
      ),

      // Admin routes (with admin guard)
      // GoRoute(
      //   path: AppRoutes.admin,
      //   name: 'admin',
      //   redirect: guardManager.applyAuthAndAdmin,
      //   builder: (context, state) => const AdminScreen(),
      // ),

      // Error routes
      GoRoute(
        path: AppRoutes.notFound,
        name: 'not-found',
        builder: (context, state) => const NotFoundScreen(),
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => ErrorScreen(error: state.error),
  );

  // Initialize deep links with router
  DeepLinkService.initialize(router);

  return router;
});

/// Extension for easy navigation
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

  // Address management navigation
  void pushAddressList() => pushNamed('address-list');
  void pushAddAddress() => pushNamed('add-address');
  void pushEditAddress(UserAddressEntity address) => 
      pushNamed('edit-address', extra: address);
}
