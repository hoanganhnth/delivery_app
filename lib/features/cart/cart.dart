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

// Application state and dependency wiring
export 'application/cart_notifier.dart';
export 'application/cart_state.dart';
export 'di/cart_di_providers.dart';

// Cross-feature application boundary
export 'application/cart_commands.dart';
export 'di/cart_commands_provider.dart';

export 'presentation/screens/cart_screen.dart';
export 'presentation/screens/checkout_screen.dart';
export 'presentation/screens/order_confirmation_screen.dart';
