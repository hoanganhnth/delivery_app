# IAP Remote DataSource - Hướng Dẫn Cập Nhật Backend API

## 📋 Tổng Quan
File này hướng dẫn cách cập nhật `IapRemoteDataSourceImpl` để gọi API backend thật thay vì fake data từ SharedPreferences.

---

## ✅ Đã Hoàn Thành

### 1. **Thêm `IapApiService` vào constructor**
```dart
class IapRemoteDataSourceImpl implements IapRemoteDataSource {
  final InAppPurchase _inAppPurchase;
  final IapApiService _apiService;  // ✅ Đã thêm
  final SharedPreferences _sharedPreferences;
  
  IapRemoteDataSourceImpl(
    this._inAppPurchase,
    this._apiService,  // ✅ Inject từ provider
    this._sharedPreferences,
  );
}
```

### 2. **Cập nhật method `getUserCredits()`**
✅ Đã cập nhật để:
- Gọi API backend qua `_apiService.getUserCredits()`
- Cache kết quả vào SharedPreferences
- Fallback về cache local nếu API fail
- Log đầy đủ

---

## 🔄 Cần Cập Nhật Tiếp

### Pattern Chuẩn Cho Tất Cả Methods

**Nguyên tắc:**
1. Gọi API backend trước
2. Nếu thành công → cache vào local (nếu cần)
3. Nếu fail → fallback về cache local (nếu có)
4. Log đầy đủ các bước

**Template:**
```dart
@override
Future<ReturnType> methodName(params) async {
  try {
    AppLogger.d('Calling backend API for methodName');
    final response = await _apiService.methodName(params);
    
    if (response.isSuccess && response.data != null) {
      // Cache locally if needed (for offline access)
      // await _cacheData(response.data);
      
      AppLogger.i('Successfully retrieved data from backend');
      return response.data!;
    } else {
      // Try fallback to cache
      AppLogger.w('API call failed, trying cache');
      return _getFallbackData();
    }
  } on DioException catch (e) {
    AppLogger.e('DioException in methodName', e);
    throw DioExceptionHandler.mapDioExceptionToException(e);
  } catch (e) {
    AppLogger.e('Unexpected error in methodName', e);
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
```

---

## 📝 Danh Sách Methods Cần Cập Nhật

### ✅ Subscription Methods (Đã OK - dùng Store API)
- `getSubscriptionProducts()` - Lấy từ Store
- `purchaseSubscription()` - Mua qua Store, sau đó verify với backend
- `restorePurchases()` - Restore từ Store

### 🔄 Consumable Methods (Cần cập nhật)

#### 1. `getConsumableProducts()`
**Hiện tại**: Lấy từ Store  
**Cập nhật**: Lấy từ backend API để có thông tin mới nhất
```dart
@override
Future<List<ConsumableDto>> getConsumableProducts() async {
  try {
    AppLogger.d('Getting consumable products from backend');
    final response = await _apiService.getConsumableProducts();
    
    if (response.isSuccess && response.data != null) {
      AppLogger.i('Successfully retrieved ${response.data!.length} consumable products');
      return response.data!;
    } else {
      throw Exception(response.message);
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to get consumable products', e);
    throw DioExceptionHandler.mapDioExceptionToException(e);
  } catch (e) {
    AppLogger.e('Unexpected error getting consumable products', e);
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
```

#### 2. `purchaseConsumable()`
**Hiện tại**: Mua qua Store  
**Cập nhật**: Sau khi mua thành công qua Store, gọi backend để verify
```dart
@override
Future<PurchaseDto> purchaseConsumable(String productId) async {
  try {
    AppLogger.d('Purchasing consumable: $productId');
    
    // 1. Mua qua Store
    final productDetails = await _getProductDetails(productId);
    if (productDetails == null) {
      throw Exception('Product not found: $productId');
    }
    
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    final success = await _inAppPurchase.buyConsumable(
      purchaseParam: purchaseParam,
    );
    
    if (!success) {
      throw Exception('Failed to initiate purchase');
    }
    
    // 2. Verify với backend (sau khi nhận purchase details từ stream)
    // Tạm thời return pending purchase, backend verify sẽ xử lý sau
    AppLogger.i('Consumable purchase initiated: $productId');
    
    return PurchaseDto(
      purchaseId: '',
      productId: productId,
      transactionDate: DateTime.now().toIso8601String(),
      status: 'pending',
      pendingCompletePurchase: true,
    );
  } catch (e) {
    AppLogger.e('Failed to purchase consumable: $productId', e);
    throw Exception('Failed to purchase consumable: ${e.toString()}');
  }
}
```

#### 3. ✅ `getUserCredits()` - ĐÃ CẬP NHẬT
Đã gọi backend API và fallback về cache.

#### 4. `saveUserCredits()`
**Hiện tại**: Lưu vào SharedPreferences  
**Cập nhật**: Gọi backend API `addCredits()` hoặc chỉ dùng internal cho cache
```dart
@override
Future<void> saveUserCredits(int balance) async {
  try {
    AppLogger.d('Saving user credits locally: $balance');
    // Chỉ lưu local cache, API backend sẽ quản lý balance chính xác
    await _sharedPreferences.setInt(_IapStorageKeys.userCredits, balance);
    AppLogger.i('Successfully saved user credits to cache');
  } catch (e) {
    AppLogger.e('Failed to save user credits', e);
    throw Exception('Failed to save user credits: ${e.toString()}');
  }
}
```

#### 5. `getUserVouchers()`
**Hiện tại**: Lấy từ SharedPreferences  
**Cập nhật**: Gọi backend API
```dart
@override
Future<List<ConsumableDto>> getUserVouchers() async {
  try {
    AppLogger.d('Getting user vouchers from backend');
    final response = await _apiService.getUserVouchers();
    
    if (response.isSuccess && response.data != null) {
      // Cache locally
      final jsonList = response.data!.map((v) => jsonEncode(v.toJson())).toList();
      await _sharedPreferences.setStringList(_IapStorageKeys.userVouchers, jsonList);
      
      AppLogger.i('Successfully retrieved ${response.data!.length} vouchers');
      return response.data!;
    } else {
      // Fallback to cache
      final cached = _getCachedVouchers();
      AppLogger.w('API failed, using ${cached.length} cached vouchers');
      return cached;
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to get user vouchers', e);
    // Fallback to cache
    return _getCachedVouchers();
  } catch (e) {
    AppLogger.e('Unexpected error getting user vouchers', e);
    return _getCachedVouchers();
  }
}

// Helper method
List<ConsumableDto> _getCachedVouchers() {
  final jsonList = _sharedPreferences.getStringList(_IapStorageKeys.userVouchers) ?? [];
  return jsonList.map((json) => ConsumableDto.fromJson(jsonDecode(json))).toList();
}
```

#### 6. `saveVoucher()`
**Cập nhật**: Gọi backend API
```dart
@override
Future<void> saveVoucher(ConsumableDto voucher) async {
  try {
    AppLogger.d('Saving voucher to backend');
    final response = await _apiService.addVoucher(voucher);
    
    if (response.isSuccess) {
      // Update local cache
      await _addVoucherToCache(voucher);
      AppLogger.i('Successfully saved voucher');
    } else {
      throw Exception(response.message);
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to save voucher', e);
    throw DioExceptionHandler.mapDioExceptionToException(e);
  } catch (e) {
    AppLogger.e('Unexpected error saving voucher', e);
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
```

#### 7. `removeVoucher()`
**Cập nhật**: Gọi backend API
```dart
@override
Future<void> removeVoucher(String voucherId) async {
  try {
    AppLogger.d('Removing voucher: $voucherId');
    final response = await _apiService.useVoucher({
      'voucherId': voucherId,
      'orderId': '', // Cần truyền orderId khi sử dụng
    });
    
    if (response.isSuccess) {
      // Update local cache
      await _removeVoucherFromCache(voucherId);
      AppLogger.i('Successfully removed voucher');
    } else {
      throw Exception(response.message);
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to remove voucher', e);
    throw DioExceptionHandler.mapDioExceptionToException(e);
  } catch (e) {
    AppLogger.e('Unexpected error removing voucher', e);
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
```

---

### 🔓 Non-Consumable Methods (Cần cập nhật)

#### 1. `getNonConsumableProducts()`
```dart
@override
Future<List<NonConsumableDto>> getNonConsumableProducts() async {
  try {
    AppLogger.d('Getting non-consumable products from backend');
    final response = await _apiService.getNonConsumableProducts();
    
    if (response.isSuccess && response.data != null) {
      AppLogger.i('Successfully retrieved ${response.data!.length} non-consumable products');
      return response.data!;
    } else {
      throw Exception(response.message);
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to get non-consumable products', e);
    throw DioExceptionHandler.mapDioExceptionToException(e);
  } catch (e) {
    AppLogger.e('Unexpected error getting non-consumable products', e);
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
```

#### 2. `getUnlockedFeatures()`
```dart
@override
Future<List<FeatureType>> getUnlockedFeatures() async {
  try {
    AppLogger.d('Getting unlocked features from backend');
    final response = await _apiService.getUnlockedFeatures();
    
    if (response.isSuccess && response.data != null) {
      // Parse string list to FeatureType
      final features = response.data!
          .map((name) => FeatureTypeExtension.fromString(name))
          .whereType<FeatureType>()
          .toList();
      
      // Cache locally
      await _sharedPreferences.setStringList(
        _IapStorageKeys.unlockedFeatures,
        response.data!,
      );
      
      AppLogger.i('Successfully retrieved ${features.length} unlocked features');
      return features;
    } else {
      // Fallback to cache
      return _getCachedUnlockedFeatures();
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to get unlocked features', e);
    return _getCachedUnlockedFeatures();
  } catch (e) {
    AppLogger.e('Unexpected error getting unlocked features', e);
    return _getCachedUnlockedFeatures();
  }
}

List<FeatureType> _getCachedUnlockedFeatures() {
  final cached = _sharedPreferences.getStringList(_IapStorageKeys.unlockedFeatures) ?? [];
  return cached
      .map((name) => FeatureTypeExtension.fromString(name))
      .whereType<FeatureType>()
      .toList();
}
```

#### 3. `saveUnlockedFeature()`
```dart
@override
Future<void> saveUnlockedFeature(FeatureType featureType) async {
  try {
    AppLogger.d('Unlocking feature: ${featureType.name}');
    final response = await _apiService.unlockFeature({
      'featureType': featureType.name,
      'purchaseId': '', // Cần truyền purchaseId từ purchase
    });
    
    if (response.isSuccess) {
      // Update local cache
      await _addFeatureToCache(featureType);
      AppLogger.i('Successfully unlocked feature: ${featureType.name}');
    } else {
      throw Exception(response.message);
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to unlock feature', e);
    throw DioExceptionHandler.mapDioExceptionToException(e);
  } catch (e) {
    AppLogger.e('Unexpected error unlocking feature', e);
    throw Exception('Unexpected error: ${e.toString()}');
  }
}
```

#### 4. `isFeatureUnlocked()`
```dart
@override
Future<bool> isFeatureUnlocked(FeatureType featureType) async {
  try {
    AppLogger.d('Checking if feature is unlocked: ${featureType.name}');
    final response = await _apiService.isFeatureUnlocked(featureType.name);
    
    if (response.isSuccess && response.data != null) {
      AppLogger.i('Feature ${featureType.name} unlocked: ${response.data}');
      return response.data!;
    } else {
      // Fallback to cache
      return _isFeatureUnlockedInCache(featureType);
    }
  } on DioException catch (e) {
    AppLogger.e('Failed to check feature unlock status', e);
    return _isFeatureUnlockedInCache(featureType);
  } catch (e) {
    AppLogger.e('Unexpected error checking feature unlock status', e);
    return _isFeatureUnlockedInCache(featureType);
  }
}

bool _isFeatureUnlockedInCache(FeatureType featureType) {
  final cached = _getCachedUnlockedFeatures();
  return cached.contains(featureType);
}
```

---

## 🔧 Helper Methods Cần Thêm

```dart
// Cache voucher locally
Future<void> _addVoucherToCache(ConsumableDto voucher) async {
  final jsonList = _sharedPreferences.getStringList(_IapStorageKeys.userVouchers) ?? [];
  jsonList.add(jsonEncode(voucher.toJson()));
  await _sharedPreferences.setStringList(_IapStorageKeys.userVouchers, jsonList);
}

// Remove voucher from cache
Future<void> _removeVoucherFromCache(String voucherId) async {
  final cached = _getCachedVouchers();
  final updated = cached.where((v) => v.id != voucherId).toList();
  final jsonList = updated.map((v) => jsonEncode(v.toJson())).toList();
  await _sharedPreferences.setStringList(_IapStorageKeys.userVouchers, jsonList);
}

// Add feature to cache
Future<void> _addFeatureToCache(FeatureType featureType) async {
  final cached = _sharedPreferences.getStringList(_IapStorageKeys.unlockedFeatures) ?? [];
  if (!cached.contains(featureType.name)) {
    cached.add(featureType.name);
    await _sharedPreferences.setStringList(_IapStorageKeys.unlockedFeatures, cached);
  }
}
```

---

## ⚠️ Lưu Ý Quan Trọng

### 1. **Store vs Backend**
- **Store API** (InAppPurchase): Dùng để mua sản phẩm từ App Store/Google Play
- **Backend API** (IapApiService): Dùng để verify purchase, quản lý balance, vouchers, features

### 2. **Purchase Flow Chuẩn**
1. User chọn mua → Gọi Store API
2. Store trả về purchase receipt
3. App gửi receipt lên Backend để verify
4. Backend verify với Store server
5. Backend cập nhật database và trả kết quả
6. App update UI và cache local

### 3. **Cache Strategy**
- Cache để offline access
- Luôn ưu tiên dữ liệu từ backend
- Fallback về cache khi API fail

### 4. **Error Handling**
- Luôn catch `DioException` riêng
- Fallback về cache khi có lỗi
- Log đầy đủ để debug

---

## 📊 Checklist Hoàn Thành

- [x] Add `IapApiService` to constructor
- [x] Update `getUserCredits()`
- [ ] Update `getConsumableProducts()`
- [ ] Update `getUserVouchers()`
- [ ] Update `saveVoucher()`
- [ ] Update `removeVoucher()`
- [ ] Update `getNonConsumableProducts()`
- [ ] Update `getUnlockedFeatures()`
- [ ] Update `saveUnlockedFeature()`
- [ ] Update `isFeatureUnlocked()`
- [ ] Add helper methods for cache
- [ ] Update providers to inject `IapApiService`
- [ ] Test với backend API thật

---

**Ngày tạo**: 2 April 2026  
**Tác giả**: Delivery App Team
