# Amber Hearth Design System - Thay Đổi Chi Tiết

## Tổng Quan
Đã thiết kế lại splash screen và cập nhật toàn bộ theme system theo Amber Hearth Design System - một hệ thống thiết kế cao cấp mang phong cách editorial, kết hợp sự ấm áp của ẩm thực với trải nghiệm số hiện đại.

## 🎨 Thay Đổi Theme

### 1. app_colors.dart
**Màu Sắc Chính:**
- Primary: `#f49d25` (Amber) - Thay thế `#FF9800`
- Secondary: `#9c7a49` (Muted Umber) - Thay thế `#03DAC6`
- Background: `#f8f7f5` - Warm neutral thay vì `#F5F5F5`
- Text Secondary: `#9c7a49` - Warm muted thay vì grey `#757575`

**Đặc Điểm:**
- Bỏ màu xám lạnh, thay bằng tông ấm
- Shadow được tint bằng `#9c7a49` với alpha 0.08
- Border màu `#e8e4df` - tông ấm

### 2. app_text_styles.dart
**Typography Plus Jakarta Sans:**
- **Display:** 36px, Weight 900 (Black), letter-spacing -0.02
- **H1:** 30px, Weight 800 (ExtraBold), letter-spacing -0.02
- **H2-H6:** Weight 700-800 cho editorial impact
- **Body Medium:** 14px (0.875rem) - High legibility
- **Overline:** Letter-spacing 1.2 cho editorial feel

**Thay Đổi:**
- Font family: Thêm `fontFamily: 'PlusJakartaSans'`
- Tăng weight cho headlines (800-900)
- Negative letter-spacing cho display/h1
- Bỏ `.w` trong height (dùng số thẳng)

### 3. splash_screen.dart - THIẾT KẾ MỚI

**Gradient Background:**
```dart
LinearGradient(
  colors: [primary, primaryDark, Color(0xFFd97706)],
  begin: topLeft,
  end: bottomRight,
)
```

**Logo Glass Effect:**
- Kích thước: 140x140
- Backdrop blur: 8px
- White opacity: 0.2
- Amber-tinted shadow: `#9c7a49` alpha 0.3
- Border: White alpha 0.3

**Typography:**
- Tên app: 48px, Weight 900, white
- Tagline "URBAN HEARTH": 12px, uppercase, letter-spacing 2.5
- Footer: 14px, weight 600, letter-spacing 1.8

**Animations:**
- Duration: 2000ms (tăng từ 1500ms)
- 3 animations: fade, scale, slide
- Staggered timing với Interval

**Status Container:**
- Pill-shaped với backdrop blur
- White alpha 0.1 background
- Border white alpha 0.2
- Padding: 24x12

**Retry Button:**
- Background: white
- Foreground: primary color
- Padding: 32x16
- BorderRadius: 24 (pill-shaped)
- Amber-tinted shadow

## 📁 Files Đã Thay Đổi

1. `/lib/core/theme/app_colors.dart`
   - Cập nhật LightColors với Amber palette
   - Warm neutrals thay grey
   - Amber-tinted shadows

2. `/lib/core/theme/app_text_styles.dart`
   - Plus Jakarta Sans typography
   - Editorial weights (800-900)
   - Negative letter-spacing

3. `/lib/core/presentation/screens/splash_screen.dart`
   - Thiết kế mới hoàn toàn
   - Gradient background
   - Glass effect logo
   - Editorial typography
   - Soft stacking elevation

4. `/docs/AMBER_HEARTH_DESIGN_SYSTEM.md` (MỚI)
   - Tài liệu đầy đủ về design system
   - Usage examples
   - Design rules
   - Component guidelines

## ✅ Các Quy Tắc Thiết Kế Đã Áp Dụng

**DO's:**
- ✅ Plus Jakarta Sans weight 800-900 cho headlines
- ✅ Backdrop blur cho floating elements
- ✅ Rounded xl (0.75rem) trở lên cho interactive
- ✅ `#9c7a49` cho muted text (không dùng grey)
- ✅ Amber-tinted shadows
- ✅ Soft stacking elevation

**DON'Ts:**
- ❌ Không dùng sharp corners
- ❌ Không dùng grey cho text-muted
- ❌ Không dùng harsh drop shadows
- ❌ Không dùng pure black shadows

## 🚀 Chạy Thử

```bash
# Clean và rebuild
fvm flutter clean
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs

# Chạy app
fvm flutter run
```

## 📝 Next Steps

1. **Cập nhật các màn hình khác:**
   - Home screen với restaurant cards
   - Restaurant detail với image-first layout
   - Cart với pill-shaped buttons
   - Profile với warm color scheme

2. **Components cần thiết kế:**
   - Search bar (h-14, rounded-xl)
   - Category cards (16x16 icons, 2xl radius)
   - Restaurant cards (image-first, 500ms hover)
   - Promo banners (verified watermark)

3. **Font Setup:**
   - Download Plus Jakarta Sans
   - Add to `pubspec.yaml`
   - Configure font weights (400, 600, 700, 800, 900)

4. **Testing:**
   - Test theme switching
   - Verify color consistency
   - Check typography hierarchy
   - Validate shadow rendering

## 🎯 Kết Quả

- ✅ Splash screen đã được thiết kế lại hoàn toàn theo Amber Hearth
- ✅ Theme colors đồng bộ với design system
- ✅ Typography system với Plus Jakarta Sans
- ✅ Shadows được tint màu ấm
- ✅ Glass effects và backdrop blur
- ✅ Editorial typography với negative spacing
- ✅ Không có compile errors

**Thiết kế mới mang lại:**
- Cảm giác ấm áp, high-end
- Editorial aesthetic thay vì tech
- Warm color palette kích thích cảm giác ẩm thực
- Soft stacking thay harsh shadows
- Typography impact với heavy weights
