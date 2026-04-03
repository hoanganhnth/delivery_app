# 📱 DELIVERY APP - DANH SÁCH MÀN HÌNH & CHỨC NĂNG

> **Mục đích:** Tài liệu này dành cho Designer/Frontend Developer để chỉnh sửa UI theo từng chức năng.
> 
> **Cập nhật lần cuối:** 02/04/2026

---

## 📋 MỤC LỤC

1. [Authentication (Xác thực)](#1-authentication-xác-thực)
2. [Main Navigation (Điều hướng chính)](#2-main-navigation-điều-hướng-chính)
3. [Home (Trang chủ)](#3-home-trang-chủ)
4. [Restaurants (Nhà hàng)](#4-restaurants-nhà-hàng)
5. [Cart (Giỏ hàng)](#5-cart-giỏ-hàng)
6. [Orders (Đơn hàng)](#6-orders-đơn-hàng)
7. [Profile (Hồ sơ)](#7-profile-hồ-sơ)
8. [Settings (Cài đặt)](#8-settings-cài-đặt)
9. [User Address (Địa chỉ)](#9-user-address-địa-chỉ)
10. [Support (Hỗ trợ)](#10-support-hỗ-trợ)
11. [Livestream](#11-livestream)
12. [In-App Purchase (IAP)](#12-in-app-purchase-iap)

---

## 1. AUTHENTICATION (Xác thực)

### 1.1 Login Screen - Màn hình đăng nhập
**File:** `lib/features/auth/presentation/screens/login_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Nhập email | Người dùng nhập email đăng nhập | `TextFormField` với icon email |
| 2 | Nhập password | Người dùng nhập mật khẩu | `TextFormField` với ẩn/hiện password |
| 3 | Đăng nhập | Gửi thông tin đăng nhập | `ElevatedButton` |
| 4 | Đăng nhập bằng sinh trắc học | Đăng nhập bằng vân tay/Face ID | `IconButton` với icon fingerprint |
| 5 | Quên mật khẩu | Chuyển đến màn quên mật khẩu | `TextButton` |
| 6 | Đăng ký | Chuyển đến màn đăng ký | `TextButton` |
| 7 | Hiển thị loading | Khi đang xử lý đăng nhập | `CircularProgressIndicator` |
| 8 | Hiển thị lỗi | Thông báo lỗi đăng nhập | `Toast` (SnackBar) |

**Trạng thái (States):**
- Loading state (đang đăng nhập)
- Error state (đăng nhập thất bại)
- Biometric available/unavailable

---

### 1.2 Register Screen - Màn hình đăng ký
**File:** `lib/features/auth/presentation/screens/register_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Nhập họ tên | Người dùng nhập tên đầy đủ | `TextFormField` |
| 2 | Nhập email | Người dùng nhập email | `TextFormField` |
| 3 | Nhập mật khẩu | Người dùng nhập mật khẩu | `TextFormField` |
| 4 | Xác nhận mật khẩu | Nhập lại mật khẩu | `TextFormField` |
| 5 | Đăng ký | Tạo tài khoản mới | `ElevatedButton` |
| 6 | Quay lại đăng nhập | Chuyển về màn login | `TextButton` |

---

### 1.3 Forgot Password Screen - Màn hình quên mật khẩu
**File:** `lib/features/auth/presentation/screens/forgot_password_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Nhập email | Người dùng nhập email đã đăng ký | `TextFormField` |
| 2 | Gửi yêu cầu reset | Gửi email reset password | `ElevatedButton` |
| 3 | Quay lại đăng nhập | Chuyển về màn login | `TextButton` |

---

## 2. MAIN NAVIGATION (Điều hướng chính)

### 2.1 Main Screen - Màn hình chính
**File:** `lib/features/main/presentation/pages/main_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Tab Home | Chuyển đến trang chủ | `GNav` tab |
| 2 | Tab Cart | Chuyển đến giỏ hàng | `GNav` tab |
| 3 | Tab Orders | Chuyển đến lịch sử đơn hàng | `GNav` tab |
| 4 | Tab Profile | Chuyển đến hồ sơ | `GNav` tab |

**Bottom Navigation Bar:** Google Nav Bar (`google_nav_bar` package)

---

## 3. HOME (Trang chủ)

### 3.1 Home Page - Trang chủ
**File:** `lib/features/home/presentation/pages/home_page.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Search bar | Thanh tìm kiếm món ăn/quán ăn | `Container` với icon search |
| 2 | Banner quảng cáo | Hiển thị banner khuyến mãi | `Container` với gradient |
| 3 | Danh sách danh mục | Các loại món ăn | `Horizontal ListView` |
| 4 | Nhà hàng nổi bật | Danh sách nhà hàng được đề xuất | `RestaurantHomeSection` widget |
| 5 | Livestream section | Các livestream đang diễn ra | `LivestreamHomeSection` widget |
| 6 | Notification icon | Mở thông báo | `IconButton` trên AppBar |
| 7 | Cart icon | Mở giỏ hàng | `IconButton` trên AppBar |

**Widgets con:**
- `RestaurantHomeSection` - Hiển thị danh sách nhà hàng
- `LivestreamHomeSection` - Hiển thị danh sách livestream

---

## 4. RESTAURANTS (Nhà hàng)

### 4.1 All Restaurants Screen - Danh sách tất cả nhà hàng
**File:** `lib/features/restaurants/presentation/screens/all_restaurants_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Danh sách nhà hàng | Hiển thị tất cả nhà hàng | `ListView` |
| 2 | Card nhà hàng | Thông tin nhà hàng (ảnh, tên, rating) | `RestaurantCard` widget |
| 3 | Pull to refresh | Kéo để làm mới danh sách | `RefreshIndicator` |
| 4 | Nhấn vào nhà hàng | Xem chi tiết nhà hàng | `GestureDetector` |

---

### 4.2 Restaurant Detail Screen - Chi tiết nhà hàng
**File:** `lib/features/restaurants/presentation/screens/restaurant_detail_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Header ảnh nhà hàng | Ảnh cover của nhà hàng | `SliverAppBar` với `FlexibleSpaceBar` |
| 2 | Nút quay lại | Quay về màn trước | `IconButton` |
| 3 | Nút yêu thích | Thêm nhà hàng vào yêu thích | `IconButton` (heart icon) |
| 4 | Nút chia sẻ | Chia sẻ nhà hàng | `IconButton` (share icon) |
| 5 | Thông tin nhà hàng | Tên, địa chỉ, rating, thời gian mở cửa | `Column` với `Text` widgets |
| 6 | Danh sách menu | Các món ăn của nhà hàng | `SliverList` với `MenuItemCard` |
| 7 | Nút thêm vào giỏ | Thêm món vào giỏ hàng | Trong `MenuItemCard` |
| 8 | Floating cart summary | Hiện số lượng và tổng tiền giỏ hàng | `Positioned` bottom widget |
| 9 | Loading state | Đang tải dữ liệu | `CircularProgressIndicator` |
| 10 | Error state | Hiển thị lỗi | `Text` với màu đỏ |

---

### 4.3 Menu Screen - Màn hình menu
**File:** `lib/features/restaurants/presentation/screens/menu_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Danh sách món ăn | Hiển thị menu theo category | `ListView` |
| 2 | Filter theo danh mục | Lọc món theo loại | `TabBar` hoặc `Chips` |
| 3 | Chi tiết món | Tên, mô tả, giá, ảnh | `MenuItemCard` widget |

---

## 5. CART (Giỏ hàng)

### 5.1 Cart Screen/Page - Màn hình giỏ hàng
**File:** `lib/features/cart/presentation/screens/cart_screen.dart`
**File:** `lib/features/cart/presentation/pages/cart_page.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Header | Tiêu đề "Giỏ hàng" | `AppBar` |
| 2 | Nút xóa tất cả | Xóa toàn bộ giỏ hàng | `IconButton` (delete icon) |
| 3 | Thông tin nhà hàng | Tên nhà hàng đang đặt | `Container` với icon |
| 4 | Danh sách sản phẩm | Các món trong giỏ | `SliverList` |
| 5 | Item giỏ hàng | Ảnh, tên, giá, số lượng | `CartItemWidget` |
| 6 | Tăng số lượng | Tăng số lượng món | `IconButton` (+) |
| 7 | Giảm số lượng | Giảm số lượng món | `IconButton` (-) |
| 8 | Xóa sản phẩm | Xóa món khỏi giỏ | `IconButton` (delete) hoặc swipe |
| 9 | Tổng tiền | Hiển thị tổng giá trị | `Text` bold |
| 10 | Nút thanh toán | Chuyển đến checkout | `ElevatedButton` |
| 11 | Giỏ hàng trống | Hiển thị khi không có món | `EmptyCartWidget` |
| 12 | Loading state | Đang tải giỏ hàng | `CircularProgressIndicator` |

---

### 5.2 Checkout Screen - Màn hình thanh toán
**File:** `lib/features/cart/presentation/screens/checkout_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Header | Tiêu đề "Thanh toán" | `AppBar` với nút đóng |
| 2 | Địa chỉ giao hàng | Hiển thị/chọn địa chỉ | `AddressSelectionWidget` |
| 3 | Phương thức thanh toán | Chọn cách thanh toán | `PaymentMethodWidget` |
| 4 | Danh sách món | Tóm tắt các món đã chọn | `ListView` |
| 5 | Áp dụng voucher | Nhập mã giảm giá | `TextField` với nút áp dụng |
| 6 | Chi tiết giá | Tạm tính, phí ship, giảm giá, tổng | `Column` với `Row` widgets |
| 7 | Nút đặt hàng | Hoàn tất đặt hàng | `ElevatedButton` |
| 8 | Loading khi đặt | Đang xử lý đơn hàng | `CircularProgressIndicator` |

---

### 5.3 Payment Screen - Màn hình thanh toán
**File:** `lib/features/cart/presentation/screens/payment_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Chọn phương thức | Cash, Card, E-wallet | `ListTile` với `Radio` |
| 2 | Thêm thẻ mới | Nhập thông tin thẻ | `Form` với các `TextField` |
| 3 | Xác nhận thanh toán | Hoàn tất thanh toán | `ElevatedButton` |

---

### 5.4 Order Confirmation Screen - Màn hình xác nhận đơn hàng
**File:** `lib/features/cart/presentation/screens/order_confirmation_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Icon thành công | Hiển thị check mark | `Icon` với animation |
| 2 | Thông báo thành công | "Đặt hàng thành công" | `Text` |
| 3 | Mã đơn hàng | Hiển thị order ID | `Text` |
| 4 | Nút xem đơn hàng | Chuyển đến chi tiết đơn | `ElevatedButton` |
| 5 | Nút về trang chủ | Quay về home | `OutlinedButton` |

---

## 6. ORDERS (Đơn hàng)

### 6.1 Orders Screen - Danh sách đơn hàng
**File:** `lib/features/orders/presentation/screens/orders_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Tab bar | Lọc theo trạng thái (Tất cả, Đang chờ, Đang giao, Đã giao) | `TabBar` với 4 tabs |
| 2 | Danh sách đơn hàng | Hiển thị các đơn hàng | `OrdersList` widget |
| 3 | Card đơn hàng | Thông tin đơn (ID, ngày, trạng thái, tổng tiền) | `OrderCard` widget |
| 4 | Pull to refresh | Kéo để làm mới | `RefreshIndicator` |
| 5 | Nhấn vào đơn | Xem chi tiết đơn hàng | `GestureDetector` |
| 6 | Trạng thái trống | Không có đơn hàng | `OrdersEmptyState` widget |
| 7 | Trạng thái lỗi | Hiển thị lỗi và nút retry | `OrdersErrorState` widget |
| 8 | Hủy đơn hàng | Dialog xác nhận hủy | `CancelOrderDialog` |

---

### 6.2 Order Detail Screen - Chi tiết đơn hàng
**File:** `lib/features/orders/presentation/screens/order_detail_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Header | "Đơn hàng #ID" | `AppBar` |
| 2 | Card trạng thái | Hiển thị trạng thái đơn hàng | `OrderStatusCard` |
| 3 | Tracking giao hàng | Bản đồ theo dõi shipper (khi đang giao) | `OrderDeliveryTrackingCard` |
| 4 | Thông tin khách hàng | Tên, SĐT, địa chỉ | `OrderCustomerInfoCard` |
| 5 | Danh sách món | Các món trong đơn | `OrderItemsCard` |
| 6 | Chi tiết thanh toán | Tạm tính, ship, giảm giá, tổng | `OrderPaymentCard` |
| 7 | Nút hành động | Hủy đơn, Đặt lại, v.v. | `OrderActionButtons` |
| 8 | Pull to refresh | Kéo để làm mới | `RefreshIndicator` |
| 9 | Loading state | Đang tải | `CircularProgressIndicator` |
| 10 | Error state | Hiển thị lỗi | `OrderErrorWidget` |

---

### 6.3 Track Order Screen - Theo dõi đơn hàng
**File:** `lib/features/orders/presentation/screens/track_order_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Trạng thái giao hàng | "Đơn hàng đang được giao" | `Card` với icon |
| 2 | Thời gian dự kiến | "Dự kiến 15-20 phút" | `Text` |
| 3 | Timeline theo dõi | Các bước: Xác nhận → Chuẩn bị → Sẵn sàng → Đang giao → Đã giao | `ListView` với `ListTile` |
| 4 | Step indicator | Icon check/pending cho từng bước | `Icon` |
| 5 | Thời gian từng bước | Thời gian hoàn thành | `Text` |

---

## 7. PROFILE (Hồ sơ)

### 7.1 Profile Page - Trang hồ sơ cá nhân
**File:** `lib/features/profile/presentation/pages/profile_page.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Avatar | Ảnh đại diện người dùng | `CircleAvatar` |
| 2 | Tên người dùng | Hiển thị tên đầy đủ | `Text` bold |
| 3 | Email | Hiển thị email | `Text` |
| 4 | Menu Hỗ trợ khách hàng | Chuyển đến chat support | `ListTile` |
| 5 | Menu Tài khoản | Chỉnh sửa thông tin tài khoản | `ListTile` |
| 6 | Menu Lịch sử đơn hàng | Xem lịch sử đơn | `ListTile` |
| 7 | Menu Địa chỉ | Quản lý địa chỉ giao hàng | `ListTile` |
| 8 | Menu Cài đặt | Chuyển đến settings | `ListTile` |
| 9 | Nút đăng xuất | Đăng xuất tài khoản | `ElevatedButton` màu đỏ |

---

## 8. SETTINGS (Cài đặt)

### 8.1 Settings Screen - Màn hình cài đặt
**File:** `lib/features/settings/presentation/screens/settings_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Toggle thông báo | Bật/tắt thông báo | `ListTile` với `Switch` |
| 2 | Chọn ngôn ngữ | Thay đổi ngôn ngữ app | `ListTile` với subtitle |
| 3 | Toggle Dark Mode | Bật/tắt chế độ tối | `ListTile` với `Switch` |
| 4 | About | Thông tin về app | `ListTile` |

---

### 8.2 Theme Settings Screen - Cài đặt giao diện
**File:** `lib/features/settings/presentation/screens/theme_settings_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Chọn theme | Light/Dark/System | `RadioListTile` |
| 2 | Preview theme | Xem trước giao diện | Preview widget |

---

## 9. USER ADDRESS (Địa chỉ)

### 9.1 Address List Screen - Danh sách địa chỉ
**File:** `lib/features/user_address/presentation/screens/address_list_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Header | "Địa chỉ của tôi" | `AppBar` |
| 2 | Nút thêm địa chỉ | Mở form thêm địa chỉ | `IconButton` (+) |
| 3 | Danh sách địa chỉ | Hiển thị các địa chỉ đã lưu | `ListView` |
| 4 | Card địa chỉ | Label, tên, SĐT, địa chỉ | `AddressItemWidget` |
| 5 | Badge mặc định | Đánh dấu địa chỉ mặc định | `Chip` |
| 6 | Nút sửa | Chỉnh sửa địa chỉ | `IconButton` |
| 7 | Nút xóa | Xóa địa chỉ | `IconButton` với confirm dialog |
| 8 | Đặt làm mặc định | Set địa chỉ làm mặc định | `PopupMenuItem` |
| 9 | Trạng thái trống | Không có địa chỉ | Empty state widget |
| 10 | Loading | Đang tải danh sách | `CircularProgressIndicator` |

---

### 9.2 Add/Edit Address Screen - Thêm/Sửa địa chỉ
**File:** `lib/features/user_address/presentation/screens/add_edit_address_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Input nhãn | Tên gợi nhớ (Nhà, Công ty...) | `TextFormField` |
| 2 | Input tên người nhận | Họ tên người nhận | `TextFormField` |
| 3 | Input số điện thoại | SĐT liên hệ | `TextFormField` |
| 4 | Input địa chỉ | Số nhà, tên đường | `TextFormField` |
| 5 | Input phường/xã | Phường/Xã | `TextFormField` |
| 6 | Input quận/huyện | Quận/Huyện | `TextFormField` |
| 7 | Input tỉnh/thành phố | Tỉnh/Thành phố | `TextFormField` |
| 8 | Nút lấy vị trí GPS | Tự động điền địa chỉ từ GPS | `ElevatedButton` với icon location |
| 9 | Checkbox mặc định | Đặt làm địa chỉ mặc định | `Checkbox` |
| 10 | Nút lưu | Lưu địa chỉ | `ElevatedButton` |
| 11 | Validation | Hiển thị lỗi validation | Error text dưới mỗi field |

---

## 10. SUPPORT (Hỗ trợ)

### 10.1 Support Chat Screen - Chat hỗ trợ khách hàng
**File:** `lib/features/support/presentation/screens/support_chat_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Header | Tiêu đề với avatar CSKH | `AppBar` |
| 2 | Nút kết thúc chat | Đóng cuộc hội thoại | `IconButton` với confirm dialog |
| 3 | Danh sách tin nhắn | Hiển thị tin nhắn chat | `ChatMessageListWidget` |
| 4 | Bubble tin nhắn | Tin nhắn người dùng/CSKH | `ChatBubble` widget |
| 5 | Thời gian tin nhắn | Hiển thị thời gian gửi | `Text` |
| 6 | Input tin nhắn | Nhập tin nhắn | `TextField` |
| 7 | Nút gửi | Gửi tin nhắn | `IconButton` (send) |
| 8 | Nút đính kèm ảnh | Gửi ảnh | `IconButton` (attach) |
| 9 | Typing indicator | Hiển thị khi CSKH đang gõ | Animation dots |
| 10 | Quick replies | Các câu trả lời nhanh | `Chips` |
| 11 | Bắt đầu chat mới | Tạo cuộc hội thoại mới | `Button` |

---

## 11. LIVESTREAM

### 11.1 All Livestreams Screen - Danh sách livestream
**File:** `lib/features/livestream/presentation/screens/all_livestreams_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Danh sách livestream | Hiển thị các livestream đang diễn ra | `GridView` hoặc `ListView` |
| 2 | Card livestream | Thumbnail, tiêu đề, số người xem | `LivestreamCard` widget |
| 3 | Badge LIVE | Hiển thị đang phát trực tiếp | `Container` với text "LIVE" |
| 4 | Số người xem | Hiển thị viewer count | `Row` với icon và text |
| 5 | Pull to refresh | Kéo để làm mới | `RefreshIndicator` |

---

### 11.2 Livestream Detail Screen - Xem livestream
**File:** `lib/features/livestream/presentation/screens/livestream_detail_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Video player | Phát video livestream (Agora RTC) | `AgoraVideoView` |
| 2 | Overlay thông tin | Tên host, số người xem | `Positioned` overlay |
| 3 | Nút đóng | Thoát livestream | `IconButton` (close) |
| 4 | Danh sách comment | Hiển thị bình luận realtime | `ListView` scroll tự động |
| 5 | Input comment | Nhập bình luận | `TextField` |
| 6 | Nút gửi comment | Gửi bình luận | `IconButton` |
| 7 | Nút like | Thả tim/like | `IconButton` với animation |
| 8 | Like animation | Hiệu ứng tim bay | `LivestreamLikeAnimation` |
| 9 | Nút xem sản phẩm | Mở danh sách sản phẩm | `IconButton` (shopping bag) |
| 10 | Product sheet | Bottom sheet sản phẩm | `LivestreamProductSheet` |
| 11 | Nút mua ngay | Thêm sản phẩm vào giỏ | `ElevatedButton` |

---

## 12. IN-APP PURCHASE (IAP)

### 12.1 IAP Store Screen - Cửa hàng IAP
**File:** `lib/features/iap/presentation/screens/iap_store_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Tab Subscriptions | Chuyển đến gói đăng ký | `TabBar` |
| 2 | Tab Consumables | Chuyển đến vật phẩm tiêu hao | `TabBar` |
| 3 | Tab Non-consumables | Chuyển đến tính năng mở khóa | `TabBar` |

---

### 12.2 Subscription Screen - Màn hình đăng ký gói
**File:** `lib/features/iap/presentation/screens/subscription_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Card gói hiện tại | Hiển thị gói đang sử dụng | `ActiveSubscriptionCard` |
| 2 | Danh sách gói | Các gói subscription | `ListView` |
| 3 | Card gói | Tên gói, giá, tính năng | `TierCard` widget |
| 4 | Badge "Popular" | Đánh dấu gói phổ biến | `Badge` widget |
| 5 | Nút đăng ký | Mua gói subscription | `ElevatedButton` |
| 6 | Nút khôi phục | Khôi phục giao dịch | `TextButton` |
| 7 | Loading state | Đang xử lý mua | `CircularProgressIndicator` |

---

### 12.3 Consumable Screen - Màn hình vật phẩm tiêu hao
**File:** `lib/features/iap/presentation/screens/consumable_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Số dư credits | Hiển thị credits hiện có | `Card` với số |
| 2 | Danh sách gói credits | Các gói mua thêm credits | `GridView` |
| 3 | Card sản phẩm | Số credits, giá | `ProductCard` |
| 4 | Nút mua | Mua sản phẩm | `ElevatedButton` |

---

### 12.4 Non-Consumable Screen - Màn hình tính năng mở khóa
**File:** `lib/features/iap/presentation/screens/non_consumable_screen.dart`

| # | Chức năng | Mô tả | UI Components |
|---|-----------|-------|---------------|
| 1 | Danh sách tính năng | Các tính năng có thể mở khóa | `ListView` |
| 2 | Card tính năng | Icon, tên, mô tả, giá | `FeatureCard` |
| 3 | Badge "Đã mở khóa" | Tính năng đã mua | `Chip` |
| 4 | Nút mở khóa | Mua tính năng | `ElevatedButton` |

---

## 📁 CẤU TRÚC THƯ MỤC THAM KHẢO

```
lib/features/
├── auth/presentation/screens/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   └── forgot_password_screen.dart
├── home/presentation/pages/
│   └── home_page.dart
├── main/presentation/pages/
│   └── main_screen.dart
├── restaurants/presentation/screens/
│   ├── all_restaurants_screen.dart
│   ├── restaurant_detail_screen.dart
│   └── menu_screen.dart
├── cart/presentation/
│   ├── pages/cart_page.dart
│   └── screens/
│       ├── cart_screen.dart
│       ├── checkout_screen.dart
│       ├── payment_screen.dart
│       └── order_confirmation_screen.dart
├── orders/presentation/screens/
│   ├── orders_screen.dart
│   ├── order_detail_screen.dart
│   └── track_order_screen.dart
├── profile/presentation/
│   ├── pages/profile_page.dart
│   └── screens/profile_screen.dart
├── settings/presentation/screens/
│   ├── settings_screen.dart
│   └── theme_settings_screen.dart
├── user_address/presentation/screens/
│   ├── address_list_screen.dart
│   └── add_edit_address_screen.dart
├── support/presentation/screens/
│   └── support_chat_screen.dart
├── livestream/presentation/screens/
│   ├── all_livestreams_screen.dart
│   └── livestream_detail_screen.dart
└── iap/presentation/screens/
    ├── iap_store_screen.dart
    ├── subscription_screen.dart
    ├── consumable_screen.dart
    └── non_consumable_screen.dart
```

---

## 🎨 GHI CHÚ CHO DESIGNER

### Quy tắc màu sắc hiện tại:
- **Primary color:** Orange (`Colors.orange`)
- **Error color:** Red (`Colors.red`)
- **Success color:** Green (`Colors.green`)
- **Background:** Sử dụng theme system

### Responsive:
- Sử dụng `flutter_screenutil` cho responsive
- Tất cả dimension dùng `.w`, `.h`, `.sp`

### Theme:
- Hỗ trợ Light/Dark mode
- Sử dụng `context.colors` để truy cập màu theo theme
- Xem file `lib/core/theme/` để biết chi tiết

### Localization:
- Sử dụng `S.of(context).keyName` cho text
- File ARB: `lib/l10n/`

---

> **Lưu ý:** Khi chỉnh sửa UI, vui lòng giữ nguyên tên các widget chính và structure của provider để không ảnh hưởng đến logic.
