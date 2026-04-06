# Implementation Plan - Stitch Design to Flutter

## 🎯 Phase 1: Theme & Foundation (1-2 days)

### 1.1 Update Theme System
- [ ] Add Plus Jakarta Sans font to `pubspec.yaml`
- [ ] Update `app_colors.dart` với Material 3 color palette
- [ ] Add custom shadows (`editorial-shadow`)
- [ ] Update border radius constants (2rem = 32px, 2.5rem = 40px)
- [ ] Add backdrop blur utilities

**Files to modify:**
- `lib/core/theme/app_colors.dart`
- `lib/core/theme/app_text_styles.dart`
- `lib/core/theme/app_dimensions.dart`
- `pubspec.yaml`

### 1.2 Create Reusable Widgets
- [ ] `LiveIndicatorBadge` - Animated red badge with pulse
- [ ] `GlassmorphicCard` - Backdrop blur container
- [ ] `EditorialShadowCard` - Custom shadow wrapper
- [ ] `CategoryPill` - Rounded pill button
- [ ] `TypingIndicator` - 3-dot animation

**New files:**
- `lib/core/widgets/live_indicator_badge.dart`
- `lib/core/widgets/glassmorphic_card.dart`
- `lib/core/widgets/editorial_shadow_card.dart`
- `lib/core/widgets/category_pill.dart`
- `lib/core/widgets/typing_indicator.dart`

---

## 🎯 Phase 2: Livestream Feature (2-3 days)

### 2.1 Update Livestream List Screen
**File:** `lib/features/livestream/presentation/screens/all_livestreams_screen.dart`

**Changes:**
- [ ] Replace AppBar with custom TopAppBar (profile avatar + search)
- [ ] Add Editorial Header section
  - Decorative line (`h-2 w-8 bg-primary rounded-full`)
  - Title: "The Kitchen Pulse" (text-4xl, font-black, tracking-tighter)
  - Subtitle
- [ ] Create Featured Bento Card (420px height, rounded-[2.5rem])
  - Live badge with animation
  - Viewer count overlay
  - Chef info + CTA button
- [ ] Add Category horizontal scroll
- [ ] Update grid layout to staggered design (translate-y offsets)
- [ ] Replace bottom nav with dark floating pill

**Widgets to create:**
- `EditorialHeader` widget
- `FeaturedLivestreamCard` widget (large bento style)
- `LivestreamCardGrid` widget (staggered 3:4 aspect ratio)

### 2.2 Update Livestream Detail Screen
**File:** `lib/features/livestream/presentation/screens/livestream_detail_screen.dart`

**Changes:**
- [ ] Full screen video background with vignette overlay
- [ ] Glassmorphic top header
  - Back button (backdrop-blur)
  - Chef info card (backdrop-blur-xl)
  - Premium badge
  - Share button
- [ ] Floating product card (glassmorphism)
  - Product image with discount badge
  - Add to cart button
- [ ] Scrolling chat overlay (mask-fade-top)
- [ ] Interaction buttons (like, share, gift)

**Widgets to create:**
- `LivestreamVideoPlayer` wrapper
- `GlassmorphicProductCard`
- `LiveChatOverlay` with scrolling messages
- `VignetteOverlay` gradient widget

### 2.3 Update Livestream Card Widgets
**Files:**
- `lib/features/livestream/presentation/widgets/livestream_card_grid.dart`
- `lib/features/livestream/presentation/widgets/livestream_card_horizontal.dart`

**Changes:**
- [ ] Update to 3:4 aspect ratio
- [ ] Rounded corners: 2rem (32px)
- [ ] Add hover scale effect (1.05x)
- [ ] Live badge top-left
- [ ] Host info bottom-left with backdrop blur
- [ ] Add editorial shadow

---

## 🎯 Phase 3: Support Feature (1-2 days)

### 3.1 Update Support Chat Screen
**File:** `lib/features/support/presentation/screens/support_chat_screen.dart`

**Changes:**
- [ ] Update TopAppBar
  - Order number + subtitle
  - Support specialist avatar (border-2 border-primary)
- [ ] Update message bubbles
  - Support: left-aligned, rounded-tl-none, icon badge
  - User: right-aligned, bg-primary, rounded-tr-none
  - Timestamps: text-[10px]
- [ ] Add date divider (bg-surface-container, rounded-full)
- [ ] Add typing indicator
- [ ] Add contextual card với watermark icon
- [ ] Update input bar (rounded-full, backdrop-blur)

**Widgets to update:**
- `ChatMessageList` - New bubble styles
- `ChatInputWidget` - Rounded-full design với backdrop blur

---

## 🎯 Phase 4: Navigation & Polish (1 day)

### 4.1 Update Bottom Navigation
**File:** `lib/features/main/presentation/pages/main_screen.dart`

**Changes:**
- [ ] Replace current nav với dark floating pill
- [ ] Position: `fixed bottom-6`
- [ ] Style: `bg-stone-900/95 backdrop-blur-lg rounded-full`
- [ ] Active state: `bg-white/10 text-orange-500`
- [ ] Max width: responsive (max-w-md mx-auto)

### 4.2 Create Dark Bottom Nav Widget
**New file:** `lib/core/widgets/dark_bottom_nav_bar.dart`

**Features:**
- Dark background with blur
- Floating pill design
- Amber active state
- Material Symbols icons

---

## 🎯 Phase 5: Testing & Refinement (1 day)

- [ ] Test all screens on different devices
- [ ] Verify animations (pulse, scale, fade)
- [ ] Check backdrop blur performance
- [ ] Validate color contrast (WCAG)
- [ ] Test dark mode compatibility
- [ ] Verify accessibility (screen readers)

---

## 📦 Dependencies to Add

```yaml
# pubspec.yaml additions

# Fonts
flutter:
  fonts:
    - family: Plus Jakarta Sans
      fonts:
        - asset: assets/fonts/PlusJakartaSans-Regular.ttf
        - asset: assets/fonts/PlusJakartaSans-Medium.ttf
          weight: 500
        - asset: assets/fonts/PlusJakartaSans-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/PlusJakartaSans-Bold.ttf
          weight: 700
        - asset: assets/fonts/PlusJakartaSans-ExtraBold.ttf
          weight: 800
        - asset: assets/fonts/PlusJakartaSans-Black.ttf
          weight: 900


# Blur effects (if needed beyond BackdropFilter)
  flutter_glassmorphism: ^3.0.0
```

---

## 🎨 Color Mapping (Flutter)

```dart
// lib/core/theme/app_colors.dart

class AppColors {
  // Primary
  static const Color primary = Color(0xFFF49D25);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFEDD5);
  static const Color onPrimaryContainer = Color(0xFFD6810D);
  
  // Secondary
  static const Color secondary = Color(0xFF9C7A49);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFECB94);
  
  // Tertiary (Live/Error)
  static const Color tertiary = Color(0xFFBA1A1A);
  static const Color tertiaryContainer = Color(0xFFFFDAD6);
  
  // Surface
  static const Color background = Color(0xFFF8F7F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFF4EEE7);
  static const Color surfaceContainerHigh = Color(0xFFEDE7E0);
  static const Color surfaceContainerHighest = Color(0xFFE6E0D9);
  
  // Text
  static const Color onSurface = Color(0xFF1C160D);
  static const Color onSurfaceVariant = Color(0xFF9C7A49);
  
  // Outline
  static const Color outline = Color(0xFFD9C3AE);
  static const Color outlineVariant = Color(0xFFF4EEE7);
}
```

---

## 📏 Dimensions Mapping

```dart
// lib/core/theme/app_dimensions.dart

class AppDimensions {
  // Border Radius
  static const double radiusXS = 4.0;   // DEFAULT
  static const double radiusSM = 8.0;   // lg
  static const double radiusMD = 12.0;  // xl
  static const double radiusLG = 16.0;  // 2xl
  static const double radiusXL = 32.0;  // 2rem (editorial)
  static const double radiusXXL = 40.0; // 2.5rem (featured card)
  static const double radiusFull = 9999.0;
  
  // Spacing
  static const double spacing2XS = 4.0;
  static const double spacingXS = 8.0;
  static const double spacingSM = 12.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacing2XL = 48.0;
}
```

---

## ✅ Checklist Summary

### Must Have (MVP)
- [x] Download HTML designs ✓
- [x] Analyze design patterns ✓
- [ ] Update theme colors & fonts
- [ ] Create LiveIndicatorBadge
- [ ] Create GlassmorphicCard
- [ ] Update all_livestreams_screen
- [ ] Update livestream_detail_screen
- [ ] Update support_chat_screen
- [ ] Create dark bottom nav

### Nice to Have
- [ ] Staggered grid animation
- [ ] Product card quick view
- [ ] Chat emoji reactions
- [ ] Smooth page transitions
- [ ] Pull to refresh
- [ ] Skeleton loaders

### Future Enhancements
- [ ] Real-time chat with WebSocket
- [ ] Video player controls
- [ ] Live reactions animation
- [ ] Gift sending UI
- [ ] Multi-language support for new UI

---

## 🚀 Estimated Timeline

| Phase | Duration | Priority |
|-------|----------|----------|
| Phase 1: Theme & Foundation | 1-2 days | HIGH |
| Phase 2: Livestream Feature | 2-3 days | HIGH |
| Phase 3: Support Feature | 1-2 days | MEDIUM |
| Phase 4: Navigation | 1 day | MEDIUM |
| Phase 5: Testing | 1 day | HIGH |
| **TOTAL** | **6-9 days** | - |

---

## 📝 Notes

- Stitch designs use Tailwind CSS classes - convert to Flutter widgets
- Backdrop blur có performance impact - test on low-end devices
- Material Symbols icons - use `Icons` class hoặc custom icon font
- Animation delays (animate-pulse) - use `AnimationController` với delays
- Vignette overlay - use `DecoratedBox` với `LinearGradient`
