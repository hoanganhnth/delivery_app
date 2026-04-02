# IAP Backend Integration - Changelog

## 📅 Ngày: 2 Tháng 4, 2026

---

## ✅ Đã Hoàn Thành

### 1. **Setup Infrastructure** ✅
- [x] Tạo `IapApiService` với Retrofit (20+ endpoints)
- [x] Tạo providers cho dependency injection
- [x] Sử dụng `sharedPreferencesProvider` từ auth feature (xóa duplicate)
- [x] Thêm `IapApiService` vào `IapRemoteDataSourceImpl` constructor

### 2. **Subscription Methods** ✅
- [x] `getActiveSubscription()` - **ĐÃ CHUYỂN SANG BACKEND API**
  - **Trước**: Lấy từ SharedPreferences (fake data)
  - **Sau**: Gọi API `/iap/subscriptions/active`
  - **Cache**: Vẫn lưu vào SharedPreferences để offline access
  - **Fallback**: Trả về `null` nếu API fail (không có subscription)

### 3. **Consumable Methods** ✅
- [x] `getUserCredits()` - **ĐÃ CHUYỂN SANG BACKEND API**
  - Gọi API `/iap/consumables/credits`
  - Fallback về cache local nếu API fail
  - Cache kết quả để offline access

---

## 🔄 Đang Thực Hiện

### 4. **Các Methods Cần Cập Nhật Tiếp**

#### Consumable Methods (Còn 6/7)
- [ ] `getConsumableProducts()` - Gọi `/iap/consumables/products`
- [ ] `purchaseConsumable()` - Mua qua Store + verify với backend
- [ ] `saveUserCredits()` - Chỉ dùng local cache (backend tự quản lý)
- [ ] `getUserVouchers()` - Gọi `/iap/consumables/vouchers`
- [ ] `saveVoucher()` - Gọi `/iap/consumables/vouchers/add`
- [ ] `removeVoucher()` - Gọi `/iap/consumables/vouchers/use`

#### Non-Consumable Methods (Còn 4/4)
- [ ] `getNonConsumableProducts()` - Gọi `/iap/non-consumables/products`
- [ ] `getUnlockedFeatures()` - Gọi `/iap/non-consumables/unlocked-features`
- [ ] `saveUnlockedFeature()` - Gọi `/iap/non-consumables/unlock`
- [ ] `isFeatureUnlocked()` - Gọi `/iap/non-consumables/check-unlocked`

---

## 📊 Tiến Độ

| Module | Tổng | Hoàn Thành | Còn Lại | % |
|--------|------|------------|---------|---|
| **Infrastructure** | 4 | 4 | 0 | 100% |
| **Subscription** | 1 | 1 | 0 | 100% |
| **Consumable** | 7 | 1 | 6 | 14% |
| **Non-Consumable** | 4 | 0 | 4 | 0% |
| **TỔNG** | 16 | 6 | 10 | 37.5% |

---

## 🔧 Thay Đổi Chi Tiết

### **File 1: `iap_remote_datasource.dart`** (Interface)
**Thêm method mới:**
```dart
/// Get user's active subscription from backend
Future<IapProductDto?> getActiveSubscription();
```

### **File 2: `iap_remote_datasource_impl.dart`** (Implementation)
**Thêm implementation:**
```dart
@override
Future<IapProductDto?> getActiveSubscription() async {
  try {
    AppLogger.d('Getting active subscription from backend');
    final response = await _apiService.getActiveSubscription();
    
    if (response.isSuccess && response.data != null) {
      AppLogger.i('Successfully retrieved active subscription');
      return response.data;
    } else {
      AppLogger.w('No active subscription found');
      return null;
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to get active subscription', e);
    return null;
  } catch (e) {
    AppLogger.e('Unexpected error getting active subscription', e);
    return null;
  }
}
```

### **File 3: `iap_repository_impl.dart`** (Repository)
**Thay đổi từ fake → real API:**
```dart
// TRƯỚC (Fake - lấy từ SharedPreferences)
@override
Future<Either<Failure, SubscriptionEntity?>> getActiveSubscription() async {
  final hasActive = await hasActiveSubscription();
  final tier = _getStoredSubscriptionTier();
  final expiryDate = _getStoredExpiryDate();
  // Tạo subscription entity từ stored data (fake)
}

// SAU (Real - gọi backend API)
@override
Future<Either<Failure, SubscriptionEntity?>> getActiveSubscription() async {
  final productDto = await _remoteDataSource.getActiveSubscription(); // 🔥 GỌI API
  if (productDto == null) return right(null);
  
  // Convert DTO to entity
  final product = productDto.toEntity();
  final tier = _getTierFromProductId(product.id);
  
  // Cache locally for offline
  if (tier != SubscriptionTier.free) {
    await _storeSubscriptionInfo(tier);
  }
  
  return right(subscription);
}
```

### **File 4: `iap_providers.dart`** (Providers)
**Thêm provider cho IapApiService:**
```dart
/// Provider for IAP API service
@riverpod
IapApiService iapApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return IapApiService(dio);
}

/// Provider for IAP remote data source (cập nhật)
@riverpod
IapRemoteDataSource iapRemoteDataSource(Ref ref) {
  final inAppPurchase = ref.watch(inAppPurchaseProvider);
  final apiService = ref.watch(iapApiServiceProvider); // 🔥 INJECT API SERVICE
  final prefs = ref.watch(sharedPreferencesProvider);
  return IapRemoteDataSourceImpl(inAppPurchase, apiService, prefs);
}
```

---

## 🎯 Pattern Chuẩn

### **Remote DataSource Pattern:**
```dart
@override
Future<ReturnType> methodName() async {
  try {
    AppLogger.d('Action description');
    final response = await _apiService.methodName();
    
    if (response.isSuccess && response.data != null) {
      AppLogger.i('Success message');
      return response.data!;
    } else {
      AppLogger.w('Warning message');
      return fallbackValue; // or throw
    }
  } on DioException catch (e) {
    AppLogger.e('Error message', e);
    return fallbackValue; // hoặc throw nếu cần
  } catch (e) {
    AppLogger.e('Unexpected error', e);
    return fallbackValue;
  }
}
```

### **Repository Pattern:**
```dart
@override
Future<Either<Failure, Entity>> methodName() async {
  try {
    final dto = await _remoteDataSource.methodName(); // Gọi API
    // Convert DTO → Entity
    return right(entity);
  } on Exception catch (e) {
    return left(_mapExceptionToFailure(e));
  } catch (e) {
    return left(const ServerFailure('Unexpected error occurred'));
  }
}
```

---

## 📝 Ghi Chú

### **Lưu Ý Quan Trọng:**
1. **Store API vs Backend API**:
   - **Store API** (InAppPurchase): Mua sản phẩm từ App Store/Google Play
   - **Backend API** (IapApiService): Verify purchase, quản lý balance, subscriptions

2. **Cache Strategy**:
   - Luôn ưu tiên dữ liệu từ backend
   - Cache vào SharedPreferences để offline access
   - Fallback về cache khi API fail

3. **Error Handling**:
   - Remote datasource: Throw exception hoặc return null/fallback
   - Repository: Convert exception → Failure (Either pattern)
   - Luôn log đầy đủ với AppLogger

4. **Purchase Flow**:
   ```
   User → Store API (mua) → Receipt → Backend (verify) → Update DB → Return kết quả
   ```

---

## 🚀 Tiếp Theo

### **Bước 1: Cập Nhật Consumable Methods**
Theo thứ tự ưu tiên:
1. `getConsumableProducts()` - Lấy danh sách products
2. `getUserVouchers()` - Lấy vouchers của user
3. `saveVoucher()` / `removeVoucher()` - Quản lý vouchers

### **Bước 2: Cập Nhật Non-Consumable Methods**
1. `getNonConsumableProducts()` - Lấy danh sách features
2. `getUnlockedFeatures()` - Lấy features đã unlock
3. `isFeatureUnlocked()` - Check feature status

### **Bước 3: Testing & Validation**
1. Test với backend API thật
2. Test offline mode (fallback)
3. Test error handling

---

**Tác giả**: Delivery App Team  
**Cập nhật lần cuối**: 2/4/2026 - 37.5% hoàn thành
