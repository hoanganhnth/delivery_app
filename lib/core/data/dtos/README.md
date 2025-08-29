# DTO Response Format

Tất cả các response từ API sẽ có format chuẩn:

```json
{
  "status": "success" | "error",
  "message": "Thông báo mô tả",
  "data": { ... } | null
}
```

## BaseResponseDto

`BaseResponseDto<T>` là class generic để wrap tất cả response từ API.

### Cách sử dụng:

#### 1. Tạo Data DTO trước:

```dart
@JsonSerializable()
class UserDataDto {
  final String id;
  final String email;
  final String? name;

  UserDataDto({
    required this.id,
    required this.email,
    this.name,
  });

  factory UserDataDto.fromJson(Map<String, dynamic> json) =>
      _$UserDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataDtoToJson(this);
}
```

#### 2. Tạo Response DTO bằng typedef:

```dart
typedef UserResponseDto = BaseResponseDto<UserDataDto>;
typedef UsersListResponseDto = BaseResponseDto<List<UserDataDto>>;
```

#### 3. API Service chỉ trả về raw data:

```dart
@RestApi()
abstract class UserApiService {
  @GET('/users/{id}')
  Future<Map<String, dynamic>> getUser(@Path() String id);
}

// DataSource chỉ trả về raw data, không parse
abstract class UserRemoteDataSource {
  Future<Either<Exception, Map<String, dynamic>>> getUser(String id);
}

// Implementation:
Future<Either<Exception, Map<String, dynamic>>> getUser(String id) async {
  try {
    final responseData = await _apiService.getUser(id);
    return right(responseData);
  } catch (e) {
    return left(ServerException(e.toString()));
  }
}
```

#### 4. Parse trong Repository:

```dart
Future<Either<Failure, UserEntity>> getUser(String id) async {
  final result = await remoteDataSource.getUser(id);

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
}
```

## Các loại Response DTO đã có:

### Auth Feature:
- `AuthResponseDto` - Response cho login/register
- `RefreshTokenResponseDto` - Response cho refresh token

### Restaurants Feature:
- `RestaurantResponseDto` - Single restaurant
- `RestaurantsListResponseDto` - List of restaurants

### Orders Feature:
- `OrderResponseDto` - Single order
- `OrdersListResponseDto` - List of orders
- `OrderCreationResponseDto` - Order creation response

### Simple Response:
- `SimpleResponseDto` - Cho response chỉ có status và message, không có data

## Lưu ý:

1. **Luôn check `isSuccess`** trước khi sử dụng data
2. **Check `data != null`** trước khi access data
3. **Sử dụng `message`** để hiển thị thông báo cho user
4. **API service methods** nên return `Map<String, dynamic>` thay vì DTO trực tiếp
5. **DataSource** chỉ trả về raw data, không parse JSON
6. **Repository** thực hiện việc parse JSON và handle errors
7. **Separation of concerns** - mỗi layer có trách nhiệm riêng

## Ví dụ Response từ API:

### Success Response:
```json
{
  "status": "success",
  "message": "User retrieved successfully",
  "data": {
    "id": "123",
    "email": "user@example.com",
    "name": "John Doe"
  }
}
```

### Error Response:
```json
{
  "status": "error",
  "message": "User not found",
  "data": null
}
```

### List Response:
```json
{
  "status": "success",
  "message": "Users retrieved successfully",
  "data": [
    {
      "id": "123",
      "email": "user1@example.com",
      "name": "John Doe"
    },
    {
      "id": "456",
      "email": "user2@example.com",
      "name": "Jane Smith"
    }
  ]
}
```
