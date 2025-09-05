## Restaurant Feature Structure

Đã tổ chức lại restaurant feature theo Clean Architecture:

### Domain Layer
- **entities/**
  - `restaurant_entity.dart` - Entity cho restaurant với đầy đủ thông tin
  - `menu_item_entity.dart` - Entity cho menu items
  
- **repositories/**
  - `restaurant_repository.dart` - Abstract repository interface

- **usecases/**
  - `get_restaurants_usecase.dart` - Lấy danh sách restaurants
  - `get_restaurant_by_id_usecase.dart` - Lấy chi tiết restaurant
  - `get_menu_items_usecase.dart` - Lấy menu items
  - `search_restaurants_usecase.dart` - Tìm kiếm restaurants

### Data Layer
- **dtos/**
  - `restaurant_dto.dart` - DTO với freezed và json_serializable
  - `menu_item_dto.dart` - DTO cho menu items

- **datasources/**
  - `restaurant_remote_datasource.dart` - Retrofit API service

- **repositories_impl/**
  - `restaurant_repository_impl.dart` - Implementation của repository

### Presentation Layer
- **pages/**
  - `restaurants_page.dart` - UI cho danh sách restaurants với categories

## Các thay đổi chính:

1. ✅ **Xóa folder không cần thiết**: Đã xóa `catalog` và `restaurant` (singular)
2. ✅ **Sử dụng Clean Architecture**: Domain, Data, Presentation layers
3. ✅ **Freezed entities**: Immutable objects với freezed
4. ✅ **Either<Failure, T>**: Error handling với fpdart
5. ✅ **UseCase pattern**: Kế thừa abstract UseCase class
6. ✅ **Retrofit API**: Type-safe API calls
7. ✅ **UI nâng cao**: Categories, cards, ratings, delivery info

## Cần làm tiếp:

1. **Nâng cấp Dart SDK** lên >=3.8.0 để chạy `build_runner`
2. **Generate files**: Chạy `dart run build_runner build` cho freezed và json_serializable
3. **Provider/Bloc**: Tạo state management cho restaurants
4. **Navigation**: Tích hợp với router để navigate đến restaurant details
