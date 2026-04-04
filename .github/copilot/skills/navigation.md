# Skill: Navigation (GoRouter)

> Use when: Navigating between screens, deep linking

## Navigation Helpers

```dart
// Import
import 'package:delivery_app/core/routing/navigation_helper.dart';

// Push (add to stack)
context.pushToRestaurants();
context.pushToRestaurantDetails(restaurantId);
context.pushCart();
context.pushProfile();
context.pushSettings();

// Go (replace stack)
context.goToLogin();
context.goToHome();

// Pop
context.pop();
Navigator.of(context).pop();
```

## State-Driven Navigation (ref.listen)

```dart
// ✅ CORRECT: Navigate via state change
ref.listen(authNotifierProvider, (prev, next) {
  if (!next.isAuthenticated) {
    context.goToLogin();
  }
});

// ❌ WRONG: Don't use context after await
Future<void> login() async {
  await authService.login();
  context.goToHome(); // DON'T DO THIS
}
```

## Pass Parameters

```dart
// Define route with param
GoRoute(
  path: '/restaurant/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return RestaurantDetailScreen(id: id);
  },
)

// Navigate with param
context.pushToRestaurantDetails('123');
context.go('/restaurant/123');
```

## Query Parameters

```dart
// Navigate with query
context.go('/search?q=pizza&category=food');

// Read query
final query = GoRouterState.of(context).uri.queryParameters['q'];
```

## Navigation Guards

```dart
GoRoute(
  path: '/checkout',
  redirect: (context, state) {
    final isLoggedIn = /* check auth */;
    if (!isLoggedIn) return '/login';
    return null; // no redirect
  },
  builder: (context, state) => CheckoutScreen(),
)
```
