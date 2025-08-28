# Route Guards Implementation

Route guards are now actively used throughout the application to control access to different routes based on user authentication and authorization.

## How Route Guards Work

Route guards are functions that check if a user should be allowed to access a specific route. If not, they redirect the user to an appropriate page.

### Guard Types Implemented

#### 1. **Auth Guard** - Protects authenticated routes
```dart
// Applied to: Home, Orders, Restaurants, Cart, Profile, Settings
redirect: applyAuthGuard,

// Logic:
- If user is NOT authenticated → Redirect to /login
- If user is authenticated and trying to access /login or /register → Redirect to /home
- Otherwise → Allow access
```

#### 2. **Guest Guard** - Protects guest-only routes
```dart
// Applied to: Login, Register, Forgot Password
redirect: applyGuestGuard,

// Logic:
- If user is already authenticated → Redirect to /home
- Otherwise → Allow access (for login/register)
```

#### 3. **Admin Guard** - Protects admin-only routes
```dart
// Applied to: Admin Panel
redirect: applyAuthAndAdminGuards,

// Logic:
- First check authentication (redirect to /login if not authenticated)
- Then check if user email contains 'admin'
- If not admin → Redirect to /home
- Otherwise → Allow access
```

#### 4. **Onboarding Guard** - Ensures user completed onboarding
```dart
// Applied to: Profile (as example)
redirect: applyAuthAndOnboardingGuards,

// Logic:
- First check authentication
- Then check if user has completed onboarding (has name)
- If not completed → Redirect to /profile to complete
- Otherwise → Allow access
```

## Routes and Their Guards

### 🔓 **Public Routes** (No guards)
- `/` (Root - redirects to /home)
- `/splash`
- `/404` and error pages

### 🚪 **Guest-Only Routes** (Guest Guard)
- `/login` - Redirects authenticated users to home
- `/register` - Redirects authenticated users to home  
- `/forgot-password` - Redirects authenticated users to home

### 🔒 **Protected Routes** (Auth Guard)
- `/home` - Requires authentication
- `/orders` - Requires authentication
- `/orders/:orderId` - Requires authentication
- `/orders/:orderId/track` - Requires authentication
- `/restaurants` - Requires authentication
- `/restaurants/:restaurantId` - Requires authentication
- `/restaurants/:restaurantId/menu` - Requires authentication
- `/cart` - Requires authentication
- `/checkout` - Requires authentication
- `/payment` - Requires authentication
- `/order-confirmation` - Requires authentication
- `/settings` - Requires authentication

### 👤 **Profile Routes** (Auth + Onboarding Guard)
- `/profile` - Requires authentication + completed onboarding

### 👑 **Admin Routes** (Auth + Admin Guard)
- `/admin` - Requires authentication + admin role

## Testing Route Guards

### Test as Regular User
1. **Login with regular email**: `user@example.com`
2. **Try to access**: All protected routes work
3. **Try to access admin**: `/admin` → Redirected to `/home`
4. **Try to access auth routes**: `/login` → Redirected to `/home`

### Test as Admin User
1. **Login with admin email**: `admin@example.com`
2. **Try to access**: All routes work including `/admin`
3. **Home screen shows**: Admin Panel card
4. **Admin panel**: Full access to admin features

### Test as Unauthenticated User
1. **Don't login**
2. **Try to access protected routes**: → Redirected to `/login`
3. **Try to access auth routes**: Works normally
4. **After login**: Redirected to originally requested route

## GuardManager Usage

### In Router Configuration
```dart
final routerProvider = Provider<GoRouter>((ref) {
  final guardManager = GuardManager(ref);

  return GoRouter(
    routes: [
      // Auth guard applied to protected routes
      GoRoute(
        path: '/orders',
        name: 'orders',
        redirect: guardManager.applyAuthGuard, // ← GuardManager used
        builder: (context, state) => const OrdersScreen(),
      ),

      // Guest guard applied to auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        redirect: guardManager.applyGuestGuard, // ← GuardManager used
        builder: (context, state) => const LoginScreen(),
      ),

      // Composite guard for admin routes
      GoRoute(
        path: '/admin',
        name: 'admin',
        redirect: guardManager.applyAuthAndAdmin, // ← Multiple guards
        builder: (context, state) => const AdminScreen(),
      ),
    ],
  );
});
```

### In UI Logic
```dart
class SomeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guardManager = ref.watch(guardManagerProvider);
    final userRole = guardManager.getUserRole();

    return Column(
      children: [
        // Show admin button only for admin users
        if (userRole.canAccessAdmin)
          ElevatedButton(
            onPressed: () => context.pushNamed('admin'),
            child: Text('Admin Panel'),
          ),

        // Check specific route access
        if (guardManager.canAccessRoute('/premium-feature'))
          PremiumFeatureWidget(),

        // Role-based UI
        if (userRole.isPremium)
          PremiumBadge(),
      ],
    );
  }
}
```

### Guard Functions
```dart
String? applyAuthGuard(BuildContext context, GoRouterState state) {
  final authState = ref.read(authStateProvider);
  final isAuthenticated = authState.isAuthenticated;
  
  // Check if route is public
  final publicRoutes = ['/login', '/register', '/forgot-password', '/splash', '/'];
  final currentPath = state.uri.path;
  final isPublicRoute = publicRoutes.contains(currentPath);
  
  // Redirect logic
  if (!isAuthenticated && !isPublicRoute) {
    return '/login'; // Redirect to login
  }
  
  if (isAuthenticated && (currentPath == '/login' || currentPath == '/register')) {
    return '/home'; // Redirect authenticated users away from auth pages
  }
  
  return null; // Allow access
}
```

## Benefits of Route Guards

1. **Security**: Prevents unauthorized access to protected routes
2. **User Experience**: Smooth redirects without manual checks
3. **Maintainability**: Centralized access control logic
4. **Flexibility**: Easy to add new guard types
5. **Composability**: Can combine multiple guards
6. **Testability**: Easy to test different user scenarios

## Adding New Guards

### 1. Create Guard Function
```dart
String? applyPremiumGuard(BuildContext context, GoRouterState state) {
  final authState = ref.read(authStateProvider);
  final user = authState.user;
  
  if (user == null) return '/login';
  
  final hasPremium = user.email.contains('premium');
  if (!hasPremium) return '/subscription';
  
  return null;
}
```

### 2. Apply to Routes
```dart
GoRoute(
  path: '/premium-feature',
  redirect: applyPremiumGuard,
  builder: (context, state) => const PremiumFeatureScreen(),
),
```

### 3. Combine with Other Guards
```dart
String? applyAuthAndPremiumGuards(BuildContext context, GoRouterState state) {
  final authRedirect = applyAuthGuard(context, state);
  if (authRedirect != null) return authRedirect;
  
  return applyPremiumGuard(context, state);
}
```

## Real-World Usage Examples

### E-commerce Flow
- **Guest**: Can browse products, but redirected to login for checkout
- **User**: Can access all features except admin panel
- **Admin**: Can access admin panel for managing products/orders

### Subscription App
- **Free User**: Limited features, redirected to subscription for premium
- **Premium User**: Full access to all features
- **Admin**: Can manage users and subscriptions

### Multi-tenant App
- **Tenant User**: Can only access their tenant's data
- **Super Admin**: Can access all tenants' data

Route guards provide a robust, scalable way to control access throughout the application!
