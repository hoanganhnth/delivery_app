# Support Feature

## 🎨 New Design (from Stitch)
**Reference:** `.stitch_designs/DESIGN_ANALYSIS.md`
- **Screen**: Customer Support
- **Style**: Clean chat UI, rounded bubbles, typing indicator

## ✅ Đã hoàn thành
- [x] Get or create conversation
- [x] Load initial messages
- [x] Load more messages (pagination)
- [x] Send text message
- [x] Send media message (image/video)
- [x] Stream messages (real-time)
- [x] Close conversation
- [x] Chat input widget
- [x] Message list widget
- [x] Video player widget
- [x] **SupportChatScreen** - editorial redesign ✅ NEW
- [x] **ChatMessageBubble** - gradient + tail effect ✅ NEW
- [x] **ChatInputBar** - pill shape + attachment menu ✅ NEW
- [x] **ChatDateDivider** - pill style date separator ✅ NEW

## 🎨 Stitch Redesign Progress
- [x] TopAppBar với gradient avatar + status ✅
- [x] Message bubbles với tail effect ✅
  - Support: left, rounded-bl-sm, gradient avatar
  - User: right, gradient primary, rounded-br-sm
- [x] Date divider (rounded-full pill) ✅
- [ ] Typing indicator (3-dot animation) - Widget created, need integration
- [ ] Contextual card với watermark
- [x] Input bar (pill shape, attachment menu) ✅

## 📄 Ghi chú
- Sử dụng Riverpod Generator, Clean Architecture
- Firebase Firestore cho real-time chat
- New design: Plus Jakarta Sans, max-w-[85%] bubbles
- Support icon: material-symbols support_agent
- Timestamps: text-[10px]
