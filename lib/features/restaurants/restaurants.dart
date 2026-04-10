/// Restaurants feature barrel file
library;

// Screens
export 'presentation/screens/all_restaurants_screen.dart';
export 'presentation/screens/restaurant_detail_screen.dart';
export 'presentation/screens/menu_screen.dart';

// Providers
export 'presentation/providers/providers.dart';

// Domain exports
export 'domain/entities/restaurant_entity.dart';
export 'domain/entities/menu_item_entity.dart';
export 'domain/usecases/get_restaurants_usecase.dart';
export 'domain/usecases/get_restaurant_by_id_usecase.dart';
export 'domain/usecases/get_menu_items_usecase.dart';
export 'domain/usecases/search_restaurants_usecase.dart';
export 'domain/usecases/get_restaurants_nearby_usecase.dart';
export 'domain/repositories/restaurant_repository.dart';

// Data exports
export 'data/repositories_impl/restaurant_repository_impl.dart';
