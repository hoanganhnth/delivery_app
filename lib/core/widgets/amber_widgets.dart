/// Core widgets barrel file
/// 
/// Exports all generic, reusable UI components built for the Amber Hearth design system.
/// Feature-specific widgets (like CartItems or RestaurantCards) are located in their respective feature folders.
library;

// Layout & Structure
export 'layout/amber_bottom_nav_bar.dart';
export 'layout/glass_app_bar.dart';
export 'layout/editorial_header.dart';

// Inputs
export 'inputs/amber_search_bar.dart';

// Cards & Containers
export 'cards/glassmorphic_card.dart';

// Sections & Complex UI
export 'sections/flash_sale_section.dart';

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
