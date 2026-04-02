# IAP Backend API Requirements

## 📋 Tổng Quan
Document này mô tả các API endpoint mà backend cần implement để hỗ trợ feature IAP (In-App Purchase) trong ứng dụng delivery.

---

## 🔐 Authentication
Tất cả các API đều yêu cầu authentication token (Bearer token) trong header:
```
Authorization: Bearer <access_token>
```

---

## 📡 API Endpoints

### 1. SUBSCRIPTION APIs

#### 1.1. Get Subscription Tiers
**Endpoint**: `GET /iap/subscriptions/tiers`  
**Description**: Lấy danh sách các gói đăng ký có sẵn từ backend

**Request**: None

**Response**:
```json
{
  "success": true,
  "message": "Subscription tiers retrieved successfully",
  "data": [
    {
      "id": "com.delivery.premium.monthly",
      "title": "Premium Monthly",
      "description": "Premium subscription with monthly billing",
      "price": "$9.99/month",
      "currencyCode": "USD",
      "rawPrice": 9.99,
      "productType": "subscription"
    }
  ]
}
```

---

#### 1.2. Get Active Subscription
**Endpoint**: `GET /iap/subscriptions/active`  
**Description**: Lấy gói đăng ký đang kích hoạt của user

**Request**: None

**Response**:
```json
{
  "success": true,
  "message": "Active subscription retrieved",
  "data": {
    "id": "com.delivery.premium.monthly",
    "title": "Premium Monthly",
    "description": "Premium subscription with monthly billing",
    "price": "$9.99/month",
    "currencyCode": "USD",
    "rawPrice": 9.99,
    "productType": "subscription",
    "isActive": true,
    "expiryDate": "2026-05-02T10:30:00Z",
    "isAutoRenewing": true,
    "tier": "premiumMonthly"
  }
}
```

**Note**: Nếu user không có subscription, trả về `data: null`

---

#### 1.3. Verify Subscription Purchase
**Endpoint**: `POST /iap/subscriptions/verify`  
**Description**: Xác thực purchase receipt từ App Store/Google Play và kích hoạt subscription

**Request**:
```json
{
  "productId": "com.delivery.premium.monthly",
  "purchaseToken": "...", // Google Play purchase token
  "receipt": "...", // iOS receipt data (base64)
  "platform": "ios" // or "android"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Subscription verified and activated",
  "data": {
    "purchaseId": "GPA.1234-5678-9012-34567",
    "productId": "com.delivery.premium.monthly",
    "transactionDate": "2026-04-02T10:30:00Z",
    "status": "verified",
    "pendingCompletePurchase": false
  }
}
```

---

#### 1.4. Restore Subscription Purchases
**Endpoint**: `POST /iap/subscriptions/restore`  
**Description**: Khôi phục các subscription đã mua trước đó

**Request**:
```json
{
  "platform": "ios", // or "android"
  "receipts": ["...", "..."] // Array of receipt data
}
```

**Response**:
```json
{
  "success": true,
  "message": "Subscriptions restored",
  "data": [
    {
      "purchaseId": "GPA.1234-5678-9012-34567",
      "productId": "com.delivery.premium.monthly",
      "transactionDate": "2026-04-02T10:30:00Z",
      "status": "verified",
      "pendingCompletePurchase": false
    }
  ]
}
```

---

### 2. CONSUMABLE APIs

#### 2.1. Get Consumable Products
**Endpoint**: `GET /iap/consumables/products`  
**Description**: Lấy danh sách sản phẩm consumable (credits, vouchers)

**Request**: None

**Response**:
```json
{
  "success": true,
  "message": "Consumable products retrieved",
  "data": [
    {
      "id": "com.delivery.credits.100",
      "title": "100 Credits",
      "description": "Get 100 delivery credits",
      "price": "$4.99",
      "currencyCode": "USD",
      "rawPrice": 4.99,
      "productType": "consumable",
      "type": "deliveryCredits",
      "value": 100
    }
  ]
}
```

---

#### 2.2. Verify Consumable Purchase
**Endpoint**: `POST /iap/consumables/verify`  
**Description**: Xác thực purchase và cộng credits/voucher vào tài khoản user

**Request**:
```json
{
  "productId": "com.delivery.credits.100",
  "purchaseToken": "...",
  "receipt": "...",
  "platform": "ios"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Purchase verified and credits added",
  "data": {
    "purchaseId": "GPA.1234-5678-9012-34567",
    "productId": "com.delivery.credits.100",
    "transactionDate": "2026-04-02T10:30:00Z",
    "status": "verified",
    "pendingCompletePurchase": false
  }
}
```

---

#### 2.3. Get User Credits
**Endpoint**: `GET /iap/consumables/credits`  
**Description**: Lấy số dư credits hiện tại của user

**Request**: None

**Response**:
```json
{
  "success": true,
  "message": "User credits retrieved",
  "data": 250
}
```

---

#### 2.4. Add Credits
**Endpoint**: `POST /iap/consumables/credits/add`  
**Description**: Cộng credits vào tài khoản user (sau khi verify purchase thành công)

**Request**:
```json
{
  "amount": 100,
  "purchaseId": "GPA.1234-5678-9012-34567"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Credits added successfully",
  "data": 350 // New balance
}
```

---

#### 2.5. Deduct Credits
**Endpoint**: `POST /iap/consumables/credits/deduct`  
**Description**: Trừ credits khi user sử dụng (ví dụ: áp dụng cho đơn hàng)

**Request**:
```json
{
  "amount": 50,
  "orderId": "ORDER-123456",
  "reason": "Applied to order"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Credits deducted successfully",
  "data": 300 // New balance
}
```

**Error Response** (insufficient credits):
```json
{
  "success": false,
  "message": "Insufficient credits",
  "data": null
}
```

---

#### 2.6. Get User Vouchers
**Endpoint**: `GET /iap/consumables/vouchers`  
**Description**: Lấy danh sách voucher trong kho của user

**Request**: None

**Response**:
```json
{
  "success": true,
  "message": "User vouchers retrieved",
  "data": [
    {
      "id": "VOUCHER-001",
      "type": "discountVoucher",
      "value": 20.0,
      "code": "SAVE20",
      "expiryDate": "2026-05-01T23:59:59Z"
    }
  ]
}
```

---

#### 2.7. Add Voucher
**Endpoint**: `POST /iap/consumables/vouchers/add`  
**Description**: Thêm voucher vào kho của user (sau khi verify purchase)

**Request**:
```json
{
  "id": "VOUCHER-001",
  "type": "discountVoucher",
  "value": 20.0,
  "code": "SAVE20",
  "expiryDate": "2026-05-01T23:59:59Z"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Voucher added successfully",
  "data": null
}
```

---

#### 2.8. Use Voucher
**Endpoint**: `POST /iap/consumables/vouchers/use`  
**Description**: Sử dụng voucher (xoá khỏi kho sau khi áp dụng)

**Request**:
```json
{
  "voucherId": "VOUCHER-001",
  "orderId": "ORDER-123456"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Voucher used successfully",
  "data": null
}
```

---

### 3. NON-CONSUMABLE APIs

#### 3.1. Get Non-Consumable Products
**Endpoint**: `GET /iap/non-consumables/products`  
**Description**: Lấy danh sách tính năng có thể unlock

**Request**: None

**Response**:
```json
{
  "success": true,
  "message": "Non-consumable products retrieved",
  "data": [
    {
      "id": "com.delivery.unlock.removeads",
      "title": "Remove Ads",
      "description": "Enjoy ad-free experience forever",
      "price": "$2.99",
      "currencyCode": "USD",
      "rawPrice": 2.99,
      "productType": "nonConsumable",
      "featureType": "removeAds",
      "isUnlocked": false
    }
  ]
}
```

---

#### 3.2. Verify Non-Consumable Purchase
**Endpoint**: `POST /iap/non-consumables/verify`  
**Description**: Xác thực purchase và unlock tính năng

**Request**:
```json
{
  "productId": "com.delivery.unlock.removeads",
  "purchaseToken": "...",
  "receipt": "...",
  "platform": "ios"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Purchase verified and feature unlocked",
  "data": {
    "purchaseId": "GPA.1234-5678-9012-34567",
    "productId": "com.delivery.unlock.removeads",
    "transactionDate": "2026-04-02T10:30:00Z",
    "status": "verified",
    "pendingCompletePurchase": false
  }
}
```

---

#### 3.3. Get Unlocked Features
**Endpoint**: `GET /iap/non-consumables/unlocked`  
**Description**: Lấy danh sách tính năng đã unlock của user

**Request**: None

**Response**:
```json
{
  "success": true,
  "message": "Unlocked features retrieved",
  "data": ["removeAds", "darkTheme", "priorityQueue"]
}
```

---

#### 3.4. Check Feature Unlocked
**Endpoint**: `GET /iap/non-consumables/check/{featureType}`  
**Description**: Kiểm tra 1 tính năng cụ thể đã unlock chưa

**Request**: None (featureType trong URL)

**Response**:
```json
{
  "success": true,
  "message": "Feature status retrieved",
  "data": true
}
```

---

#### 3.5. Unlock Feature
**Endpoint**: `POST /iap/non-consumables/unlock`  
**Description**: Unlock tính năng (sau khi verify purchase thành công)

**Request**:
```json
{
  "featureType": "removeAds",
  "purchaseId": "GPA.1234-5678-9012-34567"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Feature unlocked successfully",
  "data": null
}
```

---

### 4. GENERAL APIs

#### 4.1. Complete Purchase
**Endpoint**: `POST /iap/purchases/complete`  
**Description**: Đánh dấu purchase đã hoàn tất (sau khi app complete với store)

**Request**:
```json
{
  "purchaseId": "GPA.1234-5678-9012-34567",
  "productId": "com.delivery.premium.monthly",
  "status": "completed"
}
```

**Response**:
```json
{
  "success": true,
  "message": "Purchase completed",
  "data": null
}
```

---

#### 4.2. Restore All Purchases
**Endpoint**: `POST /iap/purchases/restore`  
**Description**: Khôi phục tất cả purchases (subscriptions + non-consumables)

**Request**:
```json
{
  "platform": "ios",
  "receipts": ["...", "..."]
}
```

**Response**:
```json
{
  "success": true,
  "message": "Purchases restored",
  "data": [
    {
      "purchaseId": "GPA.1234-5678-9012-34567",
      "productId": "com.delivery.premium.monthly",
      "transactionDate": "2026-04-02T10:30:00Z",
      "status": "verified",
      "pendingCompletePurchase": false
    }
  ]
}
```

---

## 🔒 Security & Validation

### 1. Receipt Verification
Backend PHẢI verify receipt với App Store/Google Play server trước khi cấp quyền lợi:

**iOS**:
- Gửi receipt data đến Apple server: `https://buy.itunes.apple.com/verifyReceipt`
- Sandbox: `https://sandbox.itunes.apple.com/verifyReceipt`

**Android**:
- Sử dụng Google Play Developer API
- Verify purchase token với Google Play server

### 2. Prevent Fraud
- Luôn verify receipt server-side, KHÔNG tin vào client
- Check purchase status, expiry date từ store server
- Lưu purchase history để tránh duplicate
- Implement rate limiting

### 3. Idempotency
- API verify purchase phải idempotent (gọi nhiều lần cùng receipt không tạo duplicate)
- Sử dụng purchaseId/transactionId làm unique key

---

## 📊 Database Schema (Suggested)

### Table: `user_subscriptions`
```sql
CREATE TABLE user_subscriptions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  product_id VARCHAR(255) NOT NULL,
  tier VARCHAR(50) NOT NULL,
  purchase_id VARCHAR(255) UNIQUE NOT NULL,
  platform VARCHAR(20) NOT NULL,
  is_active BOOLEAN DEFAULT true,
  expiry_date TIMESTAMP,
  is_auto_renewing BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Table: `user_credits`
```sql
CREATE TABLE user_credits (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL UNIQUE,
  balance INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Table: `user_credit_transactions`
```sql
CREATE TABLE user_credit_transactions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  amount INT NOT NULL,
  type ENUM('add', 'deduct') NOT NULL,
  balance_after INT NOT NULL,
  reason VARCHAR(255),
  reference_id VARCHAR(255), -- orderId, purchaseId, etc
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Table: `user_vouchers`
```sql
CREATE TABLE user_vouchers (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  voucher_id VARCHAR(255) UNIQUE NOT NULL,
  type VARCHAR(50) NOT NULL,
  value DECIMAL(10,2) NOT NULL,
  code VARCHAR(50),
  expiry_date TIMESTAMP,
  is_used BOOLEAN DEFAULT false,
  used_at TIMESTAMP NULL,
  order_id VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Table: `user_unlocked_features`
```sql
CREATE TABLE user_unlocked_features (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  feature_type VARCHAR(50) NOT NULL,
  product_id VARCHAR(255) NOT NULL,
  purchase_id VARCHAR(255) NOT NULL,
  unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_user_feature (user_id, feature_type),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Table: `purchase_history`
```sql
CREATE TABLE purchase_history (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  purchase_id VARCHAR(255) UNIQUE NOT NULL,
  product_id VARCHAR(255) NOT NULL,
  product_type ENUM('subscription', 'consumable', 'nonConsumable') NOT NULL,
  platform VARCHAR(20) NOT NULL,
  transaction_date TIMESTAMP NOT NULL,
  status VARCHAR(50) NOT NULL,
  receipt_data TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## 🧪 Testing

### Test Cases
1. **Happy Path**: Verify purchase thành công
2. **Invalid Receipt**: Receipt không hợp lệ
3. **Expired Subscription**: Subscription hết hạn
4. **Insufficient Credits**: User không đủ credits
5. **Duplicate Purchase**: Gọi verify nhiều lần cùng receipt
6. **Restore**: Restore purchases thành công

---

## 📞 Support

Nếu có thắc mắc về API implementation, liên hệ team mobile để clarify.

---

**Ngày tạo**: 2 April 2026  
**Phiên bản**: 1.0  
**Tác giả**: Delivery App Team
