# Livestream Feature

## 🎨 New Design (from Stitch)
**Reference:** `.stitch_designs/DESIGN_ANALYSIS.md`
- **Screens**: Foodie Live - Dark Nav, Livestream Detail
- **Style**: Editorial with glassmorphism, dark bottom nav, Material 3 colors

## ✅ Đã hoàn thành
- [x] Danh sách livestreams (grid layout)
- [x] Chi tiết livestream với video player (Agora)
- [x] Real-time comments (Firebase)
- [x] Like animation
- [x] Product sheet overlay
- [x] Livestream home section widget
- [x] **Editorial header** với decorative line (`EditorialHeader`)
- [x] **LiveIndicatorBadge** - animated pulse badge
- [x] **LivestreamCardGrid** - editorial style với gradient overlay
- [x] **AllLivestreamsScreen** - staggered grid, category pills
- [x] **CategoryPill** widget với hover effect
- [x] **LivestreamDetailScreen** - glassmorphic UI redesign ✅ NEW

## 🎨 Stitch Redesign Progress
- [x] Editorial header với decorative line ✅
- [ ] Featured Bento card (420px, rounded-[2.5rem])
- [x] Staggered grid với hover effects ✅
- [x] Category pills (horizontal scroll) ✅
- [ ] Dark bottom navigation (floating pill)
- [x] Glassmorphic overlays (top bar, bottom controls) ✅
- [x] Comment section với fade gradient ✅
- [ ] Floating product card (GlassmorphicProductCard)

## 📄 Ghi chú
- Sử dụng Riverpod Generator, Clean Architecture
- Agora RTC Engine cho livestream
- Firebase Firestore cho comments real-time
- New design: Plus Jakarta Sans font, Material 3 palette
- Live indicator: Animated pulse (red #BA1A1A)
- Primary color: Amber #F49D25

Feature xem livestream với Agora RTC Engine cho ứng dụng Delivery.

## 📋 Tính năng

- ✅ **Widget danh sách livestream** theo hàng ngang ở Home page
- ✅ **Màn hình tất cả livestream** với grid 2 cột và infinite scroll
- ✅ **Màn hình chi tiết livestream** với:
  - Video player sử dụng Agora RTC Engine
  - Real-time comment với Firebase Firestore
  - Like animation (tim bay lên)
  - Bottom sheet hiển thị sản phẩm
  - Thêm sản phẩm vào giỏ hàng
  - Viewer count và like count real-time

## 🏗️ Kiến trúc

```
lib/features/livestream/
├── domain/
│   ├── entities/
│   │   ├── livestream_entity.dart
│   │   └── livestream_comment_entity.dart
│   ├── repositories/
│   │   ├── livestream_repository.dart
│   │   └── livestream_interaction_repository.dart
│   └── usecases/
│       ├── get_livestreams_usecase.dart
│       └── livestream_interaction_usecases.dart
├── data/
│   ├── dtos/
│   │   ├── livestream_dto.dart
│   │   └── livestream_comment_dto.dart
│   ├── datasources/
│   │   ├── livestream_remote_datasource_impl.dart (Retrofit)
│   │   └── livestream_firebase_datasource_impl.dart (Firestore)
│   └── repositories_impl/
│       ├── livestream_repository_impl.dart
│       └── livestream_interaction_repository_impl.dart
└── presentation/
    ├── providers/
    │   ├── livestream_state.dart
    │   ├── livestream_notifier.dart
    │   ├── livestream_detail_notifier.dart
    │   └── livestream_providers.dart
    ├── screens/
    │   ├── all_livestreams_screen.dart
    │   └── livestream_detail_screen.dart
    └── widgets/
        ├── livestream_home_section.dart
        ├── livestream_card_horizontal.dart
        ├── livestream_card_grid.dart
        ├── livestream_comment_item.dart
        ├── livestream_like_animation.dart
        └── livestream_product_sheet.dart
```

## 🚀 Cài đặt

### 1. Dependencies

Đã được thêm vào `pubspec.yaml`:
```yaml
dependencies:
  agora_rtc_engine: ^6.5.3
  permission_handler: ^11.3.1
  cloud_firestore: ^6.1.1
```

### 2. Cấu hình Agora

#### a. Tạo tài khoản Agora
1. Truy cập https://console.agora.io/
2. Đăng ký/Đăng nhập
3. Tạo project mới
4. Lấy **App ID** và **App Certificate**

#### b. Cập nhật config
Mở file `lib/core/config/agora_config.dart` và thay thế:
```dart
static const String appId = 'YOUR_AGORA_APP_ID'; // Thay bằng App ID của bạn
static const String appCertificate = 'YOUR_AGORA_APP_CERTIFICATE'; // Thay bằng App Certificate
```

### 3. Cấu hình Firebase

#### a. Firebase Console
1. Truy cập https://console.firebase.google.com/
2. Chọn project
3. Tạo Firestore Database
4. Thiết lập Security Rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Livestream collections
    match /livestreams/{livestreamId} {
      allow read: if true; // Public read
      
      // Comments subcollection
      match /comments/{commentId} {
        allow read: if true;
        allow write: if request.auth != null;
      }
      
      // Likes subcollection
      match /likes/{likeId} {
        allow read: if true;
        allow write: if request.auth != null;
      }
    }
  }
}
```

### 4. Cấu hình Permissions

#### iOS (ios/Runner/Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>Cần quyền camera để xem livestream</string>
<key>NSMicrophoneUsageDescription</key>
<string>Cần quyền microphone để tương tác trong livestream</string>
```

#### Android (android/app/src/main/AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
```

## 📱 Sử dụng

### 1. Hiển thị ở Home Page

Widget `LivestreamHomeSection` đã được thêm vào `HomePage`:

```dart
// lib/features/home/presentation/pages/home_page.dart
const LivestreamHomeSection(),
```

### 2. Navigation

Routes đã được thêm vào `app_router.dart`:
- `/livestreams` - Tất cả livestreams (grid view)
- `/livestream-detail/:id` - Chi tiết livestream

### 3. Xem Livestream

```dart
// Navigate to livestream detail
Navigator.pushNamed(
  context,
  '/livestream-detail',
  arguments: livestreamId,
);
```

## 🎨 UI Components

### LivestreamHomeSection
Widget hiển thị danh sách livestream ngang ở home page.

### LivestreamCardHorizontal
Card hiển thị livestream với thumbnail, LIVE badge, viewer count.

### LivestreamCardGrid
Card hiển thị livestream trong grid 2 cột.

### LivestreamDetailScreen
Màn hình chi tiết với:
- Video player (Agora)
- Comment list (real-time)
- Like animation
- Product sheet

## 🔄 Data Flow

### API Data (từ Server)
- Danh sách livestreams
- Chi tiết livestream
- Thông tin sản phẩm

### Firebase Data (Real-time)
- Comments
- Likes
- Viewer count updates

## 🧪 Testing

### Mock Data
Để test UI không cần API:

```dart
// Mock livestream
final mockLivestream = LivestreamEntity(
  id: 1,
  title: 'Test Livestream',
  streamerId: 'streamer123',
  streamerName: 'Test Streamer',
  channelName: 'test_channel',
  rtcToken: 'mock_token',
  uid: 0,
  description: 'Test description',
  viewerCount: 100,
  likeCount: 50,
  status: 'live',
  startTime: DateTime.now(),
);
```

## 📊 State Management

### Providers
- `livestreamNotifierProvider` - Danh sách livestreams
- `livestreamDetailNotifierProvider(id)` - Chi tiết livestream
- `livestreamInteractionNotifierProvider(id)` - Comments & likes

### States
- `LivestreamState` - List state
- `LivestreamDetailState` - Detail state
- `LivestreamInteractionState` - Interaction state

## 🐛 Troubleshooting

### Agora không connect
1. Kiểm tra App ID đúng chưa
2. Kiểm tra RTC Token còn hạn
3. Kiểm tra permissions đã được cấp

### Firebase không real-time
1. Kiểm tra Firestore rules
2. Kiểm tra internet connection
3. Check Firebase console logs

### Build errors
```bash
# Clean và rebuild
fvm flutter clean
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
```

## 📝 API Contract

### GET /livestreams
```json
{
  "status": 1,
  "message": "Success",
  "data": [
    {
      "id": 1,
      "title": "Livestream Title",
      "streamer_id": "streamer123",
      "streamer_name": "Streamer Name",
      "channel_name": "channel_123",
      "rtc_token": "agora_rtc_token",
      "uid": 0,
      "description": "Description",
      "viewer_count": 100,
      "like_count": 50,
      "status": "live",
      "thumbnail_url": "https://...",
      "start_time": "2026-02-03T10:00:00Z",
      "products": [...]
    }
  ]
}
```

## 🔐 Security

- ✅ RTC Token có expiration time
- ✅ Firebase rules authentication required cho write
- ✅ User authentication cho comment/like
- ✅ Rate limiting cho API calls

## 📚 Resources

- [Agora Documentation](https://docs.agora.io/)
- [Firebase Firestore](https://firebase.google.com/docs/firestore)
- [Flutter Riverpod](https://riverpod.dev/)

## 🎯 Roadmap

- [ ] Share livestream
- [ ] Pin comments
- [ ] Gift/Donate system
- [ ] Stream replay
- [ ] Stream scheduling
- [ ] Multi-host streaming
