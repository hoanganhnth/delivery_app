# Navigation System với Google Nav Bar

## Tổng quan
Hệ thống navigation này cho phép bạn chuyển đổi giữa các tab từ bất kỳ màn hình nào trong app mà không cần phải ở MainScreen.

## Cách sử dụng

### 1. Chuyển tab từ bất kỳ ConsumerWidget nào

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main/presentation/utils/navigation_utils.dart';
import '../main/presentation/providers/navigation_provider.dart';

class YourWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // Cách 1: Sử dụng NavigationUtils (khuyến nghị)
        NavigationUtils.goToCart(ref);
        
        // Cách 2: Sử dụng enum
        NavigationUtils.goToTab(ref, AppTab.restaurants);
        
        // Cách 3: Sử dụng index
        NavigationUtils.goToTabByIndex(ref, 2);
      },
      child: Text('Go to Cart'),
    );
  }
}
```

### 2. Sử dụng NavigationController

```dart
class YourWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationController = ref.read(navigationControllerProvider);
    
    return ElevatedButton(
      onPressed: () {
        navigationController.goToCart();
      },
      child: Text('Go to Cart'),
    );
  }
}
```

### 3. Kiểm tra tab hiện tại

```dart
// Lấy tab hiện tại
int currentTab = NavigationUtils.getCurrentTab(ref);

// Kiểm tra có phải tab cụ thể không
bool isCartTab = NavigationUtils.isCurrentTab(ref, AppTab.cart);

// Watch tab hiện tại để rebuild widget khi thay đổi
int selectedTab = ref.watch(selectedTabProvider);
```

## Các tab có sẵn

- **Home** (index: 0): `AppTab.home`
- **Restaurants** (index: 1): `AppTab.restaurants`
- **Cart** (index: 2): `AppTab.cart`
- **Orders** (index: 3): `AppTab.orders`
- **Profile** (index: 4): `AppTab.profile`

## Functions có sẵn trong NavigationUtils

- `goToHome(ref)` - Chuyển đến tab Home
- `goToRestaurants(ref)` - Chuyển đến tab Restaurants
- `goToCart(ref)` - Chuyển đến tab Cart
- `goToOrders(ref)` - Chuyển đến tab Orders
- `goToProfile(ref)` - Chuyển đến tab Profile
- `goToTab(ref, AppTab)` - Chuyển đến tab bằng enum
- `goToTabByIndex(ref, int)` - Chuyển đến tab bằng index
- `getCurrentTab(ref)` - Lấy index tab hiện tại
- `isCurrentTab(ref, AppTab)` - Kiểm tra có phải tab cụ thể không

## Ví dụ thực tế

```dart
// Trong một button ở bất kỳ màn hình nào
ElevatedButton(
  onPressed: () {
    // Chuyển đến cart khi user thêm sản phẩm
    NavigationUtils.goToCart(ref);
  },
  child: Text('Add to Cart & View'),
)

// Chuyển đến orders sau khi đặt hàng thành công
NavigationUtils.goToOrders(ref);

// Chuyển đến profile để cập nhật thông tin
NavigationUtils.goToProfile(ref);
```
