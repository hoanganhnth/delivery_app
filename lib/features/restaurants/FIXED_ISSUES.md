# Restaurant Feature - Fixed Issues

## ✅ Đã sửa các lỗi sau:

### 1. **Xóa folder repositories thừa**
- Xóa `/lib/features/restaurants/data/repositories/` 
- Chỉ giữ lại `/lib/features/restaurants/data/repositories_impl/`

### 2. **Sửa lỗi import trong Repository Implementation**
- Thêm import cho DTOs để extension methods `toEntity()` hoạt động
- Import `../dtos/restaurant_dto.dart` và `../dtos/menu_item_dto.dart`

### 3. **Sửa lỗi JSON annotations trong DTOs**
- Xóa `@JsonKey` annotations trong factory constructors của freezed
- Sử dụng tên field trực tiếp thay vì mapping (có thể thêm lại sau nếu cần)

### 4. **Rebuild freezed files**
- Chạy `fvm dart run build_runner build --delete-conflicting-outputs`
- Generate lại các file `.freezed.dart` và `.g.dart`

### 5. **Sửa unused imports**
- Xóa các import không sử dụng trong `restaurants_page.dart`

## ✅ Kết quả:

- ✅ **Domain entities**: Không lỗi
- ✅ **DTOs**: Không lỗi  
- ✅ **Repository**: Không lỗi
- ✅ **DataSource**: Không lỗi
- ✅ **Presentation**: Không lỗi

## 🚀 Restaurant feature hiện tại:

```
restaurants/
├── domain/
│   ├── entities/
│   │   ├── restaurant_entity.dart
│   │   └── menu_item_entity.dart
│   ├── repositories/
│   │   └── restaurant_repository.dart
│   └── usecases/
│       ├── get_restaurants_usecase.dart
│       ├── get_restaurant_by_id_usecase.dart
│       ├── get_menu_items_usecase.dart
│       └── search_restaurants_usecase.dart
├── data/
│   ├── dtos/
│   │   ├── restaurant_dto.dart
│   │   └── menu_item_dto.dart
│   ├── datasources/
│   │   └── restaurant_remote_datasource.dart
│   └── repositories_impl/
│       └── restaurant_repository_impl.dart
└── presentation/
    └── pages/
        └── restaurants_page.dart
```

## 📝 Cần làm tiếp:

1. **Providers/BLoC**: Tạo state management cho restaurants
2. **Navigation**: Tích hợp với router cho restaurant details
3. **API Integration**: Connect với real API endpoints
4. **Error Handling**: UI cho loading/error states
