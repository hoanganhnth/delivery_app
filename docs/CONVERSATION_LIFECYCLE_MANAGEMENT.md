# Conversation Lifecycle Management - Tài liệu chi tiết

## 📋 Tổng quan

Tính năng quản lý vòng đời hội thoại (Conversation Lifecycle) cho phép người dùng:
- ✅ Kết thúc hội thoại hỗ trợ khi đã giải quyết xong vấn đề
- ✅ Bắt đầu hội thoại mới khi có vấn đề mới cần hỗ trợ
- ✅ Xem trạng thái hội thoại (active/closed)
- ✅ Xem lý do đóng hội thoại và thời gian đóng

## 🏗️ Kiến trúc Implementation

### 1. Domain Layer (Business Logic)

#### **ConversationEntity** (`domain/entities/conversation_entity.dart`)
```dart
class ConversationEntity extends Equatable {
  final String id;
  final int userId;
  final ConversationStatus status; // active | closed
  final DateTime? closedAt;        // ✅ Thời gian đóng
  final String? closedBy;          // ✅ Ai đóng: 'user' | 'support'
  final String? closeReason;       // ✅ Lý do đóng
  
  // Helper methods
  bool get isActive => status == ConversationStatus.active;
  bool get isClosed => status == ConversationStatus.closed;
}
```

#### **CloseConversationUseCase** (`domain/usecases/close_conversation_usecase.dart`)
```dart
class CloseConversationUseCase {
  Future<Either<Failure, void>> call(
    String conversationId, {
    String closeReason = 'Đã giải quyết xong',
  }) {
    return repository.closeConversation(
      conversationId,
      closedBy: 'user',  // Luôn set 'user' khi người dùng đóng
      closeReason: closeReason,
    );
  }
}
```

#### **SupportRepository** (`domain/repositories/support_repository.dart`)
```dart
abstract class SupportRepository {
  Future<Either<Failure, void>> closeConversation(
    String conversationId, {
    required String closedBy,
    String? closeReason,
  });
}
```

### 2. Data Layer (Implementation)

#### **ConversationModel** (`data/models/conversation_model.dart`)
```dart
class ConversationModel {
  final Timestamp? closedAt;
  final String? closedBy;
  final String? closeReason;
  
  factory ConversationModel.fromFirestore(DocumentSnapshot doc) {
    return ConversationModel(
      closedAt: data['closedAt'] as Timestamp?,
      closedBy: data['closedBy'] as String?,
      closeReason: data['closeReason'] as String?,
      // ...
    );
  }
  
  ConversationEntity toEntity() {
    return ConversationEntity(
      closedAt: closedAt?.toDate(),
      closedBy: closedBy,
      closeReason: closeReason,
      // ...
    );
  }
}
```

#### **SupportRemoteDataSourceImpl** (`data/datasources/support_remote_datasource_impl.dart`)

**getOrCreateConversation()** - Lấy conversation active gần nhất:
```dart
Future<ConversationModel> getOrCreateConversation(
  int userId,
  String userEmail,
  String? userName,
) async {
  // Query conversation active gần nhất (theo updatedAt)
  final querySnapshot = await _firestore
      .collection('conversations')
      .where('userId', isEqualTo: userId)
      .where('status', isEqualTo: 'active')
      .orderBy('updatedAt', descending: true) // ✅ Lấy mới nhất
      .limit(1)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return ConversationModel.fromFirestore(querySnapshot.docs.first);
  }

  // Tạo conversation mới nếu không có active
  await conversationRef.set({
    'status': 'active',
    'closedAt': null,     // ✅ Khởi tạo null
    'closedBy': null,     // ✅ Khởi tạo null
    'closeReason': null,  // ✅ Khởi tạo null
    // ...
  });
}
```

**closeConversation()** - Đóng conversation với metadata:
```dart
Future<void> closeConversation(
  String conversationId, {
  required String closedBy,
  String? closeReason,
}) async {
  await _firestore.collection('conversations').doc(conversationId).update({
    'status': 'closed',
    'updatedAt': FieldValue.serverTimestamp(),
    'closedAt': FieldValue.serverTimestamp(),  // ✅ Thời gian đóng
    'closedBy': closedBy,                      // ✅ 'user' | 'support'
    'closeReason': closeReason ?? 'Đã giải quyết xong',
  });
}
```

#### **SupportRepositoryImpl** (`data/repositories/support_repository_impl.dart`)
```dart
class SupportRepositoryImpl implements SupportRepository {
  @override
  Future<Either<Failure, void>> closeConversation(
    String conversationId, {
    required String closedBy,
    String? closeReason,
  }) async {
    try {
      await remoteDataSource.closeConversation(
        conversationId,
        closedBy: closedBy,
        closeReason: closeReason,
      );
      return right(null);
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    }
  }
}
```

### 3. Presentation Layer (UI & State)

#### **ChatNotifier** (`presentation/providers/chat_notifier.dart`)

**closeConversation()** - Đóng conversation và update state:
```dart
Future<void> closeConversation({String? reason}) async {
  if (state.conversation == null) return;

  try {
    AppLogger.d('Closing conversation: ${state.conversation!.id}');
    
    final result = await _closeConversationUseCase(
      state.conversation!.id,
      closeReason: reason ?? 'Đã giải quyết xong',
    );

    result.fold(
      (failure) {
        AppLogger.e('Failed to close conversation: ${failure.message}');
        state = state.copyWith(errorMessage: failure.message);
      },
      (_) {
        AppLogger.i('Successfully closed conversation');
        
        // Update conversation status locally
        final updatedConversation = state.conversation!.copyWith(
          status: ConversationStatus.closed,
          updatedAt: DateTime.now(),
          closedAt: DateTime.now(),
          closedBy: 'user',
          closeReason: reason ?? 'Đã giải quyết xong',
        );
        
        state = state.copyWith(conversation: updatedConversation);
        
        // Cancel message subscription
        _messagesSubscription?.cancel();
      },
    );
  } catch (e) {
    AppLogger.e('Error closing conversation', e);
    state = state.copyWith(errorMessage: 'Không thể đóng cuộc hội thoại');
  }
}
```

**startNewConversation()** - Reset state và tạo conversation mới:
```dart
Future<void> startNewConversation(
  int userId,
  String userEmail,
  String? userName,
) async {
  // Reset state
  state = const ChatState();
  
  // Cancel old subscription
  _messagesSubscription?.cancel();
  
  // Initialize new chat (sẽ tạo conversation active mới)
  await initializeChat(userId, userEmail, userName);
}
```

#### **SupportChatScreen** (`presentation/screens/support_chat_screen.dart`)

**UI Components:**

1. **PopupMenuButton trong AppBar** - Hiển thị menu tùy theo trạng thái:
```dart
PopupMenuButton<String>(
  onSelected: (value) {
    if (value == 'close') {
      _showCloseConfirmationDialog();
    } else if (value == 'new') {
      _startNewConversation();
    }
  },
  itemBuilder: (context) {
    final conversation = chatState.conversation;
    
    // Nếu active → Hiển thị "Kết thúc hội thoại"
    if (conversation != null && conversation.isActive) {
      return [
        const PopupMenuItem(
          value: 'close',
          child: Row(
            children: [
              Icon(Icons.close, color: Colors.red),
              SizedBox(width: 8),
              Text('Kết thúc hội thoại'),
            ],
          ),
        ),
      ];
    }
    
    // Nếu closed → Hiển thị "Bắt đầu hội thoại mới"
    if (conversation != null && conversation.isClosed) {
      return [
        const PopupMenuItem(
          value: 'new',
          child: Row(
            children: [
              Icon(Icons.add_comment, color: Colors.green),
              SizedBox(width: 8),
              Text('Bắt đầu hội thoại mới'),
            ],
          ),
        ),
      ];
    }
    
    return [];
  },
)
```

2. **Banner cảnh báo khi conversation đã đóng**:
```dart
if (chatState.conversation?.isClosed == true)
  Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: context.colors.warning.withValues(alpha: 0.1),
      // ...
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: context.colors.warning),
        Expanded(
          child: Column(
            children: [
              Text('Hội thoại đã kết thúc'),
              if (chatState.conversation?.closeReason != null)
                Text(chatState.conversation!.closeReason!),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: _startNewConversation,
          icon: const Icon(Icons.add_comment),
          label: const Text('Tạo mới'),
        ),
      ],
    ),
  )
```

3. **Conditional Input Area**:
```dart
// Chỉ hiển thị input khi conversation đang active
if (chatState.hasConversation && chatState.conversation!.isActive) 
  const ChatInputWidget(),

// Hiển thị thông báo read-only khi closed
if (chatState.hasConversation && chatState.conversation!.isClosed)
  Container(
    child: Row(
      children: [
        Icon(Icons.lock_outline),
        Text('Hội thoại đã kết thúc. Nhấn nút menu để bắt đầu hội thoại mới.'),
      ],
    ),
  )
```

4. **Dialog xác nhận đóng**:
```dart
Future<void> _showCloseConfirmationDialog() async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Kết thúc hội thoại'),
      content: const Text(
        'Bạn có chắc muốn kết thúc hội thoại này? Bạn có thể bắt đầu hội thoại mới bất kỳ lúc nào.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.error,
          ),
          child: const Text('Kết thúc'),
        ),
      ],
    ),
  );

  if (confirmed == true && mounted) {
    await ref.read(chatNotifierProvider.notifier).closeConversation();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã kết thúc hội thoại'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
```

## 🔄 User Flows

### Flow 1: Đóng hội thoại
```
User nhấn menu (3 chấm) 
  → Chọn "Kết thúc hội thoại"
  → Dialog xác nhận xuất hiện
  → User nhấn "Kết thúc"
  → ChatNotifier.closeConversation() được gọi
  → CloseConversationUseCase thực thi
  → Repository update Firestore
  → State được update với conversation.isClosed = true
  → UI hiển thị banner cảnh báo
  → Input area bị ẩn, thay bằng thông báo read-only
  → SnackBar thông báo "Đã kết thúc hội thoại"
```

### Flow 2: Bắt đầu hội thoại mới
```
User nhấn nút "Tạo mới" trong banner HOẶC menu
  → ChatNotifier.startNewConversation() được gọi
  → State được reset về initial
  → Message subscription bị cancel
  → initializeChat() được gọi lại
  → getOrCreateConversation() tạo conversation active mới
  → Load 50 tin nhắn đầu tiên (rỗng cho conversation mới)
  → Start listening for new messages
  → UI update với conversation mới
  → Input area xuất hiện lại
  → SnackBar thông báo "Đã bắt đầu hội thoại mới"
```

### Flow 3: Vào màn hình chat
```
User mở SupportChatScreen
  → initializeChat() được gọi trong initState
  → getOrCreateConversation() query conversation active gần nhất
  
  Case A: Có conversation active
    → Load conversation và 50 tin nhắn gần nhất
    → Start listening for new messages
    → Hiển thị input area
  
  Case B: Không có conversation active (tất cả đã closed)
    → Tạo conversation mới
    → Load với 0 tin nhắn
    → Start listening
    → Hiển thị input area
```

## 🎨 UI States

### State 1: Conversation Active
- ✅ Menu hiển thị "Kết thúc hội thoại" (màu đỏ)
- ✅ Không có banner cảnh báo
- ✅ ChatInputWidget hiển thị bình thường
- ✅ User có thể gửi tin nhắn

### State 2: Conversation Closed
- ✅ Menu hiển thị "Bắt đầu hội thoại mới" (màu xanh)
- ✅ Banner cảnh báo màu vàng với thông tin:
  - "Hội thoại đã kết thúc"
  - Lý do đóng (nếu có)
  - Nút "Tạo mới"
- ✅ ChatInputWidget bị ẩn
- ✅ Thay bằng thông báo read-only với icon khóa
- ✅ User không thể gửi tin nhắn

## 🔧 Firestore Schema

### Collection: `conversations`

```json
{
  "id": "conversation_123",
  "userId": 456,
  "userEmail": "user@example.com",
  "userName": "John Doe",
  "status": "active",  // ✅ "active" | "closed"
  "createdAt": "2025-01-01T10:00:00Z",
  "updatedAt": "2025-01-01T10:30:00Z",
  "closedAt": "2025-01-01T10:30:00Z",  // ✅ null nếu active
  "closedBy": "user",                   // ✅ "user" | "support" | null
  "closeReason": "Đã giải quyết xong"  // ✅ String | null
}
```

### Required Firestore Index

**Collection**: `conversations`  
**Fields**:
- `userId` (Ascending)
- `status` (Ascending)
- `updatedAt` (Descending)

**Query pattern**:
```dart
_firestore
  .collection('conversations')
  .where('userId', isEqualTo: userId)
  .where('status', isEqualTo: 'active')
  .orderBy('updatedAt', descending: true)
  .limit(1)
```

**Tạo index**:
1. Chạy app và trigger query
2. Firebase sẽ báo lỗi với link tạo index
3. HOẶC thêm vào `firestore.indexes.json`:
```json
{
  "indexes": [
    {
      "collectionGroup": "conversations",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "updatedAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```

## ✅ Testing Checklist

### Unit Tests
- [ ] `CloseConversationUseCase.call()` returns Right on success
- [ ] `CloseConversationUseCase.call()` returns Left on failure
- [ ] `ChatNotifier.closeConversation()` updates state correctly
- [ ] `ChatNotifier.closeConversation()` cancels message subscription
- [ ] `ChatNotifier.startNewConversation()` resets state
- [ ] `ChatNotifier.startNewConversation()` initializes new chat

### Integration Tests
- [ ] Closing active conversation updates Firestore
- [ ] Closing conversation updates local state
- [ ] Starting new conversation creates new Firestore document
- [ ] getOrCreateConversation returns most recent active
- [ ] getOrCreateConversation creates new when all closed

### UI Tests
- [ ] Menu shows "Kết thúc" when conversation active
- [ ] Menu shows "Tạo mới" when conversation closed
- [ ] Banner appears when conversation closed
- [ ] Input is hidden when conversation closed
- [ ] Dialog appears when clicking "Kết thúc"
- [ ] SnackBar appears after closing
- [ ] SnackBar appears after starting new

### Manual Test Scenarios

**Scenario 1: Normal close flow**
1. Mở chat với conversation active
2. Nhấn menu → "Kết thúc hội thoại"
3. Xác nhận trong dialog
4. **Expected**: Banner xuất hiện, input ẩn, menu đổi thành "Tạo mới"

**Scenario 2: Reopen flow**
1. Conversation đã closed (từ Scenario 1)
2. Nhấn "Tạo mới" trong banner hoặc menu
3. **Expected**: Conversation mới được tạo, input xuất hiện, có thể gửi tin

**Scenario 3: Multiple conversations**
1. Tạo conversation 1 → Đóng
2. Tạo conversation 2 → Đóng
3. Mở chat lại
4. **Expected**: Tạo conversation 3 mới (không lấy 1 hoặc 2)

**Scenario 4: Cross-device sync**
1. Device A: Đóng conversation
2. Device B: Mở chat
3. **Expected**: Device B thấy conversation đã closed, hiển thị banner

## 🚀 Future Enhancements

### Phase 2: Admin features
- [ ] Admin có thể đóng conversation từ admin panel
- [ ] `closedBy: 'support'` khi admin đóng
- [ ] Hiển thị khác biệt giữa user đóng vs support đóng

### Phase 3: Conversation history
- [ ] Màn hình lịch sử conversation
- [ ] Filter: All / Active / Closed
- [ ] Xem lại tin nhắn của conversation đã đóng
- [ ] Reopen conversation cũ (chuyển status closed → active)

### Phase 4: Analytics
- [ ] Track average conversation duration
- [ ] Track close reasons (phân tích nguyên nhân)
- [ ] User satisfaction rating before close

### Phase 5: Auto-close
- [ ] Auto-close conversation sau 7 ngày không hoạt động
- [ ] Gửi notification trước khi auto-close
- [ ] `closedBy: 'system'` cho auto-close

## 📝 Notes

### Design Decisions

**Q: Tại sao không dùng soft delete?**
A: Status 'closed' rõ ràng hơn về mặt business logic. Soft delete (deletedAt) thường cho data cleanup, còn 'closed' cho lifecycle management.

**Q: Tại sao cần `orderBy('updatedAt')`?**
A: Đảm bảo lấy conversation active **gần nhất**. User có thể có nhiều active conversations (edge case), chúng ta ưu tiên cái mới nhất.

**Q: Có nên cho phép reopen conversation cũ không?**
A: Hiện tại không. Tạo conversation mới đơn giản hơn và tránh confusion. Feature reopen có thể thêm sau trong Phase 3.

**Q: Tại sao không validate closeReason?**
A: Hiện tại chỉ có default reason. Khi thêm multiple reasons (Phase 4), sẽ thêm validation enum.

### Known Limitations

1. **No conversation history UI**: User không thể xem lại conversation đã đóng (chỉ thấy current)
2. **No reopen old conversation**: Phải tạo mới hoàn toàn
3. **No notification**: Không có push notification khi conversation bị đóng từ phía support
4. **No rating system**: Không có feedback form trước khi đóng

### Performance Considerations

- Query `orderBy('updatedAt')` requires composite index → Đã documented
- Cancel subscription khi close để tránh memory leak → Đã implement
- Reset state khi start new để tránh stale data → Đã implement

---

**Version**: 1.0.0  
**Last Updated**: 2025-12-31  
**Author**: AI Agent following Clean Architecture patterns
