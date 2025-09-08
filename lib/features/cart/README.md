# Cart Feature

A complete shopping cart implementation using Clean Architecture with local persistence.

## Architecture

### Domain Layer (`domain/`)
- **Entities**: Pure Dart classes representing core business objects
  - `CartEntity`: Represents the shopping cart with items and restaurant info
  - `CartItemEntity`: Represents individual items in the cart
  
- **Repository**: Abstract contract for cart data operations
  - `CartRepository`: Defines methods for cart CRUD operations
  
- **Use Cases**: Business logic for cart operations
  - `GetCartUseCase`: Retrieve current cart state
  - `AddToCartUseCase`: Add items to cart with restaurant validation
  - `RemoveFromCartUseCase`: Remove items from cart
  - `UpdateCartItemQuantityUseCase`: Update item quantities
  - `ClearCartUseCase`: Remove all items from cart

### Data Layer (`data/`)
- **Data Sources**: Local storage implementation
  - `CartLocalDataSourceImpl`: Hive-based local persistence
  - Handles cart serialization/deserialization with DTOs
  
- **DTOs**: Data Transfer Objects for serialization
  - `CartDto`: Serializable cart representation
  - `CartItemDto`: Serializable cart item representation
  
- **Repository Implementation**: 
  - `CartRepositoryImpl`: Implements domain repository with data source

### Presentation Layer (`presentation/`)
- **Providers**: Riverpod state management
  - `CartNotifier`: StateNotifier managing cart state
  - Helper providers for computed values (total, count, etc.)
  
- **Screens**: 
  - `CartScreen`: Main cart viewing and editing screen
  
- **Widgets**:
  - `CartItemWidget`: Individual cart item display with quantity controls
  - `CartSummaryWidget`: Order summary with checkout functionality  
  - `CompactCartSummaryWidget`: Compact cart view for navigation
  - `EmptyCartWidget`: Empty state display

## Key Features

- **Local Persistence**: Cart data survives app restarts using Hive
- **Restaurant Validation**: Prevents mixing items from different restaurants
- **Quantity Management**: Increment/decrement item quantities
- **Item Notes**: Support for special instructions per item
- **Real-time Updates**: Reactive UI updates with Riverpod
- **Error Handling**: Functional error handling with Either pattern
- **Clean Architecture**: Separated concerns with dependency injection

## State Management

The cart uses Riverpod StateNotifier for state management with the following structure:

```dart
CartState {
  cart: CartEntity,          // Current cart data
  isLoading: bool,           // Loading state for async operations  
  failure: Failure?          // Error state handling
}
```

## Usage Examples

### Adding Items to Cart
```dart
final cartNotifier = ref.read(cartNotifierProvider.notifier);
await cartNotifier.addItem(CartItemEntity(...));
```

### Watching Cart State
```dart
final cartState = ref.watch(cartNotifierProvider);
final totalAmount = ref.watch(cartTotalAmountProvider);
final itemCount = ref.watch(cartItemsCountProvider);
```

### Checking Restaurant Compatibility
```dart
final canAdd = ref.watch(canAddFromRestaurantProvider(restaurantId));
```

## Dependencies

- **flutter_riverpod**: State management and dependency injection
- **hive**: Local database for cart persistence  
- **freezed**: Code generation for immutable data classes
- **fpdart**: Functional programming utilities for error handling
- **json_annotation**: JSON serialization support

## Data Flow

1. UI triggers action via CartNotifier
2. CartNotifier calls appropriate Use Case
3. Use Case executes business logic and calls Repository  
4. Repository calls Data Source for persistence
5. Result flows back up through layers
6. UI reacts to state changes via Riverpod providers

This architecture ensures:
- Separation of concerns
- Testability at each layer  
- Maintainable and scalable code
- Consistent error handling
- Reactive UI updates
