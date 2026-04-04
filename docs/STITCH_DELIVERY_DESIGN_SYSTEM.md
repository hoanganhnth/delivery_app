# 🎨 Stitch Delivery App Design System

## Project Info
- **Project ID**: 9443020206144348560
- **Project Name**: Delivery (Amber Hearth)
- **Design Language**: Plus Jakarta Sans
- **Color Scheme**: Warm Orange/Amber with Umber accents

---

## 🎨 Color Palette

### Primary Colors
```dart
primary: Color(0xFFF49D25),           // Amber orange
onPrimary: Color(0xFFFFFFFF),         // White
primaryContainer: Color(0xFFFFEDD5),  // Light cream
onPrimaryContainer: Color(0xFFD6810D), // Dark amber
```

### Secondary Colors
```dart
secondary: Color(0xFF9C7A49),          // Umber brown
onSecondary: Color(0xFFFFFFFF),        // White
secondaryContainer: Color(0xFFFECB94), // Peach
onSecondaryContainer: Color(0xFF795427), // Dark brown
```

### Surface Colors
```dart
surface: Color(0xFFFFFFFF),            // Pure white
surfaceContainer: Color(0xFFF4EEE7),   // Cream
surfaceContainerHigh: Color(0xFFEDE7E0), // Warm gray
surfaceContainerHighest: Color(0xFFE6E0D9), // Darker warm gray
background: Color(0xFFF8F7F5),         // Off-white background
```

### Semantic Colors
```dart
onSurface: Color(0xFF1C160D),          // Almost black text
onSurfaceVariant: Color(0xFF9C7A49),   // Brown variant
outline: Color(0xFFD9C3AE),            // Warm gray border
outlineVariant: Color(0xFFF4EEE7),     // Light outline
```

### Error Colors
```dart
error: Color(0xFFBA1A1A),              // Red error
onError: Color(0xFFFFFFFF),            // White on error
errorContainer: Color(0xFFFFDAD6),     // Light red
```

---

## 📐 Typography (Plus Jakarta Sans)

### Display
- **Font Weight**: 900 (Black)
- **Tracking**: Tighter (-0.02em)
- **Use case**: Hero text, main headings

### Headline
- **Font Weight**: 800 (ExtraBold)
- **Tracking**: Tight (-0.01em)
- **Use case**: Section headers, restaurant names

### Title
- **Font Weight**: 700 (Bold)
- **Tracking**: Normal
- **Use case**: Card titles, item names

### Body
- **Font Weight**: 400-500 (Regular-Medium)
- **Tracking**: Normal
- **Use case**: Body text, descriptions

### Label
- **Font Weight**: 600-700 (SemiBold-Bold)
- **Letter Spacing**: Widest (0.1-0.2em)
- **Transform**: Uppercase
- **Use case**: Tags, badges, tiny labels

---

## 🔲 Border Radius System

```dart
radiusSmall: 4,     // Minimal roundness
radiusDefault: 8,   // Standard buttons, inputs
radiusMedium: 12,   // Cards
radiusLarge: 16,    // Large cards
radiusXL: 24,       // Hero elements
radius2XL: 32,      // Mega cards
radius3XL: 40,      // Restaurant cards
radiusFull: 9999,   // Pills, circular buttons
```

---

## 🎭 Component Patterns

### 1. **Bottom Navigation** (Floating Dark)
- **Style**: Floating dark pill navigation
- **Position**: Fixed bottom with 24px margin
- **Background**: Dark stone (stone-900) with rounded-full
- **Active State**: Elevated orange pill with translate-y effect
- **Shadow**: Subtle orange glow (shadow-orange-900/20)

### 2. **App Bar** (Sticky Glass)
- **Style**: Sticky glass morphism
- **Background**: White/90 with backdrop-blur
- **Shadow**: Subtle shadow-sm
- **Height**: 64px with px-6 py-4

### 3. **Search Bar**
- **Style**: Elevated white with inner button
- **Border Radius**: 12px (rounded-xl)
- **Height**: 56px (h-14)
- **Shadow**: shadow-md
- **Focus Ring**: primary/50 opacity

### 4. **Category Pills**
- **Style**: Icon + Label vertical layout
- **Size**: 64x64px icon container
- **Hover Effect**: -translate-y-1
- **Active**: Primary background with shadow-lg
- **Inactive**: White with border

### 5. **Restaurant Cards**
- **Border Radius**: 40px (rounded-[2.5rem])
- **Image Height**: 192px (h-48)
- **Hover**: Image scale-105 transition-500
- **Badge Position**: Absolute top-4 right-4
- **Time Badge**: Bottom-4 left-4 with backdrop-blur

### 6. **Cart Item Card**
- **Style**: Horizontal layout with image + content + quantity
- **Border Radius**: 32px (rounded-[2rem])
- **Image**: 96x96px rounded-2xl
- **Quantity Control**: Vertical pill with shadow-inner
- **Hover**: shadow-md elevation

### 7. **Checkout Sections**
- **Border Radius**: 12px (rounded-xl)
- **Border**: border-outline-variant
- **Padding**: p-5
- **Shadow**: shadow-sm

---

## 🎯 Key Design Elements

### Flash Sale Section
- **Background**: primary/5 with pattern overlay
- **Badge**: Animated bolt icon
- **Countdown**: Dark chips with white text
- **Item Cards**: Discount badges (error color)

### Restaurant Header (Cart)
- **Style**: White card with rounded-3xl
- **Logo Size**: 64x64px rounded-2xl
- **Badge**: "Đang đặt tại" uppercase label
- **Watermark**: Large verified icon (primary/5)

### Pro Membership Banner
- **Background**: stone-900 (dark)
- **Border Radius**: 40px (rounded-[2.5rem])
- **Badge**: Amber border with glow
- **CTA**: Primary button with shadow-primary/40

---

## 📱 Screen-Specific Guidelines

### Home Screen
- **Header**: Sticky with "Amber Hearth" branding + search icon
- **Search Bar**: Prominent with "Find" button
- **Categories**: Horizontal scroll with active selection
- **Flash Sale**: Full-width promo section
- **Restaurants**: Vertical list with rich metadata
- **Bottom Nav**: Floating dark with Home active

### Restaurant Details
- **Hero Image**: 320px height with gradient overlay
- **Actions**: Floating glass buttons (back, share, favorite)
- **Content**: Negative margin (-mt-10) for overlap effect
- **Info Pills**: Horizontal scroll (time, distance, fee)
- **Menu Items**: Vertical list with add-to-cart

### Cart Screen
- **Header**: Sticky with back + delete all
- **Restaurant Card**: Featured with logo and rating
- **Items List**: Vertical with quantity controls
- **Checkout Button**: Fixed bottom with summary

### Checkout Screen
- **Header**: Simple with back + avatar
- **Sections**: Spaced with clear hierarchy
- **Address Card**: Icon + content layout
- **Order Summary**: Collapsed items list
- **Payment**: Fixed bottom with breakdown

---

## 🔧 Flutter Implementation Notes

### Material 3 Integration
```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: Color(0xFFF49D25),
    secondary: Color(0xFF9C7A49),
    surface: Colors.white,
    background: Color(0xFFF8F7F5),
    // ... rest of colors
  ),
  textTheme: GoogleFonts.plusJakartaSansTextTheme(),
)
```

### Custom Extensions
- Create `context.colors` for easy color access
- Create `context.textStyles` for typography
- Use `flutter_screenutil` for responsive sizing

### Key Widgets to Create
1. `AmberBottomNavBar` - Floating dark navigation
2. `CategoryPill` - Icon + label combo
3. `RestaurantCard` - Rich card with image overlay
4. `CartItemWidget` - Horizontal cart item
5. `FlashSaleSection` - Promo banner with countdown
6. `GlassAppBar` - Sticky glass morphism header

---

## 🎬 Animation Guidelines

### Transitions
- **Duration**: 300-500ms for most interactions
- **Curve**: Default ease-out
- **Scale**: active:scale-90 or active:scale-95
- **Translate**: -translate-y-1 or -translate-y-2 on hover

### Hover Effects
- **Image**: scale-105 with duration-500
- **Cards**: shadow elevation increase
- **Buttons**: opacity-90 or scale-95

---

## 📦 Dependencies Required

```yaml
dependencies:
  google_fonts: ^latest      # Plus Jakarta Sans
  flutter_screenutil: ^latest # Responsive sizing
  cached_network_image: ^latest # Image caching
  shimmer: ^latest          # Loading states
  ```
  
---

## ✅ Implementation Checklist

### Phase 1: Core Design System
- [x] Color palette defined
- [ ] Theme extensions created
- [ ] Typography system configured
- [ ] Border radius constants

### Phase 2: Component Library
- [ ] Bottom navigation widget
- [ ] Category pill widget
- [ ] Restaurant card widget
- [ ] Cart item widget
- [ ] Checkout section widgets

### Phase 3: Screen Implementation
- [ ] Home screen redesign
- [ ] Restaurant details redesign
- [ ] Cart screen redesign
- [ ] Checkout screen redesign

### Phase 4: Polish
- [ ] Animations and transitions
- [ ] Loading states
- [ ] Empty states
- [ ] Error states

---

**Design Token Version**: 1.0.0  
**Last Updated**: April 3, 2026  
**Stitch Project**: Amber Hearth Delivery App
