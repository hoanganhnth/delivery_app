/// Flash Sale feature barrel file
library;

// Domain exports
export 'domain/entities/flash_sale_campaign_entity.dart';
export 'domain/entities/flash_sale_item_entity.dart';
export 'domain/repositories/flash_sale_repository.dart';
export 'domain/usecases/flash_sale_usecases.dart';

// Data exports
export 'data/datasources/flash_sale_api_service.dart';
export 'data/models/flash_sale_model.dart';
export 'data/repositories_impl/flash_sale_repository_impl.dart';

// Presentation exports
export 'presentation/providers/flash_sale_provider.dart';
export 'presentation/widgets/flash_sale_banner.dart';
export 'presentation/widgets/flash_sale_item_card.dart';
export 'presentation/widgets/countdown_timer.dart';
