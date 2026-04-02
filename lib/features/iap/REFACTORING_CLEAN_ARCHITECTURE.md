# IAP DataSource Refactoring - Clean Architecture

## 📅 Ngày: 2 Tháng 4, 2026

---

## 🎯 Mục Đích Refactoring

### ❌ **VẤN ĐỀ CŨ:**
`IapRemoteDataSource` đang vi phạm Clean Architecture:
- Xử lý cả **Remote** (API, Store) và **Local** (SharedPreferences)
- Trộn lẫn concerns → khó test, khó maintain
- Methods như `saveUserCredits()`, `saveVoucher()` không thuộc về Remote layer

### ✅ **GIẢI PHÁP:**
Tách thành 2 DataSources riêng biệt:

1. **`IapRemoteDataSource`**: Chỉ xử lý Remote
   - App Store / Google Play (via `in_app_purchase`)
   - Backend API (via `IapApiService`)

2. **`IapLocalDataSource`**: Chỉ xử lý Local
   - SharedPreferences caching
   - Offline data access

---

## 🔧 Thay Đổi Chi Tiết

### **1. IapRemoteDataSource - BEFORE & AFTER**

#### ❌ **BEFORE (SAI):**
```dart
abstract class IapRemoteDataSource {
  // ✅ OK - Remote operations
  Future<List<IapProductDto>> getProducts(...);
  Future<PurchaseDto> purchaseSubscription(...);
  
  // ❌ SAI - Local operations (vi phạm SRP)
  Future<void> saveUserCredits(int balance);     // → Local!
  Future<void> saveVoucher(ConsumableDto voucher); // → Local!
  Future<List<FeatureType>> getUnlockedFeatures(); // → Local!
}
```

#### ✅ **AFTER (ĐÚNG):**
```dart
abstract class IapRemoteDataSource {
  // Core operations
  Future<bool> initialize();
  Future<bool> isAvailable(); // ✨ NEW - check store availability
  Future<List<IapProductDto>> getProducts(List<String> productIds);
  Stream<List<PurchaseDto>> get purchaseStream;
  
  // Purchase operations
  Future<void> buyProduct(String productId); // ✨ CHANGED - void return
  Future<void> restorePurchases();           // ✨ CHANGED - void return
  Future<void> completePurchase(PurchaseDto purchase);
  Future<bool> verifyPurchase(PurchaseDto purchase); // ✨ NEW - verify with backend
  
  // Subscription (remote only)
  Future<List<IapProductDto>> getSubscriptionProducts();
  Future<SubscriptionEntity?> getActiveSubscription(); // ✨ CHANGED - return Entity, not DTO
  Future<void> purchaseSubscription(SubscriptionTier tier); // ✨ CHANGED - void
  
  // Consumable (remote only)
  Future<List<ConsumableDto>> getConsumableProducts();
  Future<void> purchaseConsumable(String productId); // ✨ CHANGED - void
  Future<int> getUserCredits(); // From backend API
  Future<List<ConsumableDto>> getUserVouchers(); // From backend API
  
  // Non-consumable (remote only)
  Future<List<NonConsumableDto>> getNonConsumableProducts();
  Future<void> purchaseNonConsumable(String productId); // ✨ CHANGED - void
  Future<List<String>> getUnlockedFeatures(); // From backend API
  Future<bool> isFeatureUnlocked(String featureId); // From backend API
}
```

---

### **2. IapLocalDataSource - MỚI TẠO**

```dart
abstract class IapLocalDataSource {
  // Subscription cache
  SubscriptionTier getCachedSubscriptionTier();
  Future<void> saveSubscriptionTier(SubscriptionTier tier);
  String? getCachedSubscriptionExpiry();
  Future<void> saveSubscriptionExpiry(String expiryDate);
  Future<void> clearSubscriptionCache();
  
  // Consumable cache
  int getCachedUserCredits();
  Future<void> saveUserCredits(int balance);
  List<ConsumableDto> getCachedUserVouchers();
  Future<void> saveVoucher(ConsumableDto voucher);
  Future<void> removeVoucher(String voucherId);
  Future<void> clearVouchersCache();
  
  // Non-consumable cache
  List<String> getCachedUnlockedFeatures();
  Future<void> saveUnlockedFeature(String featureId);
  Future<void> removeUnlockedFeature(String featureId);
  bool isFeatureUnlockedInCache(String featureId);
  Future<void> clearUnlockedFeaturesCache();
  
  // General
  Future<void> clearAllCache();
}
```

---

## 📊 So Sánh Trước/Sau

| Aspect | BEFORE | AFTER |
|--------|--------|-------|
| **Separation of Concerns** | ❌ Mixed Remote + Local | ✅ Tách biệt rõ ràng |
| **Single Responsibility** | ❌ Vi phạm SRP | ✅ Tuân thủ SRP |
| **Testability** | ❌ Khó mock | ✅ Dễ test riêng |
| **Purchase Return Type** | ❌ `Future<PurchaseDto>` | ✅ `Future<void>` (via stream) |
| **Restore Return Type** | ❌ `Future<List<PurchaseDto>>` | ✅ `Future<void>` (via stream) |
| **Verification** | ❌ Không có | ✅ `verifyPurchase()` |
| **Store Availability Check** | ❌ Không có | ✅ `isAvailable()` |
| **Active Subscription Type** | ❌ `IapProductDto?` | ✅ `SubscriptionEntity?` |
| **Feature IDs** | ❌ `List<FeatureType>` enum | ✅ `List<String>` flexible |

---

## 🎯 Các Thay Đổi Quan Trọng

### **1. Purchase Methods Return `void` (via Stream)**

#### ❌ **TRƯỚC:**
```dart
Future<PurchaseDto> purchaseSubscription(SubscriptionTier tier);
```
**Vấn đề**: Purchase không hoàn tất ngay → misleading

#### ✅ **SAU:**
```dart
Future<void> purchaseSubscription(SubscriptionTier tier);
```
**Lý do**: Kết quả sẽ đến qua `purchaseStream` → đúng async flow

---

### **2. Restore Returns `void` (via Stream)**

#### ❌ **TRƯỚC:**
```dart
Future<List<PurchaseDto>> restorePurchases();
```

#### ✅ **SAU:**
```dart
Future<void> restorePurchases();
```
**Lý do**: Restored purchases đến qua `purchaseStream`

---

### **3. Verify Purchase - BẮT BUỘC**

#### ✨ **THÊM MỚI:**
```dart
Future<bool> verifyPurchase(PurchaseDto purchase);
```
**Lý do**: Bảo mật - không thể tin client, phải verify với backend

---

### **4. Active Subscription Returns Entity**

#### ❌ **TRƯỚC:**
```dart
Future<IapProductDto?> getActiveSubscription();
```
**Vấn đề**: Product ≠ Subscription state (thiếu expiry, tier, etc.)

#### ✅ **SAU:**
```dart
Future<SubscriptionEntity?> getActiveSubscription();
```
**Lý do**: Entity chứa đầy đủ state (expiry, tier, isActive, etc.)

---

### **5. Feature IDs Flexible**

#### ❌ **TRƯỚC:**
```dart
Future<List<FeatureType>> getUnlockedFeatures(); // Enum
```

#### ✅ **SAU:**
```dart
Future<List<String>> getUnlockedFeatures(); // String
```
**Lý do**: Backend có thể thêm features mới mà không cần update enum

---

## 🏗️ Architecture Layers

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (Providers, Notifiers, Screens)    │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│       Domain Layer                  │
│  (Entities, Repositories, UseCases) │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│        Data Layer                   │
│  ┌────────────────────────────────┐ │
│  │  IapRepository (Implementation)│ │
│  └─────┬──────────────────┬───────┘ │
│        │                  │         │
│  ┌─────▼─────┐      ┌────▼─────┐   │
│  │  Remote   │      │  Local   │   │ ✅ TÁCH BIỆT
│  │DataSource │      │DataSource│   │
│  └─────┬─────┘      └────┬─────┘   │
│        │                 │          │
└────────┼─────────────────┼──────────┘
         │                 │
    ┌────▼────┐       ┌────▼────────┐
    │  Store  │       │SharedPrefs  │
    │   API   │       │             │
    └─────────┘       └─────────────┘
    │Backend│
    │  API  │
    └───────┘
```

---

## 📝 Migration Checklist

### **Phase 1: Create New Files** ✅
- [x] Create `iap_local_datasource.dart` (interface)
- [x] Create `iap_local_datasource_impl.dart` (implementation)
- [x] Update `iap_remote_datasource.dart` (remove local methods)

### **Phase 2: Update Implementation** ⏳
- [ ] Update `iap_remote_datasource_impl.dart`:
  - Remove local storage code
  - Change return types to `void`
  - Add `verifyPurchase()` implementation
  - Add `isAvailable()` implementation
  - Change `getActiveSubscription()` to return `SubscriptionEntity`

### **Phase 3: Update Repository** ⏳
- [ ] Update `iap_repository_impl.dart`:
  - Inject both `IapRemoteDataSource` AND `IapLocalDataSource`
  - Use `remoteDataSource` for API calls
  - Use `localDataSource` for caching
  - Update purchase methods to listen to stream
  - Implement verify logic

### **Phase 4: Update Providers** ⏳
- [ ] Create `iapLocalDataSourceProvider`
- [ ] Update `iapRepositoryProvider` to inject both datasources
- [ ] Run code generation

### **Phase 5: Testing** ⏳
- [ ] Test remote operations
- [ ] Test local caching
- [ ] Test offline mode
- [ ] Test purchase flow end-to-end

---

## 🎓 Key Learnings

### **Clean Architecture Principles:**
1. **Separation of Concerns**: Remote ≠ Local
2. **Single Responsibility**: Mỗi class chỉ làm 1 việc
3. **Dependency Inversion**: Repository phụ thuộc vào abstractions
4. **Interface Segregation**: Tách interface cho từng concern

### **IAP Best Practices:**
1. **Purchase via Stream**: Kết quả không đồng bộ → dùng stream
2. **Always Verify**: Client không đáng tin → verify với backend
3. **Cache Smartly**: API fail → fallback về cache
4. **Type Safety**: Entity > DTO cho business logic

---

**Tác giả**: Delivery App Team  
**Ngày tạo**: 2/4/2026  
**Status**: In Progress - Phase 1 Complete ✅
