/// Cart feature barrel file
library;

// Domain exports
export 'domain/entities/cart_entity.dart';
export 'domain/entities/cart_item_entity.dart';
export 'domain/repositories/cart_repository.dart';
export 'domain/usecases/cart_usecases.dart';

// Data exports
export 'data/datasources/cart_local_datasource.dart';
export 'data/datasources/cart_local_datasource_impl.dart';
export 'data/dtos/cart_dto.dart';
export 'data/dtos/cart_item_dto.dart';
export 'data/repositories_impl/cart_repository_impl.dart';

// Presentation exports
export 'presentation/providers/providers.dart'; // Barrel export for all providers
export 'presentation/providers/cart_state.dart';
export 'presentation/providers/cart_notifier.dart';
export 'presentation/providers/cart_providers.dart';
export 'presentation/screens/cart_screen.dart';
export 'presentation/screens/checkout_screen.dart';
export 'presentation/screens/payment_screen.dart';
export 'presentation/screens/order_confirmation_screen.dart';
