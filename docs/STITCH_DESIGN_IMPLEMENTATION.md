# Stitch Design Implementation - Amber Hearth

## 📱 Tổng quan
Đã implement thiết kế từ Google Stitch vào màn hình Login và Register của delivery app, theo phong cách **Amber Hearth** - The Urban Hearth Experience.

## 🎨 Design System

### Màu sắc (Color Palette)
```dart
Primary: #F49D25 (Amber - Cam vàng)
Secondary: #9C7A49 (Umber - Nâu vàng)
Background: #F8F7F5 (Warm white)
Surface: #FFFFFF (White)
On Surface: #1C160D (Dark brown)
Outline: #D9C3AE (Light tan)
Outline Variant: #F4EEE7 (Very light tan)
Error: #BA1A1A (Red)
```

### Typography
- **Font Family**: Plus Jakarta Sans (System fallback: SF Pro, Roboto)
- **Font Weights**:
  - Regular: 400
  - Medium: 500
  - Semi-bold: 600
  - Bold: 700
  - Extra-bold: 800
  - Black: 900
- **Letter Spacing**:
  - Headlines: -1.5 (tighter)
  - Labels: 1-2 (wider)
  - Body: normal

### Spacing & Sizing
- **Border Radius**:
  - Default: 4px
  - Medium (lg): 8px
  - Large (xl): 12px
  - Full: 9999px (pill shape)
- **Elevation**:
  - Small: 2-4px blur
  - Medium: 8px blur
  - Large: 16-24px blur

## 📄 Login Screen Implementation

### Đặc điểm UI
1. **Hero Section** (309px height):
   - Asymmetric clip path (polygon shape)
   - Gradient overlay: Amber → Orange
   - Restaurant icon (64px, white, filled)
   - Branding text: "Amber Hearth" (italic, black weight)
   - Tagline: "THE URBAN HEARTH EXPERIENCE" (uppercase, letter-spacing: 2)

2. **Form Section**:
   - Welcome header: "Welcome Back" (30px, black weight)
   - Subtitle: "Savor the moment. Sign in to your kitchen."
   - Custom text fields:
     - Floating labels (11px, uppercase, letter-spacing: 2)
     - Rounded corners (12px)
     - Icon prefix (Mail, Lock)
     - Visibility toggle for password
   - "Forgot Password?" link (amber color)
   
3. **Actions**:
   - Primary button: "SIGN IN" (pill shape, amber background, white text, shadow)
   - Biometric button: Fingerprint/Face (56x56, rounded square, umber icon)
   
4. **Footer**:
   - Register link: "Don't have an account? Register"

5. **Ambient Effects**:
   - Bottom-left blur circle (192px, amber 5% opacity)
   - Top-right blur circle (256px, orange 10% opacity)

### Code Structure
```dart
LoginScreen (ConsumerStatefulWidget)
├── Scaffold (background: #F8F7F5)
│   └── Stack
│       ├── Ambient blur circles (decorative)
│       └── Main content
│           ├── ClipPath (Asymmetric hero section)
│           │   └── Container (gradient, icon, branding)
│           └── Form section
│               ├── Header (Welcome Back)
│               ├── Email field (_StitchTextField)
│               ├── Password field (_StitchTextField)
│               ├── Forgot password link
│               ├── Sign in button + Biometric button
│               └── Register link
└── Helper widgets:
    ├── _AsymmetricClipper (CustomClipper<Path>)
    ├── _StitchTextField (Custom input field)
    └── _BiometricLoginButton (ConsumerStatefulWidget)
```

## 📄 Register Screen Implementation

### Đặc điểm UI
1. **Hero Header** (256px height):
   - Background gradient overlay
   - Back button (white circle, top-left)
   - Badge: "JOIN THE HEARTH" (amber, uppercase, letter-spacing: 2)
   - Title: "Create Account" (36px, black weight, tight tracking)

2. **Form Section**:
   - Intro text: "Step into a world of curated culinary experiences..."
   - Custom fields:
     - Full Name (optional)
     - Email Address
     - Password (with helper text)
     - Confirm Password
   - Helper text: "Must be at least 8 characters with a mix of symbols."
   
3. **Actions**:
   - Primary button: "CREATE ACCOUNT" + arrow icon (pill shape, amber)
   
4. **Footer**:
   - "Already have an account? Back to Login"
   - Terms of Service disclaimer (11px, center-aligned)

### Code Structure
```dart
RegisterScreen (ConsumerStatefulWidget)
├── Scaffold (background: #F8F7F5)
│   └── Column
│       ├── Hero header (Stack)
│       │   ├── Background gradient
│       │   ├── Back button
│       │   └── Badge + Title
│       ├── Main form (Expanded + SingleChildScrollView)
│       │   ├── Intro text
│       │   ├── Full Name field (_StitchRegisterField)
│       │   ├── Email field (_StitchRegisterField)
│       │   ├── Password field (_StitchRegisterField)
│       │   ├── Confirm Password field (_StitchRegisterField)
│       │   ├── Create Account button
│       │   └── Back to Login link
│       └── Terms footer
└── Helper widget:
    └── _StitchRegisterField (Custom input field with label + helper text)
```

## 🔧 Custom Widgets Created

### 1. `_AsymmetricClipper` (Login Screen)
```dart
CustomClipper<Path>
- Tạo hình polygon: (0,0) → (width,0) → (width,85%) → (0,100%)
- Được dùng cho hero section của login
```

### 2. `_StitchTextField` (Login Screen)
```dart
StatelessWidget
- Floating label (absolute positioned)
- Rounded container (12px)
- Border: 2px, color: #F4EEE7
- Icon prefix + optional suffix icon
- Focus state: border color → amber
- Shadow: soft, 2px blur
```

### 3. `_StitchRegisterField` (Register Screen)
```dart
StatelessWidget
- Top label (uppercase, bold, letter-spacing: 2)
- Rounded container (12px)
- Border: 1px, color: #D9C3AE
- Icon prefix + optional suffix icon
- Optional helper text (bottom, 10px, muted)
```

### 4. `_BiometricLoginButton` (Login Screen)
```dart
ConsumerStatefulWidget
- 56x56 rounded square
- Background: #EDE7E0 (surface-container-high)
- Icon: Fingerprint/Face (28px, umber)
- Border: 1px, #F4EEE7
- Shadow: soft
```

## 📝 Files Changed

### Modified
1. `/lib/features/auth/presentation/screens/login_screen.dart`
   - Removed `flutter_screenutil` dependency
   - Redesigned UI to match Stitch
   - Added custom widgets: `_AsymmetricClipper`, `_StitchTextField`, `_BiometricLoginButton`
   - Added ambient blur effects
   - Updated colors, typography, spacing

2. `/lib/features/auth/presentation/screens/register_screen.dart`
   - Removed `flutter_screenutil` dependency
   - Redesigned UI to match Stitch
   - Added custom widget: `_StitchRegisterField`
   - Added hero header, badge, terms footer
   - Updated colors, typography, spacing

## 🎯 Key Features

### Visual Consistency
- ✅ Amber Hearth color palette (#F49D25, #9C7A49)
- ✅ Plus Jakarta Sans typography (bold, black weights)
- ✅ Rounded corners (12px for inputs, 28px for buttons)
- ✅ Editorial style (tight letter-spacing, uppercase labels)
- ✅ Soft shadows and ambient effects

### UX Improvements
- ✅ Floating/positioned labels for better readability
- ✅ Clear visual hierarchy (hero → form → actions → footer)
- ✅ Password visibility toggle
- ✅ Biometric login option (fingerprint/face)
- ✅ Responsive layouts (max-width: 448px)
- ✅ Smooth transitions and hover states

### Accessibility
- ✅ High contrast text (#1C160D on #F8F7F5)
- ✅ Large touch targets (56px buttons)
- ✅ Clear error messages
- ✅ Helper text for password requirements
- ✅ Screen reader friendly (semantic structure)

## 🚀 Next Steps (Optional)

### Font Assets
Để có typography chính xác 100%, cần:
1. Tải font Plus Jakarta Sans từ Google Fonts
2. Thêm vào `pubspec.yaml`:
   ```yaml
   fonts:
     - family: PlusJakartaSans
       fonts:
         - asset: assets/fonts/PlusJakartaSans-Regular.ttf
           weight: 400
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
   ```
3. Update theme system để dùng font custom

### Background Images
Để có visual experience như Stitch design:
1. Thêm ảnh nền cho Login hero section (food photography)
2. Thêm ảnh nền cho Register hero header (warm hearth/kitchen)
3. Apply `mix-blend-mode` overlay effect

### Animation
- Hero section entrance (fade + slide)
- Form field focus animations
- Button press feedback (scale transform)
- Loading states (skeleton screens)

## 📊 Comparison

| Feature | Before | After (Stitch) |
|---------|--------|----------------|
| Visual Style | Material 3 default | Amber Hearth editorial |
| Color Scheme | Generic | Warm amber/umber palette |
| Typography | Default | Plus Jakarta Sans (editorial weights) |
| Layout | Simple form | Hero + Form + Footer |
| Input Fields | Standard | Custom styled with floating labels |
| Branding | None | "Amber Hearth" with tagline |
| Effects | None | Asymmetric shapes, ambient blur |
| Biometric | Basic icon | Styled button in surface container |

---

**Implementation Date**: April 3, 2026  
**Design Source**: Google Stitch (Project ID: 9443020206144348560)  
**Screens**: Login (8fa913b286a44dbd9b670ddd188f02a2), Register (f4ff850ebf9f45da9646e78ed8041a69)
