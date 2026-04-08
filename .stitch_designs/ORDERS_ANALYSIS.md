# Orders Feature - Stitch Design Analysis

## 🎨 Design System

### **Orders List** (a03975b2cb3f47eda3a5f39442d6fd76)
**Dimensions:** 780x2248 (Mobile)

**Key Elements:**
1. **TopAppBar (Fixed)**
   - Height: 80px (20.h)
   - Background: `bg-white/90` với `backdrop-blur-md`
   - Shadow: `shadow-md`
   - Avatar: 40px circle với `border-2 border-primary` + `ring-2 ring-primary-container`
   - Title: "Amber Hearth" - `font-black tracking-tighter text-2xl italic text-orange-500`
   - Search icon button

2. **Header Section**
   - Title: "Your Orders" - `text-4xl font-black tracking-tighter`
   - Subtitle: "Track your current cravings and past delights." - `text-secondary font-medium`

3. **Filter Tabs**
   - Horizontal scroll với `no-scrollbar`
   - Active: `bg-primary text-on-primary font-bold shadow-md shadow-orange-200`
   - Inactive: `bg-surface-container-high text-secondary font-bold hover:bg-surface-container-highest`
   - Rounded: `rounded-full`
   - Padding: `px-6 py-2.5`

4. **Order Cards**
   - Container: `rounded-3xl` với `border border-outline-variant`
   - Padding: `p-5`
   - Image: 96px (24.w/h) `rounded-2xl` với `group-hover:scale-110 transition`
   - Status Badges:
     - In Transit: `bg-primary/10 text-primary` + uppercase + `tracking-widest` + `text-[10px] font-black`
     - Completed: `bg-secondary-container text-on-secondary-container`
     - Cancelled: `bg-error-container text-on-error-container`
   - Restaurant name: `font-black text-xl tracking-tight`
   - Date + items: `text-secondary text-sm font-semibold`
   - Price: `font-black text-lg`
   - Action: "Track Order" / "View Details" / "Reorder" với icon

5. **Visual States**
   - Active Order: Full opacity, white bg, colored badge
   - Completed: `opacity-90`, `bg-surface-container-low`, `grayscale-[0.2]` on image
   - Cancelled: `opacity-75`, `grayscale` on image

6. **Bottom Navigation**
   - Fixed bottom: `bottom-6`
   - Dark pill: `bg-stone-900/95 backdrop-blur-lg rounded-full shadow-lg`
   - Icons: `material-symbols-outlined`
   - Active: `text-orange-500 bg-white/10 rounded-full` với `FILL 1`
   - Labels: `text-[10px] font-bold uppercase tracking-widest`

---

### **Track Order - Dark Nav** (b1b535102dc84e5ab1d3f4de004162d6)
**Dimensions:** 780x3256 (Mobile, scrollable)

**Design:** Chi tiết tracking với map, timeline, và order items

---

### **Track Order - In Transit Detail** (a210d6cbd35a47a99337c39c93cf6f0d)
**Dimensions:** 780x2546 (Mobile)

**Design:** Focus vào courier tracking với real-time updates

---

### **Order Delivered Detail** (08c4400f404f4659832e830f33a52db3)
**Dimensions:** 780x3558 (Mobile, scrollable)

**Design:** Full order receipt với rating, items, payment summary

---

## 🎯 Implementation Plan

### Phase 1: Orders List Screen
- [ ] Create `OrderCard` widget với 3 states (Active, Completed, Cancelled)
- [ ] Create `OrderStatusBadge` widget
- [ ] Create `FilterTabBar` widget
- [ ] Implement TopAppBar với avatar + brand name
- [ ] Add Bottom Navigation
- [ ] Implement animations (hover scale, grayscale effects)

### Phase 2: Track Order Screen
- [ ] Create `OrderTrackingMap` widget
- [ ] Create `DeliveryTimeline` widget
- [ ] Create `CourierInfoCard` widget
- [ ] Create `OrderItemsList` widget

### Phase 3: Order Details Screen
- [ ] Create `OrderReceiptCard` widget
- [ ] Create `RatingSection` widget
- [ ] Create `PaymentSummary` widget
- [ ] Create `DeliveryAddressCard` widget

---

## 📦 Widget Structure

```
lib/features/order/
├── domain/
│   └── entities/
│       ├── order_entity.dart
│       └── order_item_entity.dart
├── presentation/
│   ├── screens/
│   │   ├── orders_list_screen.dart
│   │   ├── track_order_screen.dart
│   │   └── order_detail_screen.dart
│   └── widgets/
│       ├── order_card.dart              # NEW
│       ├── order_status_badge.dart      # NEW
│       ├── filter_tab_bar.dart          # NEW
│       ├── delivery_timeline.dart       # NEW
│       ├── courier_info_card.dart       # NEW
│       └── order_receipt_card.dart      # NEW
```

---

## 🎨 Color Mapping (Stitch → Flutter Theme)

| Stitch Color | Theme Color | Usage |
|--------------|-------------|-------|
| `primary: #f49d25` | `colors.primary` | Active tabs, badges, buttons |
| `secondary: #9c7a49` | `colors.textSecondary` | Subtitles, inactive states |
| `on-background: #1c160d` | `colors.textPrimary` | Main text, prices |
| `surface-container-high: #ede7e0` | `colors.cardBackground` | Inactive tabs |
| `outline-variant: #f4eee7` | `colors.border` | Card borders |
| `error: #ba1a1a` | `colors.error` | Cancelled badge background |

---

## 🔧 Key Features

1. **Filter Persistence** - Remember selected filter (All/Active/Completed)
2. **Pull-to-Refresh** - Refresh orders list
3. **Empty States** - "No orders yet" illustration
4. **Skeleton Loading** - Shimmer effect while loading
5. **Real-time Updates** - Stream order status changes
6. **Image Caching** - Cache restaurant images
7. **Smooth Animations** - Card hover, tab transitions
8. **Accessibility** - Semantic labels for all interactive elements

---

## 📊 Typography

| Element | Style |
|---------|-------|
| Screen Title | `fontSize: ResponsiveSize.fontXxl, fontWeight: FontWeight.w900, letterSpacing: -1` |
| Subtitle | `fontSize: ResponsiveSize.fontM, fontWeight: FontWeight.w500` |
| Restaurant Name | `fontSize: ResponsiveSize.fontXl, fontWeight: FontWeight.w900` |
| Order Info | `fontSize: ResponsiveSize.fontS, fontWeight: FontWeight.w600` |
| Price | `fontSize: ResponsiveSize.fontL, fontWeight: FontWeight.w900` |
| Badge | `fontSize: 10.sp, fontWeight: FontWeight.w900, letterSpacing: 1.5` |

---

**Next:** Implement `OrderCard`, `OrderStatusBadge`, and `FilterTabBar` widgets
