# Features Architecture

This directory contains all the features of the Delivery App, organized by feature-based architecture.

## Structure

```
features/
├── auth/                    # Authentication feature
│   ├── data/               # Data layer (repositories, data sources, DTOs)
│   ├── domain/             # Domain layer (entities, use cases, repository interfaces)
│   ├── presentation/       # Presentation layer (screens, providers, widgets)
│   └── auth.dart          # Feature barrel file
├── home/                   # Home feature
│   ├── presentation/
│   │   └── screens/
│   │       └── home_screen.dart
│   └── home.dart          # Feature barrel file
├── profile/                # User profile feature
│   ├── presentation/
│   │   └── screens/
│   │       └── profile_screen.dart
│   └── profile.dart       # Feature barrel file
├── settings/               # App settings feature
│   ├── presentation/
│   │   └── screens/
│   │       └── settings_screen.dart
│   └── settings.dart      # Feature barrel file
├── orders/                 # Orders management feature
│   ├── presentation/
│   │   └── screens/
│   │       ├── orders_screen.dart
│   │       ├── order_details_screen.dart
│   │       └── track_order_screen.dart
│   └── orders.dart        # Feature barrel file
├── restaurants/            # Restaurants and menu feature
│   ├── presentation/
│   │   └── screens/
│   │       ├── restaurants_screen.dart
│   │       ├── restaurant_details_screen.dart
│   │       └── menu_screen.dart
│   └── restaurants.dart   # Feature barrel file
├── cart/                   # Shopping cart and checkout feature
│   ├── presentation/
│   │   └── screens/
│   │       ├── cart_screen.dart
│   │       ├── checkout_screen.dart
│   │       ├── payment_screen.dart
│   │       └── order_confirmation_screen.dart
│   └── cart.dart          # Feature barrel file
└── README.md              # This file
```

## Feature Organization

Each feature follows Clean Architecture principles:

### 1. **Domain Layer** (Business Logic)
- **Entities**: Core business objects
- **Use Cases**: Business logic operations
- **Repository Interfaces**: Contracts for data access

### 2. **Data Layer** (Data Access)
- **Repository Implementations**: Concrete implementations of repository interfaces
- **Data Sources**: Remote (API) and local (database) data sources
- **DTOs**: Data Transfer Objects for API communication
- **Models**: Data models with JSON serialization

### 3. **Presentation Layer** (UI)
- **Screens**: UI screens/pages
- **Widgets**: Reusable UI components
- **Providers**: State management with Riverpod
- **Controllers**: UI logic controllers

## Feature Barrel Files

Each feature has a barrel file (e.g., `auth.dart`, `home.dart`) that exports all public APIs:

```dart
/// Home feature barrel file
library;

// Screens
export 'presentation/screens/home_screen.dart';

// Add other exports as the feature grows:
// export 'domain/entities/home_entity.dart';
// export 'domain/usecases/get_home_data_usecase.dart';
// export 'data/repositories_impl/home_repository_impl.dart';
// export 'presentation/providers/home_providers.dart';
```

## Usage

### Importing Features

```dart
// Import entire feature
import 'package:delivery_app/features/home/home.dart';
import 'package:delivery_app/features/orders/orders.dart';

// Use in router
GoRoute(
  path: '/home',
  builder: (context, state) => const HomeScreen(),
),
```

### Adding New Features

1. **Create feature directory**:
   ```
   features/new_feature/
   ├── data/
   ├── domain/
   ├── presentation/
   └── new_feature.dart
   ```

2. **Implement layers** following Clean Architecture

3. **Create barrel file** to export public APIs

4. **Add routes** to `app_router.dart`

5. **Update navigation** in `app_routes.dart`

## Current Features

### ✅ Implemented Features

1. **Auth** - Complete authentication system with Either pattern
2. **Home** - Main dashboard with feature navigation
3. **Profile** - User profile management
4. **Settings** - App configuration and preferences
5. **Orders** - Order management and tracking
6. **Restaurants** - Restaurant browsing and menu viewing
7. **Cart** - Shopping cart and checkout flow

### 🚧 Planned Features

- **Notifications** - Push notifications and in-app messaging
- **Favorites** - Favorite restaurants and items
- **Reviews** - Restaurant and order reviews
- **Loyalty** - Loyalty points and rewards
- **Support** - Customer support and help
- **Analytics** - User behavior tracking

## Benefits

1. **Modularity**: Each feature is self-contained
2. **Scalability**: Easy to add new features
3. **Maintainability**: Clear separation of concerns
4. **Testability**: Each layer can be tested independently
5. **Team Collaboration**: Different teams can work on different features
6. **Code Reusability**: Shared components across features

## Navigation Integration

Features are integrated with the routing system:

```dart
// In app_router.dart
import '../../features/home/home.dart';
import '../../features/orders/orders.dart';
import '../../features/restaurants/restaurants.dart';

// Routes use feature screens
GoRoute(
  path: '/orders',
  builder: (context, state) => const OrdersScreen(),
),
```

## State Management

Each feature can have its own state management:

```dart
// Feature-specific providers
final homeStateProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

// Cross-feature dependencies
final ordersProvider = Provider<OrdersService>((ref) {
  final authState = ref.watch(authStateProvider); // From auth feature
  return OrdersService(authState.user);
});
```

This architecture provides a clean, scalable foundation for the Delivery App's features.
