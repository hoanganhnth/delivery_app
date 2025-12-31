# Chat Pagination Implementation Guide

## ✅ **Đã implement:**

### 1. **ChatState** - Added pagination fields
- `isLoadingMore`: Loading indicator cho pagination
- `hasMoreMessages`: Còn tin nhắn cũ để load không
- `pageSize`: Số tin nhắn mỗi lần load (default: 50)
- `oldestMessage`: Getter để lấy tin nhắn cũ nhất
- `latestMessage`: Getter để lấy tin nhắn mới nhất

### 2. **SupportRemoteDataSource** - Added 3 new methods
```dart
// Load 50 tin nhắn mới nhất khi vào chat
Future<List<ChatMessageModel>> loadInitialMessages(String conversationId, {int limit = 50});

// Load thêm tin nhắn cũ hơn (pagination)
Future<List<ChatMessageModel>> loadMoreMessages(String conversationId, DateTime beforeTimestamp, {int limit = 50});

// Stream CHỈ tin nhắn MỚI (real-time)
Stream<ChatMessageModel> streamNewMessages(String conversationId, DateTime afterTimestamp);
```

### 3. **ChatNotifier** - Updated logic
- `initializeChat()`: Load 50 tin nhắn đầu tiên + start real-time listener
- `_listenToNewMessages()`: Chỉ nghe tin nhắn MỚI (không load lại toàn bộ)
- `loadMoreMessages()`: Load thêm 50 tin nhắn cũ khi scroll lên

## 📱 **Update UI để sử dụng:**

### Bước 1: Update ChatMessageListWidget

Thêm vào `chat_message_list_widget.dart`:

```dart
class ChatMessageListWidget extends ConsumerStatefulWidget {
  const ChatMessageListWidget({super.key});

  @override
  ConsumerState<ChatMessageListWidget> createState() => _ChatMessageListWidgetState();
}

class _ChatMessageListWidgetState extends ConsumerState<ChatMessageListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    // ✅ Listen to scroll để trigger load more
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ✅ Detect scroll to top → Load more
  void _onScroll() {
    if (_scrollController.position.pixels <= 200) {
      // Khi scroll gần đến top (còn 200px)
      ref.read(chatNotifierProvider.notifier).loadMoreMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatNotifierProvider);
    final messages = state.messages;

    if (messages.isEmpty && !state.isLoading) {
      return _buildEmptyState();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(16.w),
      itemCount: messages.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // ✅ Loading indicator ở top khi load more
        if (index == 0 && state.isLoadingMore) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        final messageIndex = state.isLoadingMore ? index - 1 : index;
        final message = messages[messageIndex];
        
        return _buildMessageBubble(context, message);
      },
    );
  }

  // ... existing _buildMessageBubble method
}
```

### Bước 2: Hoặc dùng NotificationListener (đơn giản hơn)

```dart
@override
Widget build(BuildContext context) {
  final state = ref.watch(chatNotifierProvider);
  
  return NotificationListener<ScrollNotification>(
    onNotification: (notification) {
      // Khi scroll gần đến top
      if (notification.metrics.pixels <= 200 && 
          !state.isLoadingMore && 
          state.hasMoreMessages) {
        ref.read(chatNotifierProvider.notifier).loadMoreMessages();
      }
      return false;
    },
    child: ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: state.messages.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Loading indicator at top
        if (index == 0 && state.isLoadingMore) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final messageIndex = state.isLoadingMore ? index - 1 : index;
        return _buildMessageBubble(state.messages[messageIndex]);
      },
    ),
  );
}
```

## 🎯 **How it works:**

### **1. User vào chat lần đầu:**
```
1. initializeChat() được gọi
2. Load 50 tin nhắn mới nhất từ Firestore
3. Display messages
4. Start real-time listener chỉ cho tin nhắn SAU tin cuối cùng
```

### **2. Có tin nhắn mới:**
```
1. Real-time listener emit tin nhắn mới
2. Thêm vào cuối list (không reload toàn bộ)
3. UI update instantly
```

### **3. User scroll lên:**
```
1. Khi scroll gần top (200px) → trigger loadMoreMessages()
2. Load thêm 50 tin nhắn CŨ HƠN (before oldest message timestamp)
3. Thêm vào ĐẦU list
4. Hiện loading indicator ở top trong khi load
```

## 📊 **Performance Benefits:**

### ❌ **Trước (stream toàn bộ):**
```
Initial: Stream 1000 messages (1MB)
New message: Re-stream 1001 messages (1MB) ← MỖI LẦN
Bandwidth: Vô hạn
```

### ✅ **Sau (pagination + real-time):**
```
Initial: Load 50 messages (50KB)
New message: Stream 1 message (1KB) ← Chỉ tin mới
Load more: Load 50 messages (50KB) ← Chỉ khi scroll
Bandwidth: Minimal, scalable
```

**Improvement: ~20x better!** 🚀

## 🧪 **Testing:**

1. **Test initial load:**
   - Vào chat → Should load 50 tin nhắn mới nhất
   - Check logs: "Loaded 50 initial messages"

2. **Test real-time:**
   - Gửi tin từ 2 devices
   - Tin mới xuất hiện ngay không cần reload
   - Check logs: "Received new message: xxx"

3. **Test pagination:**
   - Scroll lên top
   - Should load thêm 50 tin cũ
   - Check logs: "Loaded 50 more messages. Total: 100"

4. **Test end of messages:**
   - Scroll đến hết tin nhắn cũ
   - Should stop loading (hasMoreMessages = false)
   - Check logs: "No more messages to load"

## 🐛 **Troubleshooting:**

### **Load more không hoạt động?**
- Check `state.hasMoreMessages` = true?
- Check `state.isLoadingMore` = false? (không đang load)
- Check `state.oldestMessage` != null?

### **Real-time không work?**
- Check Firestore index đã tạo chưa (conversationId + timestamp)
- Check Firebase Rules allow read?
- Check listener có bị cancel không?

### **Duplicate messages?**
- Check logic thêm tin mới vào list
- Đảm bảo không add duplicate trong stream listener

## 🎉 **Next Steps:**

- [ ] Test với 100+ tin nhắn
- [ ] Add pull-to-refresh (optional)
- [ ] Add skeleton loading cho initial load
- [ ] Monitor Firestore reads trong Console
- [ ] Optimize với local caching (Hive/SQLite)
