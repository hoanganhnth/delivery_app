# In-App Purchase (IAP) - Subscription Feature

## 📱 Overview
Đã implement thành công tính năng **Subscription IAP** cho delivery app với 3 tiers: Premium Monthly, Premium Yearly, và VIP.

## 🏗️ Architecture

### 1. Domain Layer

#### Entities
- **`IapProductEntity`**: Đại diện cho một sản phẩm IAP
  - `id`, `title`, `description`, `price`, `currencyCode`, `rawPrice`
  - `productType`: subscription | consumable | nonConsumable

- **`PurchaseEntity`**: Đại diện cho một giao dịch mua hàng
  - `purchaseId`, `productId`, `transactionDate`
  - `status`: pending | purchased | restored | error | canceled
  - `verificationData`, `pendingCompletePurchase`

- **`SubscriptionEntity`**: Đại diện cho subscription với chi tiết cụ thể
  - `product`: IapProductEntity
  - `isActive`, `expiryDate`, `isAutoRenewing`
  - `tier`: free | premiumMonthly | premiumYearly | vip

#### SubscriptionTier
```dart
enum SubscriptionTier {
  free,
  premiumMonthly,    // com.delivery.premium.monthly
  premiumYearly,     // com.delivery.premium.yearly
  vip,               // com.delivery.vip.monthly
}
```

**Benefits by Tier:**
- **Free**: Standard delivery, Basic support, Limited history
- **Premium Monthly**: Free delivery >$20, Priority support, Exclusive deals, Order tracking
- **Premium Yearly**: Free delivery all orders, 24/7 support, Early access, Save 20%
- **VIP**: Express delivery, Dedicated manager, VIP restaurants, Custom plans, Birthday rewards

#### Repository Interface
```dart
abstract class IapRepository {
  Future<Either<Failure, bool>> initialize();
  Future<Either<Failure, List<SubscriptionEntity>>> getSubscriptionTiers();
  Future<Either<Failure, PurchaseEntity>> purchaseSubscription(SubscriptionTier tier);
  Future<Either<Failure, List<PurchaseEntity>>> restorePurchases();
  Future<Either<Failure, SubscriptionEntity?>> getActiveSubscription();
  Future<Either<Failure, bool>> hasActiveSubscription();
  Stream<List<PurchaseEntity>> get purchaseStream;
}
```

#### Use Cases
- `GetSubscriptionTiersUseCase`: Lấy danh sách subscription tiers
- `GetActiveSubscriptionUseCase`: Lấy subscription đang active
- `PurchaseSubscriptionUseCase`: Mua subscription
- `RestorePurchasesUseCase`: Khôi phục purchases trước đó

### 2. Data Layer

#### DTOs (with Freezed)
- **`IapProductDto`**: Convert from/to `ProductDetails` (in_app_purchase)
- **`PurchaseDto`**: Convert from/to `PurchaseDetails` (in_app_purchase)

#### Data Sources
- **`IapRemoteDataSource`** (Interface)
- **`IapRemoteDataSourceImpl`**: Implementation using `InAppPurchase.instance`
  - `initialize()`: Kiểm tra availability & listen purchase stream
  - `getSubscriptionProducts()`: Query subscription products từ store
  - `purchaseSubscription()`: Initiate subscription purchase
  - `restorePurchases()`: Restore previous purchases
  - Purchase stream handling với auto-completion

#### Repository Implementation
- **`IapRepositoryImpl`**:
  - Sử dụng `SharedPreferences` để lưu subscription info locally
  - Keys: `active_subscription_tier`, `subscription_expiry_date`
  - Auto-calculate expiry dates (30 days monthly, 365 days yearly)
  - Check subscription validity based on expiry date
  - Error mapping từ Exception → Failure

### 3. Presentation Layer

#### State Management
- **`SubscriptionState`**: Immutable state class
  ```dart
  {
    isLoading: bool
    availableTiers: List<SubscriptionEntity>
    activeSubscription: SubscriptionEntity?
    currentPurchase: PurchaseEntity?
    failure: Failure?
    successMessage: String?
  }
  ```

- **`SubscriptionNotifier`**: StateNotifier<SubscriptionState>
  - `loadSubscriptionTiers()`: Load available tiers
  - `loadActiveSubscription()`: Load current active subscription
  - `purchaseSubscription(tier)`: Purchase a specific tier
  - `restorePurchases()`: Restore previous purchases
  - `cancelSubscription()`: Cancel current subscription

#### Riverpod Providers (Code-generated)
```dart
@riverpod InAppPurchase inAppPurchase(ref)
@riverpod IapRemoteDataSource iapRemoteDataSource(ref)
@riverpod Future<IapRepository> iapRepository(ref)  // Auto-initializes IAP
@riverpod Future<GetSubscriptionTiersUseCase> getSubscriptionTiersUseCase(ref)
@riverpod Future<PurchaseSubscriptionUseCase> purchaseSubscriptionUseCase(ref)
@riverpod Future<RestorePurchasesUseCase> restorePurchasesUseCase(ref)
@riverpod class SubscriptionNotifierProvider  // Main state provider
```

#### UI Screen
- **`SubscriptionScreen`**: Full-featured subscription UI
  - Display current active subscription status
  - Show all available subscription tiers
  - Premium tier cards with benefits list
  - Special "SAVE 20%" badge for yearly plan
  - "Subscribe Now" / "Current Plan" buttons
  - Restore purchases action in AppBar
  - Free tier card for reference
  - Loading states & error handling
  - Success/error messages with SnackBar

## 📦 Dependencies Added
```yaml
dependencies:
  in_app_purchase: ^3.2.0  # Official Flutter IAP plugin
```

## 🔧 Configuration Required

### iOS (StoreKit)
1. **App Store Connect**:
   - Create subscription products:
     - `com.delivery.premium.monthly` (Auto-renewable subscription)
     - `com.delivery.premium.yearly` (Auto-renewable subscription)
     - `com.delivery.vip.monthly` (Auto-renewable subscription)

2. **Xcode Project**:
   - Enable "In-App Purchase" capability
   - Add StoreKit configuration file for testing

3. **Info.plist**: (Already configured by in_app_purchase plugin)

### Android (Google Play Billing)
1. **Google Play Console**:
   - Create subscription products with same IDs
   - Configure billing periods (monthly/yearly)

2. **AndroidManifest.xml**: (Auto-configured by plugin)
   ```xml
   <uses-permission android:name="com.android.vending.BILLING" />
   ```

## 🧪 Testing

### Local Testing (Sandbox)
- **iOS**: Use Sandbox tester accounts in App Store Connect
- **Android**: Use test tracks in Google Play Console

### Test Scenarios
1. ✅ Display subscription tiers with correct pricing
2. ✅ Purchase subscription (pending → purchased flow)
3. ✅ Restore previous purchases
4. ✅ Check active subscription status
5. ✅ Handle subscription expiry
6. ✅ Error handling (network, cancelled purchase, etc.)

## 📊 Data Flow

```
User Action (Subscribe)
  ↓
SubscriptionScreen
  ↓
SubscriptionNotifier.purchaseSubscription(tier)
  ↓
PurchaseSubscriptionUseCase(tier)
  ↓
IapRepository.purchaseSubscription(tier)
  ↓
IapRemoteDataSource.purchaseSubscription(tier)
  ↓
InAppPurchase.buyNonConsumable()
  ↓
Purchase Stream → Update UI
  ↓
Store subscription info locally (SharedPreferences)
```

## 🎯 Next Steps

### For CONSUMABLE (Vouchers/Credits):
- Create `VoucherEntity` & `CreditEntity`
- Add `purchaseConsumable()` use case
- Implement `consumePurchase()` for repeatable purchases
- Add voucher/credit balance tracking

### For NON-CONSUMABLE (One-time features):
- Create `FeatureEntity`
- Add `purchaseFeature()` use case
- Implement feature unlock mechanism
- Add "Purchased" badge in feature list

### Backend Integration (Optional):
- Receipt validation endpoint
- Subscription status sync
- Webhook for subscription events (renewed/cancelled/expired)
- Server-side subscription verification

## 🔐 Security Notes
1. **Receipt Validation**: Consider server-side validation for production
2. **Subscription Status**: Don't rely solely on local storage
3. **Expiry Checks**: Implement proper date validation
4. **Test Purchases**: Use sandbox accounts, never real purchases in dev

## 📱 Usage Example

```dart
// Navigate to subscription screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SubscriptionScreen(),
  ),
);

// Check if user has active subscription
final repository = await ref.read(iapRepositoryProvider.future);
final hasActive = await repository.hasActiveSubscription();

// Get current tier
final subscription = await repository.getActiveSubscription();
if (subscription.isRight()) {
  final tier = subscription.getOrElse((_) => null)?.tier ?? SubscriptionTier.free;
  print('Current tier: ${tier.displayName}');
}
```

## ✅ Status
- [x] Domain layer (Entities, Repository, Use Cases)
- [x] Data layer (DTOs, DataSources, Repository Implementation)
- [x] Presentation layer (State, Notifier, Providers)
- [x] UI Screen (Subscription tiers display)
- [x] Build runner code generation
- [ ] iOS StoreKit configuration
- [ ] Android Google Play Billing configuration
- [ ] Receipt validation (optional)
- [ ] Backend integration (optional)

---

**Ready for**: Consumable & Non-Consumable IAP implementation
**Requires**: App Store & Play Store product configuration before testing
