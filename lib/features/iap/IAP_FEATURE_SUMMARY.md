# IAP (In-App Purchase) Feature - Tổng Hợp Chức Năng

## 📋 Tổng Quan
Feature IAP (In-App Purchase) quản lý tất cả các giao dịch mua hàng trong ứng dụng delivery, bao gồm:
- **Subscription (Đăng ký)**: Gói thành viên theo tháng/năm
- **Consumable (Tiêu thụ)**: Voucher, credits, điểm thưởng
- **Non-Consumable (Không tiêu thụ)**: Mở khoá tính năng vĩnh viễn

---

## 🏗️ Kiến Trúc Feature (Clean Architecture)

```
iap/
├── domain/              # Business logic & entities
│   ├── entities/        # Các entity nghiệp vụ
│   ├── repositories/    # Interface repository
│   └── usecases/        # Business logic cho từng hành động
├── data/                # Data layer (API, local storage)
│   ├── datasources/     # API service (Retrofit)
│   ├── dtos/           # Data transfer objects (Freezed)
│   └── repositories_impl/ # Implement repository
└── presentation/        # UI layer (Riverpod state management)
    ├── providers/       # State management (Riverpod)
    ├── screens/         # UI screens
    └── widgets/         # Reusable widgets
```

---

## 📦 3 Loại IAP Chính

### 1. 🎫 **SUBSCRIPTION (Đăng ký gói thành viên)**

#### Các gói đăng ký (`SubscriptionTier`):
- **Free**: Gói miễn phí cơ bản
- **Premium Monthly**: Gói trả phí theo tháng
- **Premium Yearly**: Gói trả phí theo năm (giảm giá 20%)
- **VIP**: Gói cao cấp độc quyền

#### Lợi ích từng gói:
| Gói | Lợi ích |
|-----|---------|
| **Free** | Phí giao hàng chuẩn, hỗ trợ cơ bản, lịch sử đơn hàng giới hạn |
| **Premium Monthly** | Miễn phí giao hàng >$20, hỗ trợ ưu tiên, ưu đãi độc quyền, theo dõi đơn hàng |
| **Premium Yearly** | Miễn phí giao hàng toàn bộ, hỗ trợ 24/7, ưu đãi sớm, tiết kiệm 20% |
| **VIP** | Giao hàng express miễn phí, quản lý tài khoản riêng, nhà hàng VIP, quà sinh nhật |

#### Chức năng:
- ✅ Xem các gói đăng ký có sẵn
- ✅ Mua gói đăng ký
- ✅ Kiểm tra gói đang kích hoạt
- ✅ Khôi phục giao dịch đã mua
- ✅ Tự động gia hạn

---

### 2. 💰 **CONSUMABLE (Sản phẩm tiêu thụ)**

#### Các loại consumable (`ConsumableType`):
- **Discount Voucher (🏷️)**: Giảm giá theo %
- **Cash Voucher (💵)**: Giảm giá cố định
- **Delivery Credits (🚗)**: Credits giao hàng
- **Reward Points (⭐)**: Điểm thưởng tích luỹ
- **Gift Card (🎁)**: Thẻ quà tặng

#### Chức năng:
- ✅ Xem danh sách sản phẩm consumable
- ✅ Mua voucher/credits/points
- ✅ Kiểm tra số dư credits
- ✅ Cộng/trừ credits
- ✅ Xem kho voucher của user
- ✅ Sử dụng voucher
- ✅ Kiểm tra hạn sử dụng voucher

---

### 3. 🔓 **NON-CONSUMABLE (Mở khoá tính năng vĩnh viễn)**

#### Các tính năng unlock (`FeatureType`):
- **Remove Ads**: Loại bỏ quảng cáo vĩnh viễn
- **Dark Theme**: Mở khoá giao diện tối
- **Custom Themes**: 20+ chủ đề tuỳ chỉnh
- **Priority Queue**: Đơn hàng được xử lý ưu tiên
- **Advanced Tracking**: Theo dõi đơn hàng nâng cao với bản đồ
- **Premium Restaurants**: Truy cập nhà hàng cao cấp
- **Meal Planner**: Lập kế hoạch bữa ăn tuần
- **Family Sharing**: Chia sẻ đơn hàng với 5 thành viên
- **Lifetime VIP**: Trạng thái VIP vĩnh viễn

#### Chức năng:
- ✅ Xem danh sách tính năng có thể mở khoá
- ✅ Mua và mở khoá tính năng
- ✅ Kiểm tra tính năng đã mở khoá
- ✅ Lấy danh sách tất cả tính năng đã unlock
- ✅ Khôi phục các tính năng đã mua

---

## 🎯 Use Cases (Nghiệp vụ chính)

### Subscription UseCases:
- `GetSubscriptionTiersUseCase`: Lấy danh sách gói đăng ký
- `PurchaseSubscriptionUseCase`: Mua gói đăng ký
- `GetActiveSubscriptionUseCase`: Kiểm tra gói đang kích hoạt
- `RestorePurchasesUseCase`: Khôi phục giao dịch đã mua

### Consumable UseCases:
- `GetConsumableProductsUseCase`: Lấy danh sách sản phẩm tiêu thụ
- `PurchaseConsumableUseCase`: Mua sản phẩm tiêu thụ
- `GetUserCreditsUseCase`: Lấy số dư credits
- `AddCreditsUseCase`: Cộng credits
- `DeductCreditsUseCase`: Trừ credits

### Non-Consumable UseCases:
- `GetNonConsumableProductsUseCase`: Lấy danh sách tính năng
- `PurchaseNonConsumableUseCase`: Mua tính năng unlock
- `CheckFeatureUnlockedUseCase`: Kiểm tra tính năng đã unlock
- `GetUnlockedFeaturesUseCase`: Lấy danh sách tính năng đã unlock

---

## 🎨 UI Screens

### 1. `IapStoreScreen` (Main Store)
- Tab navigation cho 3 loại IAP
- Tab 1: Subscription
- Tab 2: Consumable (Credits)
- Tab 3: Non-Consumable (Features)

### 2. `SubscriptionScreen`
- Hiển thị gói đăng ký hiện tại (nếu có)
- Danh sách các gói đăng ký với lợi ích chi tiết
- Nút mua đăng ký
- Nút restore purchases

### 3. `ConsumableScreen`
- Hiển thị số dư credits hiện tại
- Danh sách voucher/credits có thể mua
- Lịch sử mua hàng
- Kho voucher của user

### 4. `NonConsumableScreen`
- Danh sách tính năng có thể unlock
- Trạng thái locked/unlocked
- Mô tả chi tiết từng tính năng
- Nút mua và unlock

---

## 🔄 State Management (Riverpod)

### Subscription State:
```dart
SubscriptionState {
  bool isLoading;
  List<SubscriptionEntity> availableTiers;
  SubscriptionEntity? activeSubscription;
  PurchaseEntity? currentPurchase;
  Failure? failure;
  String? successMessage;
}
```

### Consumable State:
```dart
ConsumableState {
  bool isLoading;
  List<ConsumableEntity> products;
  List<PurchaseEntity> purchaseHistory;
  List<ConsumableEntity> vouchers;
  int credits;
  Failure? failure;
  String? successMessage;
}
```

### Non-Consumable State:
```dart
NonConsumableState {
  bool isLoading;
  List<NonConsumableEntity> products;
  List<FeatureType> unlockedFeatures;
  Failure? failure;
  String? successMessage;
}
```

---

## 📊 Data Flow (Clean Architecture)

```
UI (Screen/Widget)
    ↓ user action
Provider (Notifier)
    ↓ read state
UseCase (Business Logic)
    ↓ validate & execute
Repository Interface (Domain)
    ↓ contract
Repository Implementation (Data)
    ↓ call API
Remote DataSource (Retrofit)
    ↓ HTTP request
Backend API
```

---

## 🛠️ Công Nghệ Sử Dụng

- **State Management**: Riverpod (`@riverpod` annotation)
- **HTTP Client**: Dio + Retrofit
- **Serialization**: Freezed + json_serializable
- **Error Handling**: fpdart (Either<Failure, T>)
- **Logging**: AppLogger (custom logger)
- **Theme**: Theme extensions (context.colors)

---

## 📝 Patterns & Conventions

### 1. **Remote DataSource Pattern** (MANDATORY):
```dart
class IapRemoteDataSourceImpl implements IapRemoteDataSource {
  final IapApiService _apiService;  // ✅ Private field
  
  IapRemoteDataSourceImpl(this._apiService);
  
  @override
  Future<BaseResponseDto<DataDto>> method() async {
    try {
      AppLogger.d('Getting data');  // ✅ Debug log
      final response = await _apiService.method();
      AppLogger.i('Successfully retrieved data');  // ✅ Success log
      return response;  // ✅ Return directly
    } on DioException catch (e) {
      AppLogger.e('Failed to get data', e);  // ✅ Error log
      throw ResponseHandler.mapDioExceptionToException(e);
    } catch (e) {
      AppLogger.e('Unexpected error', e);
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
```

### 2. **Repository Pattern** (MANDATORY):
```dart
class IapRepositoryImpl implements IapRepository {
  final IapRemoteDataSource remoteDataSource;
  
  IapRepositoryImpl(this.remoteDataSource);
  
  @override
  Future<Either<Failure, Entity>> method() async {
    try {
      final response = await remoteDataSource.method();
      
      if (response.isSuccess && response.data != null) {
        return right(response.data!.toEntity());
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
```

### 3. **UseCase Pattern**:
```dart
class GetSubscriptionTiersUseCase {
  final IapRepository repository;
  
  GetSubscriptionTiersUseCase(this.repository);
  
  Future<Either<Failure, List<SubscriptionEntity>>> call() async {
    // Validate nghiệp vụ nếu cần
    return await repository.getSubscriptionTiers();
  }
}
```

### 4. **Notifier Pattern** (Riverpod):
```dart
@riverpod
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  SubscriptionState build() {
    _initializeUseCases();
    return const SubscriptionState();
  }
  
  Future<void> loadSubscriptionTiers() async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    
    final result = await _getSubscriptionTiersUseCase();
    
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (tiers) => state = state.copyWith(isLoading: false, availableTiers: tiers),
    );
  }
}
```

---

## 🚀 Cách Sử Dụng Feature

### 1. Khởi tạo IAP:
```dart
// Provider tự động khởi tạo khi được gọi lần đầu
final subscriptionState = ref.watch(subscriptionProvider);
```

### 2. Mua subscription:
```dart
ref.read(subscriptionProvider.notifier)
   .purchaseSubscription(SubscriptionTier.premiumMonthly);
```

### 3. Kiểm tra gói đang kích hoạt:
```dart
final activeSubscription = subscriptionState.activeSubscription;
if (activeSubscription != null) {
  // User có gói đang kích hoạt
}
```

### 4. Mua credits:
```dart
ref.read(consumableProvider.notifier)
   .purchaseProduct(productId);
```

### 5. Unlock tính năng:
```dart
ref.read(nonConsumableProvider.notifier)
   .purchaseFeature(productId);
```

### 6. Kiểm tra tính năng đã unlock:
```dart
final isUnlocked = await ref.read(checkFeatureUnlockedUseCaseProvider)
                            .call(FeatureType.removeAds);
```

---

## ⚠️ Lưu Ý Quan Trọng

### 1. **Backend API Integration**:
- Feature IAP đã được tích hợp với backend API thông qua `IapApiService` (Retrofit).
- Tất cả các thao tác quan trọng (subscription, purchase verification, credits, vouchers, features) đều gọi API backend.
- Local storage (SharedPreferences) chỉ dùng để cache tạm thời, KHÔNG phải nguồn dữ liệu chính xác.
- **QUAN TRỌNG**: Backend phải implement các endpoint trong `IapApiService` để feature hoạt động đầy đủ.

### 2. **IAP Store Integration** (App Store/Google Play):
- Sử dụng package `in_app_purchase` để tương tác với App Store và Google Play.
- Purchase flow: App → Store → Backend verification → App confirmation.
- **Flow chuẩn**:
  1. User chọn mua sản phẩm
  2. App gọi Store API để mua
  3. Store trả về purchase receipt
  4. App gửi receipt lên backend để verify
  5. Backend verify với Store server
  6. Backend cập nhật database và trả kết quả cho app
  7. App complete purchase với Store

### 3. **Error Handling**:
- Tất cả lỗi đều được xử lý qua `Either<Failure, T>`
- UI phải luôn kiểm tra `state.failure` để hiển thị lỗi

### 4. **Success Message**:
- Sau mỗi hành động thành công, show success message
- Nhớ clear message sau khi hiển thị

### 5. **Loading State**:
- Luôn set `isLoading = true` trước khi gọi usecase
- Set `isLoading = false` sau khi nhận kết quả

### 6. **Restore Purchases**:
- Subscription và Non-Consumable có thể restore
- Consumable KHÔNG thể restore (đã tiêu thụ)

### 7. **Product IDs**:
- Mỗi loại IAP có prefix productId riêng
- Subscription: `com.delivery.premium.*`
- Consumable: `com.delivery.voucher.*`, `com.delivery.credits.*`
- Non-Consumable: `com.delivery.unlock.*`

---

## 🧪 Testing

### Unit Tests:
- Test các UseCase với mock repository
- Test State Management (Notifier)
- Test Entity business logic (getter, methods)

### Integration Tests:
- Test flow mua hàng end-to-end
- Test restore purchases
- Test error handling

---

## 📈 Future Enhancements (Tương lai)

- [ ] Thêm analytics tracking cho mỗi purchase
- [ ] Thêm A/B testing cho giá sản phẩm
- [ ] Tích hợp payment gateway khác
- [ ] Thêm loyalty program
- [ ] Thêm referral credits
- [ ] Thêm bundle deals (combo giảm giá)
- [ ] Thêm seasonal offers

---

## 📞 Liên Hệ & Hỗ Trợ

Nếu có vấn đề liên quan đến IAP feature, vui lòng:
1. Kiểm tra log trong `AppLogger`
2. Kiểm tra state trong Riverpod DevTools
3. Xem lại guideline trong `.github/copilot-instructions.md`

---

**Ngày tạo**: 2 April 2026  
**Phiên bản**: 1.0  
**Tác giả**: Delivery App Team
