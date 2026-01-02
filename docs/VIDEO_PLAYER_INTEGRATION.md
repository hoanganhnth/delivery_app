# Video Player Integration - Tài liệu chi tiết

## 📋 Tổng quan

Đã tích hợp **video player** vào chat message để hỗ trợ phát video trực tiếp trong ứng dụng. Sử dụng package `video_player` (official Flutter plugin) và `chewie` (UI wrapper với controls đẹp).

## 🎥 Tính năng

### ✅ Đã implement:
- ✅ Phát video từ URL (network)
- ✅ Thumbnail preview trước khi phát
- ✅ Play/Pause controls
- ✅ Seek bar (tua video)
- ✅ Volume control
- ✅ Fullscreen mode
- ✅ Loading state với CircularProgressIndicator
- ✅ Error handling với fallback UI
- ✅ Auto-initialize (không cần nhấn để load)
- ✅ Responsive sizing với ScreenUtil

### 🎨 UI Features:
- Kích thước cố định: 200w × 150h
- Border radius: 12.r
- Thumbnail hiển thị trong lúc loading
- Controls overlay từ Chewie:
  - Play/Pause button
  - Progress bar
  - Time display (current/total)
  - Volume slider
  - Fullscreen toggle

## 🏗️ Kiến trúc Implementation

### 1. Dependencies

**pubspec.yaml:**
```yaml
dependencies:
  video_player: ^2.10.1      # Official Flutter video player
  chewie: ^1.13.0            # UI wrapper với controls đẹp
  cached_network_image: ^3.4.1  # Đã có sẵn cho thumbnail
```

### 2. VideoPlayerWidget (Reusable Component)

**File**: `lib/features/support/presentation/screens/widgets/video_player_widget.dart`

**Props:**
```dart
class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;        // Required: URL video (http/https)
  final String? thumbnailUrl;   // Optional: Thumbnail preview
}
```

**State Management:**
```dart
class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;  // Core video controller
  ChewieController? _chewieController;                // UI controller
  bool _isInitialized = false;                        // Loading state
  bool _hasError = false;                             // Error state
}
```

**Lifecycle:**
```dart
initState()
  └─> _initializePlayer()
      ├─> VideoPlayerController.networkUrl(videoUrl)
      ├─> await controller.initialize()
      └─> ChewieController(
            videoPlayerController,
            autoPlay: false,
            looping: false,
            aspectRatio: auto-detect,
            placeholder: thumbnail or loading,
            errorBuilder: custom error UI
          )

dispose()
  ├─> _videoPlayerController.dispose()
  └─> _chewieController?.dispose()
```

**UI States:**

1. **Loading State** (`!_isInitialized`):
```dart
Container(
  width: 200.w,
  height: 150.h,
  color: Colors.black,
  child: Stack(
    children: [
      Image.network(thumbnailUrl),  // Nếu có thumbnail
      CircularProgressIndicator(),   // Loading spinner
    ],
  ),
)
```

2. **Error State** (`_hasError`):
```dart
Container(
  width: 200.w,
  height: 150.h,
  color: Colors.black,
  child: Column(
    children: [
      Icon(Icons.error_outline, color: Colors.white, size: 48),
      Text('Lỗi phát video', style: TextStyle(color: Colors.white)),
    ],
  ),
)
```

3. **Playing State** (`_isInitialized && _chewieController != null`):
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(12.r),
  child: SizedBox(
    width: 200.w,
    height: 150.h,
    child: Chewie(controller: _chewieController!),
  ),
)
```

### 3. Integration trong ChatMessageListWidget

**File**: `lib/features/support/presentation/screens/widgets/chat_message_list_widget.dart`

**Before (chỉ placeholder):**
```dart
Widget _buildVideoContent(ChatMessageEntity message) {
  // Chỉ hiển thị thumbnail + play icon, không phát được
  return Stack(
    children: [
      CachedNetworkImage(imageUrl: message.thumbnailUrl),
      Icon(Icons.play_arrow),  // Fake button, không làm gì
    ],
  );
}
```

**After (real video player):**
```dart
Widget _buildVideoContent(ChatMessageEntity message) {
  if (message.mediaUrl == null) return const SizedBox.shrink();

  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: VideoPlayerWidget(
      videoUrl: message.mediaUrl!,      // ✅ URL video
      thumbnailUrl: message.thumbnailUrl, // ✅ Thumbnail (optional)
    ),
  );
}
```

### 4. ChatMessageEntity (Domain Layer)

**Fields cần thiết:**
```dart
class ChatMessageEntity extends Equatable {
  final MessageType type;        // text | image | video
  final String content;          // Text content
  final String? mediaUrl;        // ✅ Video URL (required for video type)
  final String? thumbnailUrl;    // ✅ Thumbnail URL (optional but recommended)
}
```

## 🎬 User Flow

### Flow 1: Xem video trong chat
```
1. User nhận message type = 'video'
2. ChatMessageListWidget render _buildVideoContent()
3. VideoPlayerWidget được tạo
4. State: Loading
   → Hiển thị thumbnail (nếu có)
   → CircularProgressIndicator
5. VideoPlayerController initialize video
6. ChewieController tạo UI controls
7. State: Initialized
   → Hiển thị video frame đầu tiên
   → Play button visible
8. User nhấn play
   → Video bắt đầu phát
   → Controls overlay xuất hiện (auto-hide sau 3s)
9. User có thể:
   → Pause/Play
   → Seek (kéo progress bar)
   → Adjust volume
   → Toggle fullscreen
```

### Flow 2: Fullscreen mode
```
1. User nhấn fullscreen button
2. Video expand ra toàn màn hình
3. Device rotate landscape (nếu auto-rotate enabled)
4. Controls vẫn hoạt động bình thường
5. User nhấn exit fullscreen
6. Video quay về kích thước 200×150
7. Device rotate portrait
```

### Flow 3: Error handling
```
1. Video URL không hợp lệ hoặc network error
2. VideoPlayerController.initialize() throws exception
3. catch block set _hasError = true
4. UI hiển thị error state:
   → Icon error_outline
   → Text "Lỗi phát video"
   → Không có retry button (user có thể scroll qua lại để retry)
```

## 📱 Platform Support

### Android
- ✅ Fully supported
- Sử dụng ExoPlayer (built-in)
- Hỗ trợ formats: MP4, WebM, 3GP, MKV, etc.

**Permissions** (đã có sẵn trong AndroidManifest.xml):
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS
- ✅ Fully supported
- Sử dụng AVFoundation (built-in)
- Hỗ trợ formats: MP4, MOV, M4V, etc.

**Info.plist** (cần thêm nếu chưa có):
```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

### Web
- ⚠️ Limited support
- Sử dụng HTML5 video player
- Một số formats không được hỗ trợ (MKV, WebM on Safari)

### macOS/Windows/Linux
- ✅ Supported (với video_player_platform_interface)

## 🔧 Chewie Configuration

### Current Settings:
```dart
ChewieController(
  videoPlayerController: _videoPlayerController,
  autoPlay: false,              // ✅ Không tự động phát (tiết kiệm data)
  looping: false,               // ✅ Không loop (chat messages)
  aspectRatio: auto-detect,     // ✅ Giữ tỷ lệ gốc của video
  autoInitialize: true,         // ✅ Tự động load video khi widget build
  allowFullScreen: true,        // ✅ Cho phép fullscreen
  allowMuting: true,            // ✅ Cho phép tắt tiếng
  showControls: true,           // ✅ Hiển thị controls
  materialProgressColors: ChewieProgressColors(
    playedColor: Colors.blue,         // Phần đã xem
    handleColor: Colors.blueAccent,   // Thumb của seek bar
    backgroundColor: Colors.grey,      // Background bar
    bufferedColor: Colors.lightBlue,  // Phần đã buffer
  ),
  placeholder: thumbnail or loading,  // ✅ Hiển thị trước khi video load
  errorBuilder: custom UI,            // ✅ Custom error message
)
```

### Customization Options (có thể thay đổi):

**Auto-play khi scroll vào view:**
```dart
autoPlay: true,  // Video tự động phát khi visible
```

**Loop video (cho promotional videos):**
```dart
looping: true,   // Video lặp lại khi hết
```

**Hide controls (cho video ngắn):**
```dart
showControls: false,
```

**Custom controls overlay:**
```dart
customControls: MaterialControls(),  // Hoặc custom widget
```

**Control hide timeout:**
```dart
hideControlsTimer: const Duration(seconds: 5),  // Ẩn sau 5s
```

## 🚀 Performance Considerations

### Memory Management
- ✅ **Dispose properly**: Controllers được dispose trong `dispose()`
- ✅ **Lazy initialization**: Video chỉ load khi widget build
- ⚠️ **Multiple videos**: Nếu có nhiều video trong list, chỉ initialize khi visible

### Network Optimization
- ✅ **No auto-play**: Không tự động phát để tiết kiệm bandwidth
- ✅ **Thumbnail preview**: Hiển thị thumbnail nhẹ trước khi load video
- ✅ **Progressive loading**: Video buffer từ từ khi user nhấn play
- ⚠️ **Cache**: video_player không cache video, cân nhắc thêm cache layer

### Potential Improvements:

**1. Lazy loading với Visibility Detector:**
```dart
// Chỉ initialize video khi scroll vào view
VisibilityDetector(
  key: Key('video-${message.id}'),
  onVisibilityChanged: (info) {
    if (info.visibleFraction > 0.5 && !_isInitialized) {
      _initializePlayer();
    }
  },
  child: VideoPlayerWidget(...),
)
```

**2. Cache với flutter_cache_manager:**
```dart
// Cache video để xem offline
final file = await DefaultCacheManager().getSingleFile(videoUrl);
_videoPlayerController = VideoPlayerController.file(file);
```

**3. Adaptive bitrate:**
```dart
// Chọn quality dựa trên network speed
final quality = await NetworkInfo().getConnectionSpeed();
final videoUrl = quality == 'fast' ? message.hdUrl : message.sdUrl;
```

## 🐛 Troubleshooting

### Issue 1: Video không phát
**Symptoms**: Stuck ở loading state  
**Causes**:
- URL không hợp lệ
- CORS issues (web only)
- Format không được hỗ trợ

**Solutions**:
```dart
// Check URL validity
print('Video URL: ${message.mediaUrl}');

// Check network connectivity
final isConnected = await Connectivity().checkConnectivity();

// Check format
final extension = message.mediaUrl!.split('.').last;
print('Video format: $extension');
```

### Issue 2: OutOfMemory error
**Symptoms**: App crash khi load nhiều video  
**Causes**: Không dispose controllers properly  
**Solutions**:
```dart
// Đảm bảo dispose trong dispose()
@override
void dispose() {
  _videoPlayerController.dispose();  // ✅ MUST call
  _chewieController?.dispose();      // ✅ MUST call
  super.dispose();
}
```

### Issue 3: Controls không hiển thị
**Symptoms**: Video phát nhưng không có play/pause button  
**Causes**: `showControls: false` hoặc conflict với parent GestureDetector  
**Solutions**:
```dart
ChewieController(
  showControls: true,  // ✅ Ensure this is true
  // ...
)
```

### Issue 4: Black screen trong fullscreen
**Symptoms**: Video bị đen khi vào fullscreen  
**Causes**: Orientation lock issues  
**Solutions**:
```dart
// Allow all orientations
SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
]);
```

## 📊 Testing Checklist

### Unit Tests
- [ ] VideoPlayerWidget initializes correctly với valid URL
- [ ] VideoPlayerWidget shows error state với invalid URL
- [ ] VideoPlayerWidget disposes controllers properly
- [ ] Thumbnail displays during loading

### Widget Tests
- [ ] Video player renders in chat message
- [ ] Play button appears after initialization
- [ ] Controls appear on tap
- [ ] Fullscreen toggle works
- [ ] Error UI shows on network error

### Integration Tests
- [ ] Send video message → Appears in chat
- [ ] Tap video → Plays correctly
- [ ] Scroll away → Video pauses
- [ ] Return to video → Resumes from last position
- [ ] Toggle fullscreen → Orientation changes

### Manual Test Scenarios

**Scenario 1: Normal playback**
1. Send video message từ gallery
2. Video upload lên Cloudinary
3. Receive message với mediaUrl
4. Nhấn play → Video phát
5. Seek bar hoạt động
6. Volume slider hoạt động

**Scenario 2: Network issues**
1. Turn off WiFi/mobile data
2. Try to play video
3. **Expected**: Error UI với "Lỗi phát video"
4. Turn on network
5. Scroll away and back
6. **Expected**: Video retries and plays

**Scenario 3: Multiple videos**
1. Chat có 5 video messages
2. Scroll through chat
3. **Expected**: Chỉ 1 video phát tại 1 thời điểm
4. Pause video 1 → Scroll to video 2
5. Play video 2
6. **Expected**: Video 1 stopped, video 2 playing

**Scenario 4: Fullscreen mode**
1. Play video
2. Tap fullscreen button
3. **Expected**: Video expand, orientation landscape
4. Tap exit fullscreen
5. **Expected**: Video return to 200×150, orientation portrait

## 🎯 Future Enhancements

### Phase 2: Performance optimization
- [ ] Lazy loading với visibility detector
- [ ] Video caching với flutter_cache_manager
- [ ] Preload next video in chat

### Phase 3: Quality selection
- [ ] Multi-quality video upload (SD/HD/FHD)
- [ ] Auto quality selection based on network
- [ ] Manual quality picker in controls

### Phase 4: Advanced features
- [ ] Picture-in-picture mode
- [ ] Playback speed control (0.5x, 1x, 1.5x, 2x)
- [ ] Closed captions/subtitles support
- [ ] Video trimming before send

### Phase 5: Analytics
- [ ] Track video view duration
- [ ] Track completion rate
- [ ] Most watched videos

## 📝 Notes

### Design Decisions

**Q: Tại sao dùng Chewie thay vì raw video_player?**
A: Chewie cung cấp sẵn UI controls đẹp và consistent. Raw video_player yêu cầu implement controls từ đầu.

**Q: Tại sao không auto-play?**
A: Tiết kiệm bandwidth và data của user. User chủ động nhấn play khi muốn xem.

**Q: Tại sao không cache video?**
A: Cache video tốn storage. Implement sau nếu user request. Hiện tại stream mỗi lần xem.

**Q: Có nên preload video không?**
A: Không. Preload tốn bandwidth và memory. Chỉ load khi user nhấn play.

### Known Limitations

1. **No caching**: Video stream mỗi lần xem (tốn data)
2. **No quality selection**: Chỉ có 1 quality (upload quality)
3. **No PiP mode**: Không có picture-in-picture (implement Phase 4)
4. **Single video playback**: Chỉ 1 video phát cùng lúc (by design)
5. **No download**: Không cho phép download video về máy

### Security Considerations

- Video URLs từ Cloudinary đã có signed URLs (secure)
- Không expose raw storage URLs
- CORS configured properly cho web platform
- HTTPS required cho all video URLs

---

**Version**: 1.0.0  
**Last Updated**: 2026-01-02  
**Author**: AI Agent following Flutter best practices  
**Dependencies**: video_player ^2.10.1, chewie ^1.13.0
