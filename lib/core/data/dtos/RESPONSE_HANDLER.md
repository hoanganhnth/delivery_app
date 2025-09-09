# ResponseHandler Documentation

## Overview

`ResponseHandler` is a utility class that provides consistent error handling and response processing for all API calls across the application. It eliminates code duplication and ensures uniform error handling patterns.

## Key Features

- **Consistent Error Handling**: All DioExceptions are mapped to consistent Exception format
- **Type Safety**: Generic methods provide type-safe response handling  
- **Code Reduction**: Eliminates boilerplate try-catch blocks in data sources
- **Flexible Transformation**: Support for custom data transformation functions

## Usage Examples

### Basic API Call (Simple Response)
```dart
// Before (with boilerplate)
Future<Either<Exception, List<OrderDto>>> getUserOrders() async {
  try {
    final response = await _apiService.getUserOrders();
    if (response.isSuccess && response.data != null) {
      return right(response.data!);
    } else {
      return left(Exception(response.message));
    }
  } on DioException catch (e) {
    return left(_mapDioExceptionToException(e));
  } catch (e) {
    return left(Exception('Unexpected error: ${e.toString()}'));
  }
}

// After (with ResponseHandler)
Future<Either<Exception, List<OrderDto>>> getUserOrders() async {
  return ResponseHandler.safeApiCallSimple(() => _apiService.getUserOrders());
}
```

### API Call with Data Transformation
```dart
Future<Either<Exception, bool>> cancelOrder(int orderId) async {
  return ResponseHandler.safeApiCallWithResponse(
    () => _apiService.cancelOrder(orderId),
    (data) => data == true,
  );
}
```

### API Call with Custom Logic
```dart
Future<Either<Exception, CustomResult>> complexApiCall() async {
  return ResponseHandler.safeApiCall(() async {
    final response = await _apiService.complexCall();
    // Custom processing logic here
    return processResponse(response);
  });
}
```

## Available Methods

### `safeApiCallSimple<T>`
- **Purpose**: Handle BaseResponseDto<T> responses without transformation
- **Returns**: `Future<Either<Exception, T>>`
- **Use Case**: Most common API calls that return data directly

### `safeApiCallWithResponse<T, R>`
- **Purpose**: Handle BaseResponseDto<T> with custom transformation
- **Returns**: `Future<Either<Exception, R>>`
- **Use Case**: When you need to transform response data before returning

### `safeApiCall<T>`
- **Purpose**: Wrap any async operation with error handling
- **Returns**: `Future<Either<Exception, T>>`
- **Use Case**: Complex API calls that don't follow standard response format

### `handleResponse<T, R>`
- **Purpose**: Process BaseResponseDto with transformation function
- **Returns**: `Either<Exception, R>`
- **Use Case**: When you already have a response and need to process it

### `mapDioExceptionToException`
- **Purpose**: Convert DioException to Exception with consistent message format
- **Returns**: `Exception`
- **Use Case**: Manual exception handling scenarios

## Integration Benefits

1. **Code Consistency**: All data sources follow the same error handling pattern
2. **Maintainability**: Changes to error handling logic only need to be made in one place
3. **Testing**: Easier to test with consistent interfaces
4. **Type Safety**: Generic methods prevent type-related runtime errors
5. **Developer Experience**: Less boilerplate code, focus on business logic

## Best Practices

1. **Use `safeApiCallSimple`** for most API calls
2. **Use `safeApiCallWithResponse`** when you need data transformation
3. **Use `safeApiCall`** for complex scenarios that don't fit standard patterns
4. **Always handle the Either result** in your repository implementations
5. **Keep transformation functions pure** - avoid side effects in transform functions
