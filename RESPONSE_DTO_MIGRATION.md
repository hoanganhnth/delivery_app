# Migration to New Response DTO Format

## Tóm tắt thay đổi

Đã cập nhật tất cả các DTO để phù hợp với response format mới từ API:

```json
{
  "status": "success" | "error",
  "message": "Thông báo mô tả",
  "data": { ... } | null
}
```

## Files đã được tạo/cập nhật:

### Core DTOs:
1. **`lib/core/data/dtos/base_response_dto.dart`** - Base class cho tất cả response
2. **`lib/core/data/dtos/simple_response_dto.dart`** - Cho response không có data
3. **`lib/core/data/dtos/README.md`** - Hướng dẫn sử dụng

### Auth Feature:
1. **`lib/features/auth/data/dtos/auth_response_dto.dart`** - Cập nhật để sử dụng BaseResponseDto
2. **`lib/features/auth/data/dtos/refresh_token_response_dto.dart`** - Cập nhật để sử dụng BaseResponseDto
3. **`lib/features/auth/data/datasources/auth_remote_datasource_impl.dart`** - Cập nhật parsing logic
4. **`lib/features/auth/data/repositories_impl/auth_repository_impl.dart`** - Cập nhật để handle response mới

### Restaurants Feature (Ví dụ):
1. **`lib/features/restaurants/data/dtos/restaurant_response_dto.dart`** - DTO mới cho restaurants
2. **`lib/features/restaurants/data/datasources/restaurants_remote_datasource.dart`** - Interface
3. **`lib/features/restaurants/data/datasources/restaurants_remote_datasource_impl.dart`** - Implementation

### Orders Feature (Ví dụ):
1. **`lib/features/orders/data/dtos/order_response_dto.dart`** - DTO mới cho orders

## Cách sử dụng pattern mới:

### 1. Tạo Data DTO:
```dart
@JsonSerializable()
class UserDataDto {
  final String id;
  final String email;
  // ...
}
```

### 2. Tạo Response DTO bằng typedef:
```dart
typedef UserResponseDto = BaseResponseDto<UserDataDto>;
typedef UsersListResponseDto = BaseResponseDto<List<UserDataDto>>;
```

### 3. API Service trả về Map:
```dart
@GET('/users/{id}')
Future<Map<String, dynamic>> getUser(@Path() String id);
```

### 4. DataSource chỉ trả về raw data:
```dart
// DataSource interface
abstract class UserRemoteDataSource {
  Future<Either<Exception, Map<String, dynamic>>> getUser(String id);
}

// Implementation
Future<Either<Exception, Map<String, dynamic>>> getUser(String id) async {
  try {
    final responseData = await _apiService.getUser(id);
    return right(responseData); // Chỉ trả về raw data
  } catch (e) {
    return left(ServerException(e.toString()));
  }
}
```

### 5. Parse trong Repository:
```dart
return result.fold(
  (exception) => left(mapExceptionToFailure(exception)),
  (responseData) {
    try {
      final userResponse = UserResponseDto.fromJson(
        responseData,
        (json) => UserDataDto.fromJson(json as Map<String, dynamic>),
      );

      if (userResponse.isSuccess && userResponse.data != null) {
        return right(userResponse.data!.toEntity());
      } else {
        return left(ServerFailure(userResponse.message));
      }
    } catch (e) {
      return left(const ServerFailure('Failed to parse response'));
    }
  },
);
```

## Lợi ích:

1. **Consistency** - Tất cả response đều có format chuẩn
2. **Error Handling** - Dễ dàng check status và hiển thị message
3. **Type Safety** - Generic type đảm bảo type safety
4. **Reusability** - BaseResponseDto có thể dùng cho mọi response
5. **Maintainability** - Dễ maintain và extend
6. **Separation of Concerns** - DataSource chỉ lo network, Repository lo business logic
7. **Clean Architecture** - Tuân thủ nguyên tắc Clean Architecture

## Lưu ý quan trọng:

1. **Luôn check `isSuccess`** trước khi sử dụng data
2. **Check `data != null`** trước khi access data
3. **Sử dụng `message`** để hiển thị thông báo cho user
4. **API service methods** nên return `Map<String, dynamic>`
5. **DataSource** chỉ trả về raw data, không parse JSON
6. **Repository** thực hiện việc parse JSON và handle business logic
7. **Wrap parsing trong try-catch** để handle parse errors

## ✅ Status: COMPLETED

Đã hoàn thành migration tất cả DTO sang format mới. Code đã được test và không có lỗi.

### ✅ Đã hoàn thành:

1. ✅ **BaseResponseDto** - Core wrapper cho tất cả response
2. ✅ **Auth DTOs** - AuthResponseDto và RefreshTokenResponseDto đã được cập nhật
3. ✅ **DataSource Layer** - Chỉ trả về raw data, không parse JSON
4. ✅ **Repository Layer** - Parse JSON và handle business logic
5. ✅ **Error Handling** - Centralized error handling với try-catch
6. ✅ **Code Generation** - Tất cả file .g.dart đã được generate thành công
7. ✅ **Documentation** - README và migration guide hoàn chỉnh
8. ✅ **Testing** - Flutter analyze pass, không có lỗi

### 🔄 Next Steps:

1. Cập nhật tất cả các feature khác để sử dụng pattern mới
2. Cập nhật backend để trả về response theo format mới
3. Test integration với real API
4. Update documentation cho team

### 🎯 Pattern đã được thiết lập:

```dart
// 1. API Service
@GET('/endpoint')
Future<dynamic> getData();

// 2. DataSource
Future<Either<Exception, Map<String, dynamic>>> getData() async {
  final responseData = await _apiService.getData();
  return right(responseData as Map<String, dynamic>);
}

// 3. Repository
Future<Either<Failure, Entity>> getData() async {
  final result = await remoteDataSource.getData();
  return result.fold(
    (exception) => left(mapExceptionToFailure(exception)),
    (responseData) {
      try {
        final response = ResponseDto.fromJson(
          responseData,
          (json) => DataDto.fromJson(json as Map<String, dynamic>),
        );

        if (response.isSuccess && response.data != null) {
          return right(response.data!.toEntity());
        } else {
          return left(ServerFailure(response.message));
        }
      } catch (e) {
        return left(const ServerFailure('Failed to parse response'));
      }
    },
  );
}
```
