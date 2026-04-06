# Stitch Design Analysis - Delivery App

## 🎨 Design System từ Stitch

### Color Palette (Material Design 3)
```dart
// Primary Colors
primary: #F49D25 (Orange - Amber brand color)
onPrimary: #FFFFFF
primaryContainer: #FFEDD5
onPrimaryContainer: #D6810D
primaryFixed: #FFDDBA
primaryFixedDim: #FFB866

// Secondary Colors
secondary: #9C7A49 (Brown/Tan)
onSecondary: #FFFFFF
secondaryContainer: #FECB94
onSecondaryContainer: #795427
secondaryFixed: #FFDDBA
secondaryFixedDim: #EFBD87

// Tertiary (Error/Live indicator)
tertiary: #BA1A1A (Red)
tertiaryContainer: #FFDAD6
onTertiary: #FFFFFF

// Surface & Background
background: #F8F7F5 (Warm off-white)
surface: #FFFFFF
surfaceContainerLowest: #FFFFFF
surfaceContainerLow: #F8F7F5
surfaceContainer: #F4EEE7
surfaceContainerHigh: #EDE7E0
surfaceContainerHighest: #E6E0D9

// Text Colors
onSurface: #1C160D (Dark brown)
onBackground: #1C160D
onSurfaceVariant: #9C7A49

// Outline
outline: #D9C3AE
outlineVariant: #F4EEE7
```

### Typography (Plus Jakarta Sans)
```dart
// Font Family: Plus Jakarta Sans (200-900 weights)
headline: Plus Jakarta Sans
body: Plus Jakarta Sans
label: Plus Jakarta Sans

// Specific Styles Found:
- Brand Name: font-black (900), tracking-tighter, italic, text-xl
- Section Titles: text-4xl, font-black, tracking-tighter, leading-none
- Card Titles: text-sm to text-2xl, font-bold to font-black
- Labels: text-[10px], font-black, uppercase, tracking-widest
- Body: text-sm, font-medium
```

### Border Radius
```dart
DEFAULT: 0.25rem (4px)
lg: 0.5rem (8px)
xl: 0.75rem (12px)
full: 9999px (circular)

// Custom Roundness (Editorial Style):
- Cards: rounded-[2rem] to rounded-[2.5rem] (32-40px)
- Buttons: rounded-full
- Tags: rounded-lg to rounded-full
```

### Shadows
```dart
// Editorial Shadow (custom)
editorial-shadow: 0 10px 30px -10px rgba(156, 122, 73, 0.2)

// Standard MD3 shadows
shadow-md, shadow-lg, shadow-xl
```

---

## 📱 Screen 1: Foodie Live - Dark Nav

### Layout Structure
```
TopAppBar (sticky)
  ├─ Profile Avatar (rounded-full, border-2 border-primary)
  ├─ Brand "Amber Hearth" (italic, amber-500)
  └─ Search Icon

Main Content (px-6, pt-4, pb-32)
  ├─ Editorial Header
  │   ├─ Live Now indicator (h-2 w-8 bg-primary rounded-full)
  │   ├─ Title "The Kitchen Pulse" (text-4xl, tracking-tighter)
  │   └─ Subtitle
  │
  ├─ Featured Bento Card (h-[420px], rounded-[2.5rem])
  │   ├─ Image with gradient overlay
  │   ├─ Live Tag (bg-tertiary, rounded-full, animate-ping)
  │   ├─ Viewer count (backdrop-blur-md)
  │   ├─ Chef info
  │   └─ CTA Button (bg-primary, rounded-full, shadow)
  │
  ├─ Category Pills (horizontal scroll)
  │   └─ Pills (rounded-full, active: bg-primary)
  │
  └─ Livestream Grid (grid-cols-2, gap-4)
      └─ Cards (aspect-[3/4], rounded-[2rem])
          ├─ Image (hover:scale-105)
          ├─ LIVE tag (top-left)
          ├─ Host info (bottom-left, backdrop-blur)
          └─ Title + viewer count

BottomNavBar (fixed bottom-6, rounded-full, dark)
  └─ 4 tabs: Home, Live (active), Orders, Profile
```

### Key Components

#### 1. Live Indicator Badge
```html
<div class="bg-tertiary rounded-full px-4 py-2 shadow-lg">
  <span class="animate-ping bg-white rounded-full"></span>
  <span class="text-white text-[10px] font-black uppercase tracking-widest">Live Now</span>
</div>
```

#### 2. Livestream Card
```html
<div class="aspect-[3/4] rounded-[2rem] overflow-hidden editorial-shadow">
  <img class="group-hover:scale-105 transition-transform duration-500" />
  <div class="LIVE tag top-4 left-4"></div>
  <div class="Host info bottom-4 left-4 backdrop-blur-sm"></div>
</div>
```

#### 3. Bottom Navigation (Dark Pill)
```html
<nav class="fixed bottom-6 rounded-full bg-stone-900/95 backdrop-blur-lg shadow-lg max-w-md">
  <a class="text-orange-500 bg-white/10 rounded-full">
    <span class="material-symbols-outlined FILL">live_tv</span>
  </a>
</nav>
```

---

## 📱 Screen 2: Livestream Detail

### Layout Structure
```
Full Screen Video Container (h-screen, bg-stone-950)
  ├─ Background Video/Image (with editorial vignette overlay)
  │
  ├─ Top Header (sticky, z-50)
  │   ├─ Back Button (rounded-full, backdrop-blur-md)
  │   ├─ Chef Info Card (backdrop-blur-xl, border-white/10)
  │   │   ├─ Avatar (border-2 border-primary)
  │   │   ├─ Name + Live indicator (animate-pulse red dot)
  │   │   └─ Viewer count
  │   ├─ Premium Badge (bg-primary, rounded-full)
  │   └─ Share Button
  │
  ├─ Product Card (absolute top-28 right-6, glassmorphism)
  │   ├─ Product Image (aspect-square, rounded-xl)
  │   ├─ Discount Badge (top-left, bg-primary)
  │   ├─ Title + Price
  │   └─ Add to Cart Button (hover:bg-primary)
  │
  └─ Bottom Canvas (absolute bottom-0, flex md:flex-row)
      ├─ Chat Section (scrolling-chat, mask-fade-top)
      │   └─ Messages (backdrop-blur, rounded-2xl)
      │
      └─ Interaction Buttons (Like, Share, Gift)
```

### Key Components

#### 1. Glassmorphism Product Card
```html
<div class="bg-white/10 backdrop-blur-2xl border border-white/20 rounded-2xl shadow-2xl">
  <img class="rounded-xl aspect-square" />
  <div class="bg-primary text-white text-[10px] font-black">20% OFF</div>
  <button class="bg-white text-stone-900 hover:bg-primary hover:text-white">
    Add to Cart
  </button>
</div>
```

#### 2. Live Chat Message
```html
<div class="bg-white/10 backdrop-blur-xl rounded-2xl px-4 py-3 border border-white/20">
  <div class="flex items-center gap-2 mb-1">
    <img class="w-6 h-6 rounded-full" />
    <span class="text-white text-xs font-bold">Username</span>
  </div>
  <p class="text-white/90 text-sm">Message text</p>
</div>
```

#### 3. Editorial Vignette Overlay
```css
.editorial-overlay {
  background: linear-gradient(
    to bottom,
    rgba(0,0,0,0.6) 0%,
    rgba(0,0,0,0) 25%,
    rgba(0,0,0,0) 60%,
    rgba(0,0,0,0.8) 100%
  );
}
```

---

## 📱 Screen 3: Customer Support

### Layout Structure
```
TopAppBar (sticky, backdrop-blur-lg)
  ├─ Back Button
  ├─ Order Info
  │   ├─ Order #8821 (font-black, tracking-tighter)
  │   └─ "Hearth Support" label (text-[10px], uppercase)
  ├─ Support Specialist Avatar (border-2 border-primary)
  └─ Search Icon

Chat Canvas (flex-1, overflow-y-auto, pb-40)
  ├─ Date Divider (bg-surface-container, rounded-full)
  │
  ├─ Support Messages (left-aligned, max-w-[85%])
  │   ├─ Icon Badge (rounded-full, bg-primary-container)
  │   ├─ Message Bubble (rounded-2xl, rounded-tl-none)
  │   └─ Timestamp (text-[10px])
  │
  ├─ User Messages (right-aligned, bg-primary)
  │   ├─ Avatar (rounded-full)
  │   ├─ Message Bubble (rounded-tr-none, shadow-orange-100)
  │   └─ Timestamp
  │
  ├─ Typing Indicator
  │   └─ 3 dots (animate-pulse with delays)
  │
  └─ Contextual Card (rounded-3xl, border, watermark icon)

Bottom Input Bar (fixed, backdrop-blur-lg)
  ├─ Attach Button
  ├─ Text Input (rounded-full, bg-white)
  └─ Send Button (bg-primary, rounded-full)
```

### Key Components

#### 1. Support Message Bubble
```html
<div class="flex gap-3 max-w-[85%]">
  <div class="w-8 h-8 rounded-full bg-primary-container">
    <span class="material-symbols-outlined">support_agent</span>
  </div>
  <div class="space-y-1">
    <div class="bg-white rounded-2xl rounded-tl-none border border-outline-variant p-4">
      <p class="text-sm leading-relaxed">Message text</p>
    </div>
    <span class="text-[10px] text-on-surface-variant">14:02</span>
  </div>
</div>
```

#### 2. User Message Bubble
```html
<div class="flex flex-row-reverse gap-3 max-w-[85%] ml-auto">
  <img class="w-8 h-8 rounded-full" />
  <div class="space-y-1 text-right">
    <div class="bg-primary rounded-2xl rounded-tr-none shadow-md p-4">
      <p class="text-sm text-white">Message text</p>
    </div>
    <span class="text-[10px]">14:05</span>
  </div>
</div>
```

#### 3. Typing Indicator
```html
<div class="bg-surface-container-high rounded-full px-4 py-3 flex gap-1">
  <div class="w-1.5 h-1.5 bg-secondary rounded-full animate-pulse"></div>
  <div class="w-1.5 h-1.5 bg-secondary rounded-full animate-pulse delay-75"></div>
  <div class="w-1.5 h-1.5 bg-secondary rounded-full animate-pulse delay-150"></div>
</div>
```

#### 4. Input Bar
```html
<div class="fixed bottom-0 bg-white/90 backdrop-blur-lg shadow-lg px-6 py-4">
  <div class="flex items-center gap-3 bg-surface-container-low rounded-full">
    <button class="text-secondary">
      <span class="material-symbols-outlined">attach_file</span>
    </button>
    <input class="flex-1 bg-transparent text-sm" placeholder="Type here..." />
    <button class="bg-primary text-white rounded-full w-10 h-10">
      <span class="material-symbols-outlined">send</span>
    </button>
  </div>
</div>
```

---

## 📱 Screen 2: Livestream Detail

### Layout Structure

---

## 🎯 Implementation Checklist

### Theme Updates Needed
- [ ] Add Plus Jakarta Sans font to pubspec.yaml
- [ ] Update AppColors với Material 3 palette
- [ ] Add editorial-shadow to theme
- [ ] Update border radius (rounded-[2rem])

### Widgets to Create/Update
- [ ] LiveIndicatorBadge (animated ping)
- [ ] LivestreamCard (với backdrop-blur, hover effects)
- [ ] EditorialHeader (với decorative line)
- [ ] CategoryPillList (horizontal scroll)
- [ ] DarkBottomNavBar (floating dark pill)

### Screen Updates
- [ ] `all_livestreams_screen.dart` → Match Foodie Live design
- [ ] `livestream_detail_screen.dart` → Match detail design
- [ ] `support_chat_screen.dart` → Match customer support design

### Assets Needed
- [ ] Plus Jakarta Sans font files (or Google Fonts package)
- [ ] Material Symbols Outlined icons (or use Flutter Icons)

---

## 💡 Design Principles Observed

1. **Editorial Style**: Large rounded corners (2-2.5rem), custom shadows
2. **Dark Accents**: Bottom nav uses dark bg with amber accents
3. **Hierarchy**: Clear visual hierarchy with bold typography
4. **Live Emphasis**: Red badges with animation for live content
5. **Backdrop Blur**: Used extensively for overlays
6. **Hover States**: Scale transforms on cards (1.05x)
7. **Spacing**: Generous padding (px-6, gap-4)
8. **Grid**: Staggered grid with translate-y offsets for visual interest
