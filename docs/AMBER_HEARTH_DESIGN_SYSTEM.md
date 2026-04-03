# Amber Hearth Design System Implementation

## Overview
Amber Hearth is a high-end editorial design system implemented for the Delivery App. It bridges digital convenience with the warmth of a physical culinary experience, moving away from clinical "tech" aesthetics.

## ✅ Implementation Summary

### 1. Color Palette
**Primary Colors:**
- Primary: `#f49d25` (Amber) - Energy and heat
- Primary Light: `#ffc266`
- Primary Dark: `#c77700`

**Secondary Colors:**
- Secondary: `#9c7a49` (Muted Umber) - Sophisticated anchor
- Secondary Light: `#b89764`
- Secondary Dark: `#7d6038`

**Surface & Background:**
- Background: `#f8f7f5` - Warm neutral
- Surface: `#FFFFFF` - Pure white for maximum clarity
- Text Primary: `#212121`
- Text Secondary: `#9c7a49` - Warm muted (no grey!)

**Borders & Shadows:**
- Border: `#e8e4df` - Warm border
- Shadow: Amber-tinted (`#9c7a49` at 8% opacity)

### 2. Typography (Plus Jakarta Sans)
**Display & Headlines:**
- Display: 36px, Weight 900 (Black), -0.02 letter-spacing
- H1: 30px, Weight 800 (ExtraBold), -0.02 letter-spacing
- H2: 24px, Weight 800, -0.01 letter-spacing
- H3-H6: 20-14px, Weight 700 (Bold)

**Body Text:**
- Body Medium: 14px (0.875rem) - Primary size for legibility
- Body Large: 16px
- Body Small: 12px

**Labels & Micro:**
- Label Small: 10px for rating stars
- Overline: 10px, Weight 600, 1.2 letter-spacing

### 3. Elevation & Shadows
**Soft Stacking Principle:**
- Ambient shadows tinted with `#9c7a49` for warmth
- No harsh drop shadows
- Layering: Content → Surface → Background

**Shadow Levels:**
- `shadow-sm`: Standard cards (2px blur)
- `shadow-md`: Buttons, sticky headers
- `shadow-lg`: Hero images, active hover states

### 4. Components

#### Splash Screen
**Features:**
- Warm gradient background (Amber to darker orange)
- Glass-effect logo with backdrop blur (8px)
- Editorial typography with Black weight (900)
- Amber-tinted shadows for warmth
- Soft stacking elevation
- URBAN HEARTH tagline with 2.5 letter-spacing

**Key Elements:**
- Logo: 140x140 circle with glass effect
- Title: 48px, Weight 900, white color
- Tagline: "URBAN HEARTH" (12px, uppercase)
- Status: Pill-shaped container with backdrop blur
- Footer: "Fast • Fresh • Delivered" (14px)

#### Buttons
- Pill-shaped (`borderRadius: 24px`)
- Bold weight (700)
- Amber-tinted shadow
- Minimum padding: 32x16

#### Cards
- Pure white surface
- Soft-rounded corners (16px+)
- Amber-tinted shadow
- Image-first layout

### 5. Design Rules

**✅ DO:**
- Use Plus Jakarta Sans at 800-900 for headlines
- Use backdrop blur on floating elements
- Maintain xl (0.75rem) or full radius on interactive components
- Use `#9c7a49` for muted text (not grey)
- Ensure CTAs have amber-tinted shadows
- Create depth through layering, not harsh shadows

**❌ DON'T:**
- Use sharp corners on interactive components
- Use grey for text-muted
- Rely on 1px borders (except inputs in dark mode)
- Use pure black shadows

### 6. File Structure
```
lib/core/theme/
├── app_colors.dart          # Amber Hearth color palette
├── app_text_styles.dart     # Plus Jakarta Sans typography
├── app_theme.dart           # Theme configuration
├── app_dimensions.dart      # Spacing & sizing
├── theme_extensions.dart    # Context extensions
└── theme_provider.dart      # Riverpod theme state
```

### 7. Usage Examples

**Accessing Colors:**
```dart
final colors = context.colors;
Container(color: colors.primary);
Text('Hello', style: TextStyle(color: colors.textSecondary));
```

**Typography:**
```dart
Text('Headline', style: AppTextStyles.display);
Text('Body', style: AppTextStyles.bodyMedium);
```

**Shadows:**
```dart
BoxShadow(
  color: Color(0xFF9c7a49).withValues(alpha: 0.3),
  blurRadius: 32,
  offset: Offset(0, 8),
)
```

**Glass Effect:**
```dart
BackdropFilter(
  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
)
```

## Next Steps
1. Apply design system to all screens
2. Update restaurant cards with image-first layout
3. Implement promo banners with verified watermark
4. Create category cards with 16x16 icons
5. Design search bar with soft-rounded xl corners
6. Update buttons to pill-shaped with amber-tinted shadows

## Resources
- Design System: Amber Hearth (Urban Hearth concept)
- Font Family: Plus Jakarta Sans (weights: 400, 600, 700, 800, 900)
- Inspiration: Editorial food magazines, warm hearth aesthetic
