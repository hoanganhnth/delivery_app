/// Core widgets barrel file
///
/// Exports all generic, reusable UI components built for the Amber Hearth design system.
/// Feature-specific widgets (like CartItems or RestaurantCards) are located in their respective feature folders.
library;

// Canonical token-driven primitives. Legacy Amber widgets remain exported
// below while callers migrate incrementally.
export '../design_system/components/app_button.dart';
export '../design_system/components/app_feedback.dart';
export '../design_system/components/app_fields.dart';
export '../design_system/components/app_image.dart';
export '../design_system/components/app_indicators.dart';
export '../design_system/components/app_navigation.dart';
export '../design_system/components/app_surface.dart';

// Layout & Structure
export 'layout/amber_bottom_nav_bar.dart';
export 'layout/glass_app_bar.dart';
export 'layout/editorial_header.dart';

// Inputs
export 'inputs/amber_search_bar.dart';

// Cards & Containers
export 'cards/glassmorphic_card.dart';

// Sections & Complex UI

// Chips & Indicators
export 'chips/category_pill.dart';

// Media
export 'media/app_image.dart';

// Error UI
export 'errors/error_screens.dart';

// Feedback & Toast
export 'feedback/toast/toast_extensions.dart';
export 'feedback/toast/toast_provider.dart';
export 'feedback/toast/toast_utils.dart';
