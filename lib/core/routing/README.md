# Clean GoRouter Setup

This directory contains a clean, scalable GoRouter setup for the Delivery App.

## Architecture

### Files Structure

```
routing/
├── app_router.dart          # Main router configuration
├── app_routes.dart          # Route constants and path helpers
├── navigation_helper.dart   # Navigation utility functions
├── route_guards.dart        # Authentication and authorization guards
├── router_config.dart       # Router configuration providers
├── routing.dart            # Barrel file for exports
└── README.md               # This file
```

### Core Components

#### 1. App Routes (`app_routes.dart`)
- Contains all route path constants
- Helper methods for dynamic routes
- Centralized route management

#### 2. App Router (`app_router.dart`)
- Main GoRouter configuration
- Route definitions with nested routes
- Authentication redirect logic
- Error handling

#### 3. Navigation Helper (`navigation_helper.dart`)
- Utility functions for easy navigation
- Extension methods on BuildContext
- Type-safe navigation methods

#### 4. Route Guards (`route_guards.dart`)
- Authentication guards
- Role-based access control
- Redirect logic for protected routes

## Usage

### Basic Navigation

```dart
import 'package:delivery_app/core/routing/routing.dart';

// Using extension methods
context.goToHome();
context.goToLogin();
context.goToOrderDetails('order123');

// Using navigation helper
NavigationHelper.goToRestaurants(context);
NavigationHelper.pushProfile(context);

// Using GoRouter directly
context.go(AppRoutes.home);
context.push(AppRoutes.cart);
```

### Route Parameters

```dart
// Navigate to order details
context.goToOrderDetails('ORD123');

// Navigate to restaurant menu
context.goToMenu('restaurant456');

// Using path parameters
context.go('/orders/ORD123');
context.go('/restaurants/restaurant456/menu');
```

### Authentication Flow

The router automatically handles authentication:

- **Unauthenticated users** accessing protected routes → redirected to login
- **Authenticated users** accessing auth routes → redirected to home
- **Public routes** (login, register) → accessible to all

### Protected Routes

All routes except these are protected:
- `/` (root)
- `/login`
- `/register`
- `/forgot-password`
- `/splash`

### Nested Routes

The router supports nested routes:

```
/home
  ├── /home/profile
  └── /home/settings

/orders
  └── /orders/:orderId
      └── /orders/:orderId/track

/restaurants
  └── /restaurants/:restaurantId
      └── /restaurants/:restaurantId/menu
```

## Configuration

### Router Config

Customize router behavior using `RouterConfig`:

```dart
// Development config
final devConfig = RouterConfig(
  debugLogDiagnostics: true,
  initialLocation: '/',
  enableRedirects: true,
);

// Production config
final prodConfig = RouterConfig(
  debugLogDiagnostics: false,
  initialLocation: '/',
  enableRedirects: true,
);
```

### Custom Guards

Add custom route guards:

```dart
class AdminGuard {
  static String? redirectLogic(BuildContext context, GoRouterState state, WidgetRef ref) {
    final user = ref.read(authStateProvider).user;
    
    if (user?.role != 'admin') {
      return AppRoutes.home;
    }
    
    return null;
  }
}
```

## Error Handling

The router includes comprehensive error handling:

- **404 errors** → `NotFoundScreen`
- **Navigation errors** → `ErrorScreen`
- **Custom error pages** for different error types

## Deep Linking

The router supports deep linking out of the box:

```
myapp://orders/ORD123
myapp://restaurants/rest456/menu
myapp://profile
```

## Testing

Mock the router for testing:

```dart
testWidgets('Navigation test', (tester) async {
  final mockRouter = MockGoRouter();
  
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        routerProvider.overrideWith((ref) => mockRouter),
      ],
      child: MyApp(),
    ),
  );
  
  // Test navigation
  await tester.tap(find.text('Go to Orders'));
  verify(mockRouter.go('/orders')).called(1);
});
```

## Best Practices

1. **Use route constants** from `AppRoutes` instead of hardcoded strings
2. **Use navigation helper methods** for type safety
3. **Handle navigation errors** gracefully
4. **Test navigation flows** in your widgets
5. **Use nested routes** for logical grouping
6. **Implement proper guards** for protected routes

## Examples

### Complete Navigation Example

```dart
class OrdersWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.goToOrders(),
          child: Text('View All Orders'),
        ),
        ElevatedButton(
          onPressed: () => context.goToOrderDetails('ORD123'),
          child: Text('View Order Details'),
        ),
        ElevatedButton(
          onPressed: () => NavigationHelper.pushCart(context),
          child: Text('Open Cart'),
        ),
      ],
    );
  }
}
```

### Custom Route with Parameters

```dart
// Add to app_router.dart
GoRoute(
  path: '/custom/:id/:action',
  name: 'custom-action',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    final action = state.pathParameters['action']!;
    return CustomScreen(id: id, action: action);
  },
),

// Usage
context.pushNamed(
  'custom-action',
  pathParameters: {
    'id': 'item123',
    'action': 'edit',
  },
);
```

This routing system provides a clean, scalable foundation for navigation in the Delivery App.
