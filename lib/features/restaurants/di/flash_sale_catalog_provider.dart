/// Compatibility export. Flash Sale owns its catalog/repository boundary;
/// restaurant code keeps this import only while its callers migrate.
import '../../flash_sale/domain/entities/flash_sale_item_entity.dart';

export '../../flash_sale/data/repositories/flash_sale_repository_impl.dart';
export '../../flash_sale/di/flash_sale_providers.dart';
export '../../flash_sale/domain/entities/flash_sale_item_entity.dart';

typedef CatalogFlashSaleItem = FlashSaleItemEntity;
