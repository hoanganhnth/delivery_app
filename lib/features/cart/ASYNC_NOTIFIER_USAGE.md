# Cart AsyncNotifier - Hướng dẫn sử dụng

## Thay đổi từ Notifier sang AsyncNotifier

### Trước (Notifier):
CartState có `isLoading` và `failure` để quản lý trạng thái:
```dart
class CartState {
  final CartEntity cart;
  final bool isLoading;
  final Failure? failure;
}
```

### Sau (AsyncNotifier):
CartState chỉ chứa dữ liệu thuần túy, `loading` và `error` được quản lý bởi `AsyncValue`:
```dart
class CartState {
  final CartEntity cart;  // Chỉ chứa dữ liệu
}
```

---

## Cách sử dụng trong UI

### 1. Watch provider với AsyncValue

```dart
class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsyncValue = ref.watch(cartNotifierProvider);
    
    return cartAsyncValue.when(
      // Khi đang loading
      loading: () => Center(child: CircularProgressIndicator()),
      
      // Khi có lỗi
      error: (error, stack) => Center(
        child: Text('Error: ${error.toString()}'),
      ),
      
      // Khi có dữ liệu
      data: (cartState) => ListView.builder(
        itemCount: cartState.cart.items.length,
        itemBuilder: (context, index) {
          final item = cartState.cart.items[index];
          return CartItemTile(item: item);
        },
      ),
    );
  }
}
```

### 2. Sử dụng whenData cho trường hợp đơn giản

```dart
class CartBadge extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsyncValue = ref.watch(cartNotifierProvider);
    
    return Badge(
      label: Text(
        cartAsyncValue.whenData((cartState) => cartState.totalItems.toString()).value ?? '0'
      ),
      child: Icon(Icons.shopping_cart),
    );
  }
}
```

### 3. Gọi các action methods

```dart
// Add item
ElevatedButton(
  onPressed: () async {
    try {
      await ref.read(cartNotifierProvider.notifier).addItem(item);
      // Success - AsyncValue tự động cập nhật UI
    } catch (e) {
      // Error - AsyncValue tự động hiển thị error state
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể thêm vào giỏ hàng')),
      );
    }
  },
  child: Text('Thêm vào giỏ'),
)
```

### 4. Listen cho side effects (navigation, snackbar...)

```dart
class CartScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // Listen cho error để hiển thị snackbar
    ref.listen<AsyncValue<CartState>>(
      cartNotifierProvider,
      (previous, next) {
        next.whenOrNull(
          error: (error, stack) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Lỗi: ${error.toString()}')),
            );
          },
        );
      },
    );
    
    final cartAsyncValue = ref.watch(cartNotifierProvider);
    
    return cartAsyncValue.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorWidget(error: error),
      data: (cartState) => CartContent(cartState: cartState),
    );
  }
}
```

---

## Lợi ích của AsyncNotifier

### ✅ Ưu điểm:
1. **Tự động quản lý loading/error**: Không cần quản lý `isLoading` và `failure` thủ công
2. **Type-safe**: AsyncValue cung cấp type safety tốt hơn
3. **Dễ test**: Dễ dàng mock AsyncValue trong test
4. **Chuẩn Riverpod**: Đúng best practice của Riverpod
5. **UI clean hơn**: Sử dụng `.when()` thay vì check nhiều điều kiện

### ⚠️ Lưu ý:
1. **Phải handle AsyncValue**: UI phải sử dụng `.when()`, `.whenData()`, hoặc `.whenOrNull()`
2. **Throw exception trong method**: Các method action phải throw exception thay vì trả về failure
3. **Cập nhật UI**: Khi có thay đổi, cần cập nhật tất cả widgets đang sử dụng cart provider

---

## Migration cho các widgets hiện tại

### Trước:
```dart
final cartState = ref.watch(cartNotifierProvider);
if (cartState.isLoading) {
  return CircularProgressIndicator();
}
if (cartState.hasError) {
  return Text('Error: ${cartState.failure?.message}');
}
return Text('Items: ${cartState.totalItems}');
```

### Sau:
```dart
final cartAsyncValue = ref.watch(cartNotifierProvider);
return cartAsyncValue.when(
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => Text('Error: ${error.toString()}'),
  data: (cartState) => Text('Items: ${cartState.totalItems}'),
);
```

---

## Testing với AsyncNotifier

```dart
test('should load cart on initialization', () async {
  final container = ProviderContainer(
    overrides: [
      getCartUseCaseProvider.overrideWithValue(mockGetCartUseCase),
    ],
  );
  
  // Initially loading
  expect(
    container.read(cartNotifierProvider),
    const AsyncValue<CartState>.loading(),
  );
  
  // Wait for async build to complete
  await container.read(cartNotifierProvider.future);
  
  // Should have data
  expect(
    container.read(cartNotifierProvider).hasValue,
    true,
  );
});
```
