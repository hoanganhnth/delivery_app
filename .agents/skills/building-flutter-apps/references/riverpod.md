# Skill: Riverpod Generator

> Use when: Creating providers, state management, notifiers

---

## 🎯 Khi nào dùng gì?

### ✅ Dùng **FutureOr + Family Provider** khi:
- **Dữ liệu đơn giản**: Chỉ cần fetch data, không có logic phức tạp
- **Một lần fetch**: Không cần refresh/reload nhiều lần
- **Không có state phức tạp**: Không cần track loading/error riêng
- **VD**: Chi tiết đơn hàng, thông tin user, thông tin nhà hàng theo ID

```dart
@riverpod
class RestaurantDetail extends _$RestaurantDetail {
  @override
  FutureOr<RestaurantEntity?> build(String id) async {
    final repository = ref.watch(restaurantRepositoryProvider);
    final result = await repository.getById(id);
    return result.fold((f) => throw f, (entity) => entity);
  }
}
// Usage: ref.watch(restaurantDetailProvider(restaurantId))
// Riverpod tự động handle loading/error states
```

### ✅ Dùng **State Class + Notifier** khi:
- **Logic phức tạp**: Nhiều actions (load/refresh/filter/search)
- **Multiple loading states**: Login loading, register loading riêng biệt
- **State phức tạp**: Cần track nhiều trạng thái (isLoading, items, filters, failure)
- **Side effects**: Cần trigger navigation, show toast sau action
- **VD**: Danh sách nhà hàng (filter/sort/search), Auth (login/register/logout)

```dart
@riverpod
class RestaurantsNotifier extends _$RestaurantsNotifier {
  @override
  RestaurantsState build() => const RestaurantsState();
  
  Future<void> loadRestaurants() async { /* ... */ }
  Future<void> searchRestaurants(String query) async { /* ... */ }
  void filterByCategory(String category) { /* ... */ }
}
// Usage: ref.watch(restaurantsNotifierProvider)
// Bạn tự handle tất cả states
```

---

## Pattern: Notifier with Generator

```dart
// feature_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'feature_notifier.g.dart';

@riverpod
class FeatureNotifier extends _$FeatureNotifier {
  late final GetFeatureUseCase _useCase;

  @override
  FeatureState build() {
    _useCase = ref.read(getFeatureUseCaseProvider);
    return const FeatureState();
  }

  Future<void> loadItems() async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    
    final result = await _useCase(NoParams());
    
    // BẮT BUỘC: Check mounted sau khi await
    if (!ref.mounted) return;
    
    state = result.fold(
      (failure) => state.copyWith(isLoading: false, failure: failure),
      (items) => state.copyWith(isLoading: false, items: items),
    );
  }
}
```

## Pattern: Dependency Providers

```dart
// feature_providers.dart
part 'feature_providers.g.dart';

@riverpod
FeatureApiService featureApiService(Ref ref) {
  return FeatureApiService(ref.watch(authenticatedDioProvider));
}

@riverpod
FeatureRemoteDataSource featureRemoteDataSource(Ref ref) {
  return FeatureRemoteDataSourceImpl(ref.watch(featureApiServiceProvider));
}

@riverpod
FeatureRepository featureRepository(Ref ref) {
  return FeatureRepositoryImpl(ref.watch(featureRemoteDataSourceProvider));
}

@riverpod
GetFeatureUseCase getFeatureUseCase(Ref ref) {
  return GetFeatureUseCase(ref.watch(featureRepositoryProvider));
}
```

## Pattern: KeepAlive Providers (Singleton)

> Use when: Global services, repositories, auth state

```dart
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
LoginUseCase loginUseCase(Ref ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
}
```

## Pattern: Family Provider (with params)

> **Ưu tiên dùng** cho: Fetch data đơn giản theo ID/params, không cần state phức tạp

```dart
@riverpod
class FeatureDetail extends _$FeatureDetail {
  @override
  FutureOr<FeatureEntity?> build(String id) async {
    final repository = ref.watch(featureRepositoryProvider);
    final result = await repository.getById(id);
    return result.fold((f) => throw f, (entity) => entity);
  }
}

// Usage: ref.watch(featureDetailProvider(id))
// Riverpod tự động xử lý:
// - AsyncLoading: khi đang fetch
// - AsyncData: khi có data
// - AsyncError: khi có lỗi

// Widget sử dụng:
final detailAsync = ref.watch(featureDetailProvider(id));
return detailAsync.when(
  loading: () => CircularProgressIndicator(),
  error: (err, stack) => Text('Error: $err'),
  data: (entity) => entity == null 
    ? Text('Not found') 
    : FeatureDetailWidget(entity),
);
```

## Pattern: State with Freezed

> **Ưu tiên dùng** cho: State phức tạp với nhiều fields, cần immutability

```dart
// feature_state.dart
@freezed
class FeatureState with _$FeatureState {
  const factory FeatureState({
    @Default(false) bool isLoading,
    @Default([]) List<FeatureEntity> items,
    Failure? failure,
    String? searchQuery,
    FeatureFilter? filter,
  }) = _FeatureState;
}

extension FeatureStateX on FeatureState {
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  bool get isEmpty => items.isEmpty;
  int get itemCount => items.length;
}
```

## Pattern: State without Freezed (Plain Class)

> Use when: Simple state or legacy code

```dart
// auth_state.dart
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final Failure? failure;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.failure,
  });

  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }
}
```

## Screen Usage

```dart
class FeatureScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends ConsumerState<FeatureScreen> {
  @override
  void initState() {
    super.initState();
    // LUÔN LUÔN dùng addPostFrameCallback khi muốn đọc provider ở initState
    // KHÔNG BAO GIỜ được gọi ref.read() trực tiếp trong initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(featureNotifierProvider.notifier).loadItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    // KHUYẾN NGHỊ: Dùng .select() để chỉ rebuild khi state cụ thể thay đổi
    final items = ref.watch(featureNotifierProvider.select((state) => state.items));
    final isLoading = ref.watch(featureNotifierProvider.select((state) => state.isLoading));

    // Side effects
    ref.listen(featureNotifierProvider, (prev, next) {
      if (next.failure != null && (prev == null || prev.failure != next.failure)) {
        context.showErrorToast(next.failure!.message);
      }
    });

    return Scaffold(body: _buildBody(items, isLoading));
  }
}
```

## Key Imports

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'file_name.g.dart';
```
