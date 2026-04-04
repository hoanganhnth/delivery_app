# Rules: Error Handling

## Layer-Specific Error Handling

### DataSource Layer → Throws Exception

```dart
// DataSource throws, never returns Either
Future<BaseResponseDto<T>> getItems() async {
  try {
    return await _apiService.getItems();
  } on DioException catch (e) {
    throw ResponseHandler.mapDioExceptionToException(e);
  } catch (e) {
    throw Exception('Unexpected: $e');
  }
}
```

### Repository Layer → Returns Either

```dart
// Repository catches and returns Either
Future<Either<Failure, T>> getItems() async {
  try {
    final response = await _dataSource.getItems();
    if (response.isSuccess && response.data != null) {
      return right(response.data!.toEntity());
    }
    return left(ServerFailure(response.message));
  } on Exception catch (e) {
    return left(mapExceptionToFailure(e));
  }
}
```

### Notifier Layer → Updates State

```dart
// Notifier handles Either and updates state
Future<void> loadItems() async {
  state = state.copyWith(isLoading: true, failure: null);
  
  final result = await _useCase(params);
  
  state = result.fold(
    (failure) => state.copyWith(isLoading: false, failure: failure),
    (items) => state.copyWith(isLoading: false, items: items),
  );
}
```

### UI Layer → Shows Feedback

```dart
// UI listens and shows error
ref.listen(featureNotifierProvider, (prev, next) {
  if (next.failure != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(next.failure!.message)),
    );
  }
});
```

## Failure Types

```dart
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure { ... }
class NetworkFailure extends Failure { ... }
class CacheFailure extends Failure { ... }
class ValidationFailure extends Failure { ... }
class AuthFailure extends Failure { ... }
```

## Logging

```dart
AppLogger.d('Debug info');           // Development
AppLogger.i('Success info');         // Info
AppLogger.w('Warning');              // Warning
AppLogger.e('Error message', error); // Error with stack
```
