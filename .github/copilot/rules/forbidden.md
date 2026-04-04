# Rules: Forbidden Patterns

## ❌ NEVER DO

### Riverpod
```dart
// ❌ Manual provider
final myProvider = StateNotifierProvider<MyNotifier, MyState>((ref) => ...);

// ✅ Use generator
@riverpod
class MyNotifier extends _$MyNotifier { ... }
```

### Types
```dart
// ❌ Dynamic type
Widget _buildList(dynamic state) { ... }

// ✅ Type-safe
Widget _buildList(FeatureState state) { ... }
```

### Colors
```dart
// ❌ Hardcoded color
Container(color: Color(0xFFF49D25))

// ✅ Theme color
Container(color: context.colors.primary)
```

### Context after await
```dart
// ❌ Context after async gap
Future<void> onTap() async {
  await doSomething();
  context.go('/home'); // WRONG!
}

// ✅ Use ref.listen for navigation
ref.listen(provider, (prev, next) {
  if (next.shouldNavigate) {
    context.go('/home');
  }
});
```

### Either in DataSource
```dart
// ❌ Either in datasource
Future<Either<Failure, T>> getItems() async { ... }

// ✅ Throw exception, let repository handle
Future<BaseResponseDto<T>> getItems() async {
  try { ... }
  catch (e) { throw ... }
}
```

### Skip Layers
```dart
// ❌ UI → Repository (skip UseCase)
final repo = ref.read(repositoryProvider);
await repo.getItems();

// ✅ UI → UseCase → Repository
final useCase = ref.read(useCaseProvider);
await useCase(params);
```

### Public DataSource Fields
```dart
// ❌ Public field
class DataSourceImpl {
  final ApiService apiService; // WRONG
}

// ✅ Private field
class DataSourceImpl {
  final ApiService _apiService; // CORRECT
}
```

### State Mutation
```dart
// ❌ Direct mutation
state.items.add(item);

// ✅ copyWith
state = state.copyWith(items: [...state.items, item]);
```
