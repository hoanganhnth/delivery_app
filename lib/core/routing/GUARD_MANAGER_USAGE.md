# GuardManager Implementation & Usage

GuardManager is now actively used throughout the application for both route protection and UI logic.

## ✅ What GuardManager Provides

### 1. **Route Protection**
```dart
// In app_router.dart
final guardManager = GuardManager(ref);

GoRoute(
  path: '/admin',
  redirect: guardManager.applyAuthAndAdmin, // ← GuardManager used
  builder: (context, state) => const AdminScreen(),
),
```

### 2. **UI Logic Support**
```dart
// In any widget
final guardManager = ref.watch(guardManagerProvider);
final userRole = guardManager.getUserRole();

if (userRole.canAccessAdmin) {
  // Show admin features
}
```

### 3. **Route Access Checking**
```dart
final canAccess = guardManager.canAccessRoute('/admin');
if (canAccess) {
  // Show navigation button
}
```

## 🔧 GuardManager Methods

### Route Guards
- `applyAuthGuard()` - Requires authentication
- `applyGuestGuard()` - Guest-only routes (login/register)
- `applyAdminGuard()` - Admin-only routes
- `applyPremiumGuard()` - Premium user routes
- `applyOnboardingGuard()` - Completed onboarding required

### Composite Guards
- `applyAuthAndAdmin()` - Auth + Admin
- `applyAuthAndOnboarding()` - Auth + Onboarding
- `applyAuthAndPremium()` - Auth + Premium

### UI Helper Methods
- `getUserRole()` - Returns UserRole enum
- `canAccessRoute(String path)` - Check route access
- `hasCompletedOnboarding()` - Check onboarding status

## 🎯 UserRole Enum

```dart
enum UserRole {
  guest,     // Not authenticated
  regular,   // Basic authenticated user
  premium,   // Premium subscriber
  admin,     // Administrator
}

// Extensions for easy checking
userRole.isGuest
userRole.isAuthenticated
userRole.canAccessAdmin
userRole.canAccessPremium
```

## 📱 Real Usage Examples

### 1. Router Implementation
```dart
final routerProvider = Provider<GoRouter>((ref) {
  final guardManager = GuardManager(ref);
  
  return GoRouter(
    routes: [
      // Guest-only routes
      GoRoute(
        path: '/login',
        redirect: guardManager.applyGuestGuard,
        builder: (context, state) => const LoginScreen(),
      ),
      
      // Protected routes
      GoRoute(
        path: '/orders',
        redirect: guardManager.applyAuthGuard,
        builder: (context, state) => const OrdersScreen(),
      ),
      
      // Admin routes
      GoRoute(
        path: '/admin',
        redirect: guardManager.applyAuthAndAdmin,
        builder: (context, state) => const AdminScreen(),
      ),
    ],
  );
});
```

### 2. Home Screen with Role-based UI
```dart
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guardManager = ref.watch(guardManagerProvider);
    final userRole = guardManager.getUserRole();
    
    return Scaffold(
      body: Column(
        children: [
          // Regular features for all authenticated users
          if (userRole.isAuthenticated) ...[
            FeatureCard('Orders', () => context.pushNamed('orders')),
            FeatureCard('Cart', () => context.pushNamed('cart')),
          ],
          
          // Premium features
          if (userRole.canAccessPremium)
            FeatureCard('Premium Features', () => context.pushNamed('premium')),
          
          // Admin features
          if (userRole.canAccessAdmin)
            FeatureCard('Admin Panel', () => context.pushNamed('admin')),
          
          // Guest message
          if (userRole.isGuest)
            Text('Please log in to access features'),
        ],
      ),
    );
  }
}
```

### 3. Conditional Navigation
```dart
class NavigationWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guardManager = ref.watch(guardManagerProvider);
    
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        
        // Show orders tab only if user can access it
        if (guardManager.canAccessRoute('/orders'))
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Orders'),
        
        // Show admin tab only for admin users
        if (guardManager.canAccessRoute('/admin'))
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'Admin'),
      ],
    );
  }
}
```

### 4. Feature Flags
```dart
class FeatureWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guardManager = ref.watch(guardManagerProvider);
    final userRole = guardManager.getUserRole();
    
    return Column(
      children: [
        // Basic features
        BasicFeatureWidget(),
        
        // Premium features with upgrade prompt
        if (userRole.canAccessPremium) 
          PremiumFeatureWidget()
        else
          UpgradePromptWidget(),
        
        // Admin tools
        if (userRole.isAdmin)
          AdminToolsWidget(),
      ],
    );
  }
}
```

## 🧪 Testing Different User Types

### Test as Regular User
```dart
// Login with: user@example.com
// Expected behavior:
// ✅ Can access: home, orders, restaurants, cart, profile, settings
// ❌ Cannot access: admin (redirected to home)
// ❌ Cannot access: login/register (redirected to home)
```

### Test as Admin User
```dart
// Login with: admin@example.com
// Expected behavior:
// ✅ Can access: All routes including admin panel
// ✅ Home screen: Shows Admin Panel card
// ✅ Admin panel: Full admin features
```

### Test as Premium User
```dart
// Login with: premium@example.com
// Expected behavior:
// ✅ Can access: All regular features + premium features
// ❌ Cannot access: admin (unless also admin)
```

### Test as Guest
```dart
// Don't login
// Expected behavior:
// ❌ Cannot access: Any protected route (redirected to login)
// ✅ Can access: login, register, forgot password
```

## 🎯 Benefits of GuardManager

1. **Centralized Logic**: All guard logic in one place
2. **Type Safety**: Strong typing with UserRole enum
3. **Easy Testing**: Simple to test different user scenarios
4. **UI Integration**: Seamless integration with UI logic
5. **Composable**: Easy to combine multiple guards
6. **Maintainable**: Single source of truth for access control

## 🔄 Demo Widget

The `GuardDemoWidget` on the home screen shows:
- Current user role
- Route access permissions
- Onboarding status
- Role-based features

This helps developers understand how GuardManager works in real-time.

## 🚀 Adding New Guards

To add a new guard type:

1. **Add method to GuardManager**:
```dart
String? applyCustomGuard(BuildContext context, GoRouterState state) {
  // Custom logic here
  return null; // or redirect path
}
```

2. **Use in router**:
```dart
GoRoute(
  path: '/custom-feature',
  redirect: guardManager.applyCustomGuard,
  builder: (context, state) => const CustomScreen(),
),
```

3. **Add UI helper if needed**:
```dart
bool canAccessCustomFeature() {
  // Check custom conditions
  return true;
}
```

GuardManager provides a robust, scalable solution for access control throughout the application! 🛡️
